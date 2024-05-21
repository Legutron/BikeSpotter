//
//  StationData.swift
//  BikeSpotter
//
//  Created by Jakub Legut on 11/05/2024.
//

import Foundation
import CoreLocation

public struct StationData {
	let station: Station
	let status: StationStatusModel
	var distance: Int?
}

extension StationData {
	var distanceLabel: String? {
		if let distance {
			return String(distance) +
			Sign.metersUnit +
			Sign.spacer +
			Sign.middleDot +
			Sign.spacer
		}
		return nil
	}
	
	var name: String {
		// on figma file is only number, so I drop first localization charakters. 
		let name: [String] = [
			String(station.name.dropFirst(3)),
			station.address
		]
		return name.joined(separator: Sign.spacer)
	}
	
	var location: CLLocation {
		CLLocation(latitude: station.lat, longitude: station.lon)
	}
}

// MARK: - Mocks
#if DEBUG
extension StationData {
	static let mock: Self = .init(
		station: .mock,
		status: .mock,
		distance: 500
	)
}

extension Station {
	static let mock: Self = .init(
		stationID: "4971",
		name: "GDA370",
		address: "Lawendowe wzgórze",
		crossStreet: "GDA370",
		lat: 54.3272251,
		lon: 18.5602068,
		isVirtualStation: true,
		capacity: 10,
		stationArea: .init(type: .multiPolygon, coordinates: []),
		rentalUris: .init(android: "", ios: "")
	)
}

extension StationStatusModel {
	static let mock: Self = .init(
		stationID: "4971",
		isInstalled: true,
		isRenting: true,
		isReturning: true,
		lastReported: 2,
		numVehiclesAvailable: 6,
		numBikesAvailable: 6,
		numDocksAvailable: 8,
		vehicleTypesAvailable: []
	)
}
#endif
