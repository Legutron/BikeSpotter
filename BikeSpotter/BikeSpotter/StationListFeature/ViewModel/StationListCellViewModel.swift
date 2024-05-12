//
//  ViewModel.swift
//  BikeSpotter
//
//  Created by Jakub Legut on 08/05/2024.
//

import Foundation
import UIKit
import CoreLocation

protocol StationListCellViewModelProtocol {
	var label: String { get }
	var distance: String? { get }
	var address: String { get }
	var bikeLabelColor: UIColor { get }
	var bikeAvailableValue: String { get }
	var placeAvailableValue: String { get }
	var bikeAvailableLabel: String { get }
	var placeAvailableLabel: String { get }
}

class StationListCellViewModel: StationListCellViewModelProtocol {
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
	
	init(stationData: StationData) {
		self.stationID = stationData.station.stationID
		self.location = stationData.location
		self.label = stationData.name
		self.distance = stationData.distanceLabel
		self.address = stationData.station.address
		self.bikeLabelColor = (stationData.status.numBikesAvailable > 0 ) 
		? Asset.color.contentPositive ?? .green
		: Asset.color.contentNegative ?? .red
		self.bikeAvailableValue = String(stationData.status.numBikesAvailable)
		self.placeAvailableValue = String(stationData.status.numDocksAvailable)
		self.bikeAvailableLabel = Translations.bikesValueLabel
		self.placeAvailableLabel = Translations.placesValueLabel
	}
}

