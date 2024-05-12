//
//  StationListViewModel.swift
//  BikeSpotter
//
//  Created by Jakub Legut on 08/05/2024.
//

import Foundation

protocol MyViewUpdateDelegate: AnyObject {
	func update()
}

protocol StationListViewModelProtocol {
	var delegate: MyViewUpdateDelegate? { get set }
	
	var cellViewModels: [StationListCellViewModel] { get }
	func stationTapped(id: String)
	func fetchData()
}

final class StationListViewModel: StationListViewModelProtocol {
	weak var delegate: MyViewUpdateDelegate?
	
	@Published var stations: [StationModel] = []
	@Published var cellViewModels: [StationListCellViewModel] = []
	
	var isLocationPermissionGranted: Bool = false
	
	func fetchData() {
		getUserLocation()
		Task.init {
			await fetchStations()
		}
	}
	
	private func fetchStations() async {
		do {
			let stations = try await Api.shared.fetchStations()
			self.stations = stations.map { StationModel(stationData: $0) }
			self.cellViewModels = stations.map {
				StationListCellViewModel(stationData: $0)
			}
			delegate?.update()
		} catch {
			print(error.localizedDescription)
		}
	}
	
	func stationTapped(id: String) {
//		if let station = stations.first(where: { $0.id == id }) {
//			goToStationMap(
//				lat: station.,
//				lon: station.lon
//			)
//		}
	}
	
	private func getUserLocation() {
		Location.shared.requestUserLocation()
		self.isLocationPermissionGranted = Location.shared.isPermissionGranted
	}
	
	private func goToStationMap(lat: Double, lon: Double) {
//		appCoordinator.goToStationMap(stationLocation: .init(latitude: 12.1234, longitude: 12.3214))
	 }
}

