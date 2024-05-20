//
//  StationListViewModel.swift
//  BikeSpotter
//
//  Created by Jakub Legut on 08/05/2024.
//

import Foundation
import CoreLocation
import Combine

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
	private var cancellables = Set<AnyCancellable>()
	
	@Published var cellViewModels: [StationListCellViewModel] = []
	@Published var userLocation: CLLocation?
	
	func onLoad() {
		Location.shared.setupLocationDelegate(delegate: self)
		getUserLocation()
		fetchData()
	}
	
	func fetchData() {
		fetchStations()
	}
	
	private func fetchStations() {
		Api.shared.fetchStations()
			.map { stations in
				stations
					.map {
						StationListCellViewModel(stationData: $0)
					}
			}
			.sink(
				receiveCompletion: { completion in
					switch completion {
					case .finished:
						break
					case .failure(let error):
						print("Failed to fetch stations: \(error)")
					}
				},
				receiveValue: { [weak self] stationCellViewModels in
					self?.cellViewModels = stationCellViewModels
					self?.delegate?.stationsUpdated()
				}
			)
			.store(in: &cancellables)
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
