//
//  StationModel.swift
//  BikeSpotter
//
//  Created by Jakub Legut on 09/05/2024.
//

import Foundation

struct StationModel {
	let id: Int
	let name: String
	let address: String
	let crossStreet: String
	let lat: String
	let lon: String
	let capacity: Int
}

#if DEBUG
extension StationModel {
	static let mock: Self = .init(
		id: 4971,
		name: "GDA370",
		address: "Lawendowe wzgórze",
		crossStreet: "GDA370",
		lat: "54.3272251",
		lon: "18.5602068",
		capacity: 10
	)
}
#endif
