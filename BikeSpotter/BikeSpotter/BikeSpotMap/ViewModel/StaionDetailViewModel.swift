//
//  StaionDetailViewModel.swift
//  BikeSpotter
//
//  Created by Jakub Legut on 12/05/2024.
//

import Foundation
import UIKit
import CoreLocation

protocol StationDetailViewModelProtocol {
	var label: String { get }
	var distance: String? { get }
	var address: String { get }
	var bikeLabelColor: UIColor { get }
	var bikeAvailableValue: String { get }
	var placeAvailableValue: String { get }
	var bikeAvailableLabel: String { get }
	var placeAvailableLabel: String { get }
}

class StationDetailViewModel: StationDetailViewModelProtocol {
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
	
	init(spotData: BikeSpotViewCellViewModel) {
		self.stationID = spotData.stationID
		self.location = spotData.location
		self.label = spotData.label
		self.address = spotData.address
		self.bikeLabelColor = spotData.bikeLabelColor
		self.bikeAvailableValue = spotData.bikeAvailableValue
		self.placeAvailableValue = spotData.placeAvailableValue
		self.bikeAvailableLabel = spotData.bikeAvailableLabel
		self.placeAvailableLabel = spotData.placeAvailableLabel
	}
}


