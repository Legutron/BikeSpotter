//
//  AppCoordinate.swift
//  BikeSpotter
//
//  Created by Jakub Legut on 11/05/2024.
//

import Foundation
import UIKit
import CoreLocation

protocol Coordinator {
	var parentCoordinator: Coordinator? { get set }
	var children: [Coordinator] { get set }
	var navigationController: UINavigationController { get set }
	func start()
}

class AppCoordinator : Coordinator {
	var parentCoordinator: Coordinator?
	var children: [Coordinator] = []
	var navigationController: UINavigationController
	init(navigationController : UINavigationController) {
		self.navigationController = navigationController
	}
	func start() {
		goToStationList()
	}
	
	func goToStationList() {
		let bikeSpotListViewModel = BikeSpotListViewModel()
		let bikeSpotListScreen = BikeSpotListScreen(viewModel: bikeSpotListViewModel)
		bikeSpotListViewModel.appCoordinator = self
		navigationController.pushViewController(bikeSpotListScreen, animated: true)
	}
	func goToStationMap(stationLocation: CLLocation) {
		let bikeSpotMapViewModel = BikeSpotMapViewModel(stationLocation: stationLocation)
		let bikeSpotMapScreen = BikeSpotMapScreen(viewModel: bikeSpotMapViewModel)
//		bikeSpotMapViewModel.appCoordinator = self
		navigationController.pushViewController(bikeSpotMapScreen, animated: true)
	}
}
