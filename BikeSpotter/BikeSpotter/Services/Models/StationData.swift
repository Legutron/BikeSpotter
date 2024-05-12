//
//  StationData.swift
//  BikeSpotter
//
//  Created by Jakub Legut on 11/05/2024.
//

import Foundation

struct StationSpotData {
	let station: Station
	let status: StationStatusModel
	
	var name: String {
		let name: [String] = [
			String(station.name.dropFirst(3)),
			station.address
		]
		return name.joined(separator: Sign.spacer)
	}
}

struct StationData {
	var stations: StationInformationModel
	var statuses: StationStatusesModel
	
	func setSpotData() -> [StationSpotData] {
		return stations.data.stations.compactMap { station in
			if let status = statuses.data.stations.first(where: { $0.stationID == station.stationID }) {
				return StationSpotData(
					station: station,
					status: status
				)
			}
			return nil
		}
	}
}

extension StationData {
	func filteredActive() -> [StationSpotData] {
		let spotData = setSpotData()
		return spotData.filter({ $0.status.isRenting == true })
	}
}
