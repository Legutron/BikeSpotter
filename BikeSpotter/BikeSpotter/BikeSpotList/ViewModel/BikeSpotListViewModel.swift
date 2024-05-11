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
	func fetchData()
}

final class BikeSpotListViewModel: BikeSpotListViewModelProtocol {
	
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
}

