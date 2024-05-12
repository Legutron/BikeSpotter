//
//  ViewModel.swift
//  BikeSpotter
//
//  Created by Jakub Legut on 08/05/2024.
//

import Foundation

protocol MyViewUpdateDelegate: AnyObject {
	func update()
}

protocol BikeSpotListViewModelProtocol {
	var stations: [Station] { get }
	var delegate: MyViewUpdateDelegate? { get set }
	func stationTapped(id: String)
	func fetchData()
}

final class BikeSpotListViewModel: BikeSpotListViewModelProtocol {
	weak var appCoordinator: AppCoordinator!
	
	@Published var stations: [Station] = []
	
	weak var delegate: MyViewUpdateDelegate?
	
	func fetchData() {
		Task.init {
			await fetchStations()
		}
	}
	
	private func fetchStations() async {
		do {
			let sections = try await Api.shared.fetchStations()
			self.stations = sections.data.stations
			delegate?.update()
		} catch {
			print(error.localizedDescription)
		}
	}
	
	func stationTapped(id: String) {
		if let station = stations.first(where: { $0.stationID == id }) {
		goToStationMap(
			lat: station.lat,
			lon: station.lon
		)
		}
	}
	
	func goToStationMap(lat: Double, lon: Double) {
//		appCoordinator.goToStationMap(stationLocation: .init(latitude: 12.1234, longitude: 12.3214))
	 }
}

