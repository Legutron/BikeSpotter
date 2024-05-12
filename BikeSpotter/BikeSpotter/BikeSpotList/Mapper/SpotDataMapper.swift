//
//  SpotDataMapper.swift
//  BikeSpotter
//
//  Created by Jakub Legut on 12/05/2024.
//

import Foundation
import CoreLocation

extension StationModel {
	init(spotData: StationData) {
		self.id = spotData.station.stationID
		self.name = spotData.name
		self.distance = nil
		self.address = spotData.station.address
		self.location = .init(
			latitude: spotData.station.lat,
			longitude: spotData.station.lon
		)
		self.numBikesAvailable = spotData.status.numBikesAvailable
		self.numDocksAvailable = spotData.status.numDocksAvailable
	}
}
