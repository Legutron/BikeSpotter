//
//  StationDetailMapViewModel.swift
//  BikeSpotter
//
//  Created by Jakub Legut on 08/05/2024.
//

import Foundation
import CoreLocation


protocol StationDetailMapViewModelProtocol {
	var delegate: MyViewUpdateDelegate? { get set }
	
	var userLocation: CLLocation? { get }
	var stationLocation: CLLocation { get }
	var bikeAvailableValueLabel: String { get }
	var stationDetailViewModel: StationDetailViewModelProtocol { get }
	func requestUserLocation()
}

final class StationDetailMapViewModel: StationDetailMapViewModelProtocol {
	weak var delegate: MyViewUpdateDelegate?
	
	@Published var userLocation: CLLocation?
	@Published var stationLocation: CLLocation
	@Published var bikeAvailableValueLabel: String
	@Published var stationDetailViewModel: StationDetailViewModelProtocol
	
	init(
		userLocation: CLLocation? = nil,
		stationLocation: CLLocation,
		bikeAvailableValueLabel: String,
		stationDetailViewModel: StationDetailViewModelProtocol
	) {
		self.userLocation = userLocation
		self.stationLocation = stationLocation
		self.bikeAvailableValueLabel = bikeAvailableValueLabel
		self.stationDetailViewModel = stationDetailViewModel
	}
	
	func requestUserLocation() {
		Location.shared.requestUserLocation()
		if
			Location.shared.isPermissionGranted,
			let userLocation = Location.shared.currentLocation
		{
			self.userLocation = userLocation
			delegate?.update()
		} else {
			self.userLocation = nil
		}
	}
}

//	.init(
//		latitude: 51.11022974300518,
//		longitude: 16.880345184560777
//	)

