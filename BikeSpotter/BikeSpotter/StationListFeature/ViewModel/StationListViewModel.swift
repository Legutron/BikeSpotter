//
//  StationListViewModel.swift
//  BikeSpotter
//
//  Created by Jakub Legut on 08/05/2024.
//

import Foundation
import CoreLocation

protocol StationListUpdateDelegate: AnyObject {
	func stationsUpdated()
}

protocol StationListViewModelProtocol {
	var delegate: StationListUpdateDelegate? { get set }
	var cellViewModels: [StationListCellViewModel] { get }
	var userLocation: CLLocation? { get }
	func fetchData()
	func onLoad()
}

final class StationListViewModel: StationListViewModelProtocol {
	weak var delegate: StationListUpdateDelegate?
	
	@Published var cellViewModels: [StationListCellViewModel] = []
	@Published var userLocation: CLLocation?
	
	private let api: BikeApiProtocol
	
	init(
		delegate: StationListUpdateDelegate? = nil,
		cellViewModels: [StationListCellViewModel] = [],
		userLocation: CLLocation? = nil,
		api: BikeApiProtocol = Api.shared
	) {
		self.delegate = delegate
		self.cellViewModels = cellViewModels
		self.userLocation = userLocation
		self.api = api
	}
	
	func onLoad() {
		Location.shared.setupLocationDelegate(delegate: self)
		getUserLocation()
		fetchData()
	}
	
	func fetchData() {
		Task.init {
			await fetchStations()
		}
	}
	
	private func fetchStations() async {
		do {
			let stations = try await api.fetchStations()
			self.cellViewModels = stations.map {
				StationListCellViewModel(stationData: $0)
			}
			delegate?.stationsUpdated()
		} catch {
			print("🔴 Error: \(error.localizedDescription)")
		}
	}
	
	private func getUserLocation() {
		Location.shared.requestUserLocation()
	}
}

// MARK: - LocationUpdateDelegate
extension StationListViewModel: LocationUpdateDelegate {
	func locationPermissionUpdated() {
		userLocation = Location.shared.currentLocation
		fetchData()
	}
}
