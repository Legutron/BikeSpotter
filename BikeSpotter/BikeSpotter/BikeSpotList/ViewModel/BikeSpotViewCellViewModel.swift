//
//  ViewModel.swift
//  BikeSpotter
//
//  Created by Jakub Legut on 08/05/2024.
//

import Foundation
import UIKit
import CoreLocation

protocol BikeSpotViewCellViewModelProtocol {
	var label: String { get }
	var distance: String? { get }
	var address: String { get }
	var bikeLabelColor: UIColor { get }
	var bikeAvailableValue: String { get }
	var placeAvailableValue: String { get }
	var bikeAvailableLabel: String { get }
	var placeAvailableLabel: String { get }
}

class BikeSpotViewCellViewModel: BikeSpotViewCellViewModelProtocol {
	var stationID: String
	var location: CLLocation
	@Published var label: String
	@Published var distance: String? = nil
	@Published var address: String
	@Published var bikeLabelColor: UIColor
	@Published var bikeAvailableValue: String
	@Published var placeAvailableValue: String
	@Published var bikeAvailableLabel: String
	@Published var placeAvailableLabel: String
	
	init(spotData: StationSpotData) {
		self.stationID = spotData.station.stationID
		self.location = spotData.location
		self.label = spotData.name
		self.address = spotData.station.address
		self.bikeLabelColor = (spotData.status.numBikesAvailable > 0 ) ? Asset.color.contentPositive ?? .green : Asset.color.contentNegative ?? .red
		self.bikeAvailableValue = String(spotData.status.numBikesAvailable)
		self.placeAvailableValue = String(spotData.status.numDocksAvailable)
		self.bikeAvailableLabel = "Bike Available"
		self.placeAvailableLabel = "Place Available"
	}
}

