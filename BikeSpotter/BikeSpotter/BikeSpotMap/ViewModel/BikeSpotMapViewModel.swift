//
//  ViewModel.swift
//  BikeSpotter
//
//  Created by Jakub Legut on 08/05/2024.
//

import Foundation

protocol BikeSpotMapViewModelProtocol {
	var stations: [StationModel] { get }
	func onLoad()
	func stationPicked(id: String)
}

final class BikeSpotMapViewModel: BikeSpotMapViewModelProtocol {
	
	@Published var stations: [StationModel] = [.mock]
	
	func onLoad() {
		print("LOADED")
	}
	
	func stationPicked(id: String) {
		print("Tapped station id: \(id)")
	}
}

