//
//  StationDetailMapViewModel.swift
//  BikeSpotter
//
//  Created by Jakub Legut on 08/05/2024.
//

import Foundation
import CoreLocation

protocol StationDetailMapViewModelProtocol {
	var userLocation: CLLocation? { get }
	var stationLocation: CLLocation { get }
	var bikeAvailableValueLabel: String { get }
	var stationDetailViewModel: StationDetailViewModelProtocol { get }
}

final class StationDetailMapViewModel: StationDetailMapViewModelProtocol {
	
	@Published var userLocation: CLLocation?
	@Published var stationLocation: CLLocation
	@Published var bikeAvailableValueLabel: String
	@Published var stationDetailViewModel: StationDetailViewModelProtocol
	
	init(
		userLocation: CLLocation? = nil,
		stationLocation: CLLocation,
		stationDetailViewModel: StationDetailViewModelProtocol
	) {
		self.userLocation = userLocation
		self.stationLocation = stationLocation
		self.bikeAvailableValueLabel = stationDetailViewModel.bikeAvailableValue
		self.stationDetailViewModel = stationDetailViewModel
	}
}
