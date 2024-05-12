//
//  Location.swift
//  BikeSpotter
//
//  Created by Jakub Legut on 12/05/2024.
//

import Foundation
import CoreLocation

public class Location: NSObject {
	// singleton
	static let shared = Location()
	private let locationManager: CLLocationManager
	private let geocoder: CLGeocoder
	public var isPermissionGranted: Bool = false
	public var currentLocation: CLLocation?
	
	private init(
		locationManager: CLLocationManager = .init(),
		geocoder: CLGeocoder = .init(),
		isPermissionGranted: Bool = false
	) {
		self.locationManager = locationManager
		self.geocoder = geocoder
		self.isPermissionGranted = isPermissionGranted
	}
	
	//	.init(
	//		latitude: 51.11022974300518,
	//		longitude: 16.880345184560777
	//	)
	
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
	
	func startUpdatingLocation() {
		self.locationManager.startUpdatingLocation()
	}
	
	func stopUpdatingLocation() {
		self.locationManager.stopUpdatingLocation()
	}
	
	func getDistanceInMeters(coordinate1: CLLocation, coordinate2: CLLocation) -> Int {
		Int(coordinate1.distance(from: coordinate2))
	}
	
}

extension Location: CLLocationManagerDelegate {
	public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		currentLocation = manager.location
	}
}
