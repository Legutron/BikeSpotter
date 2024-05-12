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
	var bikeAvailableValueLabel: String { get }
	func setUserLocation(location: CLLocation)
}

final class BikeSpotMapViewModel: BikeSpotMapViewModelProtocol {
	weak var coordinator: AppCoordinator!
	
	@Published var userLocation: CLLocation?
	@Published var stationLocation: CLLocation
	@Published var bikeAvailableValueLabel: String
	
	init(
		userLocation: CLLocation? = nil,
		stationLocation: CLLocation,
		bikeAvailableValueLabel: String
	) {
		self.userLocation = userLocation
		self.stationLocation = stationLocation
		self.bikeAvailableValueLabel = bikeAvailableValueLabel
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

