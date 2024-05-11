//
//  BikeSpotModel.swift
//  BikeSpotter
//
//  Created by Jakub Legut on 08/05/2024.
//

import Foundation

struct BikeSpotViewModel {
	let id: String
	let label: String
	let distance: String
	let address: String
	let spotBikeValue: SpotValueModel
	let spotPlacesValue: SpotValueModel
}

//"station_id": "4971",
//		"name": "GDA370",
//		"address": "Lawendowe wzgórze",
//		"cross_street": "GDA370",
//		"lat": 54.3272251,
//		"lon": 18.5602068,
//		"is_virtual_station": true,
//		"capacity": 10,
//		"station_area": {
//		  "type": "MultiPolygon",
//		  "coordinates": [
//			[
//			  [
//				[18.559675924959, 54.3276350361604],
//				[18.5590533130967, 54.3272536522811],
//				[18.5600526312957, 54.3268692137518],
//				[18.56104148543, 54.3272353457659],
//				[18.5604659618599, 54.3276258829887],
//				[18.559675924959, 54.3276350361604]
//			  ]
//			]
//		  ]
