//
//  Api.swift
//  BikeSpotter
//
//  Created by Jakub Legut on 10/05/2024.
//

import Foundation
import Combine

enum ApiKeys {
	static let stationInfoURL: String = "https://gbfs.urbansharing.com/rowermevo.pl/station_information.json"
	static let stationStatusURL: String = "https://gbfs.urbansharing.com/rowermevo.pl/station_status.json"
}

// Singleton pattern
public class Api {
	enum Constants {
		static let defaultDistance: Int = Int.max
	}
	
	
	static let shared = Api(decoder: .init())
	let decoder: JSONDecoder
	
	private init(decoder: JSONDecoder = .init()) {
		self.decoder = decoder
	}
	
	func fetchStations() -> AnyPublisher<[StationData], ApiError> {
		guard
			let stationInfoURL = URL(string: ApiKeys.stationInfoURL),
			let stationStatusURL = URL(string: ApiKeys.stationStatusURL)
		else {
			return Fail(error: ApiError.invalidURL("Unknown URL"))
				.eraseToAnyPublisher()
		}
		
		let stationsPublisher = apiGETrequest(
			url: stationInfoURL,
			type: StationInformationModel.self
		)
		let statusesPublisher = apiGETrequest(
			url: stationStatusURL,
			type: StationStatusesModel.self
		)
		
		return Publishers.Zip(stationsPublisher, statusesPublisher)
			.tryMap { stations, statuses in
				var data = ApiMapper
					.transform(
						stations: stations,
						statuses: statuses
					)
				
				if let userLocation = Location.shared.currentLocation {
					data = data.map { station in
						var updatedStation = station
						updatedStation.distance = Location.shared.getDistanceInMeters(
							coordinate1: userLocation,
							coordinate2: station.location
						)
						return updatedStation
					}
					data.sort(by: { $0.distance ?? Constants.defaultDistance < $1.distance ?? Constants.defaultDistance })
				}
				return data
			}
			.mapError { error in
				return error as? ApiError ?? ApiError.unknown(error.localizedDescription)
			}
			.eraseToAnyPublisher()
	}
}

// MARK: - Helpers
extension Api {
	func apiGETrequest<T: Decodable>(url: URL, type: T.Type) -> AnyPublisher<T, ApiError> {
		URLSession.shared.dataTaskPublisher(for: url)
			.tryMap { data, response in
				guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
					throw ApiError.unknownDataType("Invalid response from server")
				}
				return data
			}
			.decode(type: T.self, decoder: JSONDecoder())
			.mapError { error in
				return error as? ApiError ?? ApiError.unknown(error.localizedDescription)
			}
			.eraseToAnyPublisher()
	}
}
