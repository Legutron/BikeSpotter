//
//  StationData.swift
//  BikeSpotter
//
//  Created by Jakub Legut on 11/05/2024.
//

import Foundation
import CoreLocation

struct StationData {
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
