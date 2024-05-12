//
//  Location.swift
//  BikeSpotter
//
//  Created by Jakub Legut on 12/05/2024.
//

import Foundation
import CoreLocation

// Singleton pattern
public class Location: NSObject {
	static let shared = Location()
	private let locationManager: CLLocationManager
	public var isPermissionGranted: Bool = false
	public var currentLocation: CLLocation?
	
	private init(
		locationManager: CLLocationManager = .init(),
		isPermissionGranted: Bool = false
	) {
		self.locationManager = locationManager
		self.isPermissionGranted = isPermissionGranted
	}
	
	func requestUserLocation() {
		self.locationManager.requestWhenInUseAuthorization()
		Task.init {
			await updatePermissionStatus()
		}
	}
	
	func updatePermissionStatus() async {
		if CLLocationManager.locationServicesEnabled() {
			self.locationManager.delegate = self
			self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
			self.isPermissionGranted = true
			self.currentLocation = locationManager.location
		} else {
			self.isPermissionGranted = false
		}
	}
	
	func getDistanceInMeters(coordinate1: CLLocation, coordinate2: CLLocation) -> Int {
		Int(coordinate1.distance(from: coordinate2))
	}
}

extension Location: CLLocationManagerDelegate {
	public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		currentLocation = manager.location
		// in the future there is an option to navigate user to the selected station (using locationManager.startUpdatingLocation())
	}
}
