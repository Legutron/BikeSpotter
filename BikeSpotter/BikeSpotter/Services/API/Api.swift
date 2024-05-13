//
//  Api.swift
//  BikeSpotter
//
//  Created by Jakub Legut on 10/05/2024.
//

import Foundation

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
	
	func fetchStations() async throws -> [StationData] {
		/*
		COMMENT:
		fetching data on the asynchronously using async let,
		it would be nice to use pagination here and send the user coordinates data
		to received sorted items.
		*/
		guard
			let stationInfoURL = URL(string: ApiKeys.stationInfoURL),
			let stationStatusURL = URL(string: ApiKeys.stationStatusURL)
		else {
			throw ApiError.invalidURL("Unknown URL")
		}
		
		async let stations = apiGETrequest(url: stationInfoURL, type: StationInformationModel.self)
		async let statuses = apiGETrequest(url: stationStatusURL, type: StationStatusesModel.self)
		var data = try await ApiMapper.transform(stations: stations, statuses: statuses)
		
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
}

// MARK: - Helpers
extension Api {
	private func apiGETrequest<T: Codable>(url: URL, type: T.Type) async throws -> T {
		var request = URLRequest(url: url)
		request.httpMethod = "GET"
		let (data, response) = try await URLSession.shared.data(for: request)
		guard let httpResponse = response as? HTTPURLResponse else {
			throw ApiError.badServerResponse("Unknown Error")
		}
		if (300..<500).contains(httpResponse.statusCode) {
			throw ApiError.badServerResponse(httpResponse.description)
		}
		guard let result = try? decoder.decode(type, from: data) else {
			throw ApiError.unknownDataType("Couldn't decode data")
		}
		return result
	}
}
