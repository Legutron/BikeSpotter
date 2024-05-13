//
//  StationListViewModel.swift
//  BikeSpotter
//
//  Created by Jakub Legut on 08/05/2024.
//

import Foundation

#warning("Add tap button animation!")
#warning("Name for the location - check")
#warning("Reuse Spot detail model from map to cell")

protocol StationListUpdateDelegate: AnyObject {
	func stationsUpdated()
}

protocol StationListViewModelProtocol {
	var delegate: StationListUpdateDelegate? { get set }
	var cellViewModels: [StationListCellViewModel] { get }
	func fetchData()
}

final class StationListViewModel: StationListViewModelProtocol {
	weak var delegate: StationListUpdateDelegate?
	@Published var cellViewModels: [StationListCellViewModel] = []
	
	func fetchData() {
		getUserLocation()
		Task.init {
			await fetchStations()
		}
	}
	
	private func fetchStations() async {
		do {
			let stations = try await Api.shared.fetchStations()
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
#warning("VERIFY")
extension StationListViewModel: LocationUpdateDelegate {
	func locationPermissionUpdated() {
		self.fetchData()
	}
}
