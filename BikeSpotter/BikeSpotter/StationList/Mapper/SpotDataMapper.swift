//
//  SpotDataMapper.swift
//  BikeSpotter
//
//  Created by Jakub Legut on 12/05/2024.
//

import Foundation
import CoreLocation

extension StationModel {
	init(stationData: StationData) {
		self.id = stationData.station.stationID
		self.name = stationData.name
		self.distance = nil
		self.address = stationData.station.address
		self.location = .init(
			latitude: stationData.station.lat,
			longitude: stationData.station.lon
		)
		self.numBikesAvailable = stationData.status.numBikesAvailable
		self.numDocksAvailable = stationData.status.numDocksAvailable
	}
}
