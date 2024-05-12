//
//  ApiMapper.swift
//  BikeSpotter
//
//  Created by Jakub Legut on 12/05/2024.
//

import Foundation

enum ApiMapper {
	static func transform(
		stations: StationInformationModel,
		statuses: StationStatusesModel
	) -> [StationData] {
		return stations.data.stations.compactMap { station in
			if let status = statuses.data.stations.first(where: { $0.stationID == station.stationID }) {
				return StationData(
					station: station,
					status: status
				)
			}
			return nil
		}
		// here we can also filter data, like showing only active renting spots.
//		.filter({ $0.status.isRenting == true })
	}
}
