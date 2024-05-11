//
//  StationData.swift
//  BikeSpotter
//
//  Created by Jakub Legut on 11/05/2024.
//

import Foundation

enum LocalizationKey: String {
	case gda = "GDA"
}

struct StationSpotData {
	let station: Station
	let status: StationStatusModel
}

struct StationData {
	var station: StationInformationModel
	var status: StationStatusesModel
}

extension StationData {
	func filterByLocalization(localizationKey: LocalizationKey) -> [StationSpotData] {
		let loc = localizationKey.rawValue
		var statuses: [StationSpotData] = []
		let filtered = station.data.stations.filter({
			$0.name.contains(loc)
			})
		for station in filtered {
			if let status = status.data.stations.first(where: {
				$0.stationID == station.stationID
			}) {
				statuses.append(.init(station: station, status: status))
			}
		}
		return statuses
	}
}
