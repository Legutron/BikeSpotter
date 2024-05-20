//
//  Location.swift
//  BikeSpotter
//
//  Created by Jakub Legut on 12/05/2024.
//

import Foundation
import CoreLocation

/*
 COMMENT:
 in the future there is an option to navigate user to the selected station (using locationManager.startUpdatingLocation())
 */

protocol LocationUpdateDelegate: AnyObject {
	func locationPermissionUpdated()
}

// Singleton pattern
public class Location: NSObject {
	weak var delegate: LocationUpdateDelegate?
	
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
		locationManager.requestWhenInUseAuthorization()
		DispatchQueue.global().async {
			self.updatePermissionStatus()
		}
	}
	
	func getDistanceInMeters(coordinate1: CLLocation, coordinate2: CLLocation) -> Int {
		Int(coordinate1.distance(from: coordinate2))
	}
	
	private func updatePermissionStatus() {
		if CLLocationManager.locationServicesEnabled() {
			locationManager.delegate = self
			locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
			isPermissionGranted = true
			currentLocation = locationManager.location
			delegate?.locationPermissionUpdated()
		} else {
			isPermissionGranted = false
		}
	}
	
	func setupLocationDelegate(delegate: LocationUpdateDelegate) {
		self.delegate = delegate
	}
}

extension Location: CLLocationManagerDelegate {
	public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		currentLocation = manager.location
	}
	
	public func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
		Task.init {
			await updatePermissionStatus()
		}
	}
}
