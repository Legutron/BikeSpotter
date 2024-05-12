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

public class Api {
	
	// Singleton
	static let shared = Api(decoder: .init())
	let decoder: JSONDecoder
	
	private init(decoder: JSONDecoder = .init()) {
		self.decoder = decoder
	}
	
	func fetchStations() async throws -> [StationSpotData] {
		async let stations = try fetchStationInformation()
		async let statuses = try fetchStationStatuses()
		var data = try await StationData(stations: stations, statuses: statuses).filteredActive()
		if let userLocation = Location.shared.currentLocation {
			data = data.map { station in
				var updatedStation = station
				updatedStation.distance = Location.shared.getDistanceInMeters(
					coordinate1: userLocation,
					coordinate2: station.location
				)
				return updatedStation
			}
			data.sort(by: { $0.distance ?? 999 < $1.distance ?? 999 })
		}
		return data
	}
	
	private func fetchStationInformation() async throws -> StationInformationModel {
		guard let url: URL = .init(string: ApiKeys.stationInfoURL) else {
			throw ApiError.invalidURL("Unknown URL")
		}
		var request = URLRequest(url: url)
		request.httpMethod = "GET"
		let (data, response) = try await URLSession.shared.data(for: request)
		print("🛜\(response)")
		guard let httpResponse = response as? HTTPURLResponse else {
			throw ApiError.badServerResponse("Unknown Error")
		}
		if (300..<500).contains(httpResponse.statusCode) {
			throw ApiError.badServerResponse(httpResponse.description)
		}
		guard let stations =  try? decoder.decode(StationInformationModel.self, from: data) else {
			throw ApiError.unknownDataType("Couldn't decode data")
		}
		return stations
	}
	
	private func fetchStationStatuses() async throws -> StationStatusesModel {
		guard let url: URL = .init(string: ApiKeys.stationStatusURL) else {
			throw ApiError.invalidURL("Unknown URL")
		}
		var request = URLRequest(url: url)
		request.httpMethod = "GET"
		let (data, response) = try await URLSession.shared.data(for: request)
		print("🛜\(response)")
		guard let httpResponse = response as? HTTPURLResponse else {
			throw ApiError.badServerResponse("Unknown Error")
		}
		if (300..<500).contains(httpResponse.statusCode) {
			throw ApiError.badServerResponse(httpResponse.description)
		}
		guard let statuses =  try? decoder.decode(StationStatusesModel.self, from: data) else {
			throw ApiError.unknownDataType("Couldn't decode data")
		}
		return statuses
	}
}
