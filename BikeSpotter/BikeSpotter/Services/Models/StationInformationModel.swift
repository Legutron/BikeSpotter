//
//  Stations.swift
//  BikeSpotter
//
//  Created by Jakub Legut on 10/05/2024.
//

import Foundation

// MARK: - StationInformationModel
struct StationInformationModel: Codable {
	let lastUpdated, ttl: Int
	let version: String
	let data: DataClass

	enum CodingKeys: String, CodingKey {
		case lastUpdated = "last_updated"
		case ttl, version, data
	}
}

// MARK: - DataClass
struct DataClass: Codable {
	let stations: [Station]
}

// MARK: - Station
struct Station: Codable {
	let stationID, name, address, crossStreet: String
	let lat, lon: Double
	let isVirtualStation: Bool
	let capacity: Int
	let stationArea: StationArea
	let rentalUris: RentalUris

	enum CodingKeys: String, CodingKey {
		case stationID = "station_id"
		case name, address
		case crossStreet = "cross_street"
		case lat, lon
		case isVirtualStation = "is_virtual_station"
		case capacity
		case stationArea = "station_area"
		case rentalUris = "rental_uris"
	}
}

// MARK: - RentalUris
struct RentalUris: Codable {
	let android, ios: String
}

// MARK: - StationArea
struct StationArea: Codable {
	let type: TypeEnum
	let coordinates: [[[[Double]]]]
}

enum TypeEnum: String, Codable {
	case multiPolygon = "MultiPolygon"
}

