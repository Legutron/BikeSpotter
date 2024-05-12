//
//  ViewModel.swift
//  BikeSpotter
//
//  Created by Jakub Legut on 08/05/2024.
//

import Foundation
import CoreLocation

protocol BikeSpotMapViewModelProtocol {
	var userLocation: CLLocation? { get }
	var stationLocation: CLLocation { get }
	func setUserLocation(location: CLLocation)
}

final class BikeSpotMapViewModel: BikeSpotMapViewModelProtocol {
	weak var coordinator: AppCoordinator!
	
	@Published var userLocation: CLLocation?
	@Published var stationLocation: CLLocation
	
	init(userLocation: CLLocation? = nil, stationLocation: CLLocation) {
		self.userLocation = userLocation
		self.stationLocation = stationLocation
	}
	
	func setUserLocation(location: CLLocation) {
		self.userLocation = location
	}
	
	func goToStationList() {
		coordinator.goToStationList()
	}
}

//	.init(
//		latitude: 51.11022974300518,
//		longitude: 16.880345184560777
//	)

