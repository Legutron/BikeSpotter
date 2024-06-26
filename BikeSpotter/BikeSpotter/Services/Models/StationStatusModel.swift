//
//  StationStatusModel.swift
//  BikeSpotter
//
//  Created by Jakub Legut on 11/05/2024.
//

import Foundation

// MARK: - StationStatusesModel
struct StationStatusesModel: Codable {
	let lastUpdated, ttl: Int
	let version: String
	let data: StationStatusData

	enum CodingKeys: String, CodingKey {
		case lastUpdated = "last_updated"
		case ttl, version, data
	}
}

struct StationStatusData: Codable {
	let stations: [StationStatusModel]
}

// MARK: - StationStatusModel
struct StationStatusModel: Codable {
	let stationID: String
	let isInstalled, isRenting, isReturning: Bool
	let lastReported, numVehiclesAvailable, numBikesAvailable, numDocksAvailable: Int
	let vehicleTypesAvailable: [VehicleTypesAvailable]

	enum CodingKeys: String, CodingKey {
		case stationID = "station_id"
		case isInstalled = "is_installed"
		case isRenting = "is_renting"
		case isReturning = "is_returning"
		case lastReported = "last_reported"
		case numVehiclesAvailable = "num_vehicles_available"
		case numBikesAvailable = "num_bikes_available"
		case numDocksAvailable = "num_docks_available"
		case vehicleTypesAvailable = "vehicle_types_available"
	}
}

// MARK: - VehicleTypesAvailable
struct VehicleTypesAvailable: Codable {
	let vehicleTypeID: VehicleTypeID
	let count: Int

	enum CodingKeys: String, CodingKey {
		case vehicleTypeID = "vehicle_type_id"
		case count
	}
}

// MARK: - VehicleTypeID enum
enum VehicleTypeID: String, Codable {
	case bike = "bike"
	case ebike = "ebike"
}

