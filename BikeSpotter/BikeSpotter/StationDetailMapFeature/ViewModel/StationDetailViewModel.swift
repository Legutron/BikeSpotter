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
	@Published var label: String
	@Published var distance: String? = nil
	@Published var address: String
	@Published var bikeLabelColor: UIColor
	@Published var bikeAvailableValue: String
	@Published var placeAvailableValue: String
	@Published var bikeAvailableLabel: String
	@Published var placeAvailableLabel: String
	
	init(stationData: StationListCellViewModel) {
		self.label = stationData.label
		self.distance = stationData.distance
		self.address = stationData.address
		self.bikeLabelColor = stationData.bikeLabelColor
		self.bikeAvailableValue = stationData.bikeAvailableValue
		self.placeAvailableValue = stationData.placeAvailableValue
		self.bikeAvailableLabel = stationData.bikeAvailableLabel
		self.placeAvailableLabel = stationData.placeAvailableLabel
	}
}


