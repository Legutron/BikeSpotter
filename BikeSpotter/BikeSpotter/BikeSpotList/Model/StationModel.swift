//
//  StationModel.swift
//  BikeSpotter
//
//  Created by Jakub Legut on 09/05/2024.
//

import Foundation
import CoreLocation

struct StationModel {
	let id: String
	let name: String
	let distance: String?
	let address: String
	let location: CLLocation
	let numBikesAvailable: Int
	let numDocksAvailable: Int
}

#if DEBUG
extension StationModel {
	static let mock: Self = .init(
		id: "1234",
		name: "047 Ofiar Dąbia",
		distance: "Lawendowe wzgórze",
		address: "Aleja Pokoju 16, Kraków",
		location: .init(
			latitude: 51.11022974300518,
			longitude: 16.880345184560777
		),
		numBikesAvailable: 10,
		numDocksAvailable: 20
	)
}
#endif
