//
//  StationListViewModel.swift
//  BikeSpotter
//
//  Created by Jakub Legut on 08/05/2024.
//

import Foundation

protocol StationListNotifyDelegate: AnyObject {
	func stationsUpdated()
}

protocol StationListViewModelProtocol {
	var delegate: StationListNotifyDelegate? { get set }
	var cellViewModels: [StationListCellViewModel] { get }
	func fetchData()
}

final class StationListViewModel: StationListViewModelProtocol {
	weak var delegate: StationListNotifyDelegate?
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
