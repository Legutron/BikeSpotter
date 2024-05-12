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
	
	func geocode(latitude: Double, longitude: Double, completion: @escaping (CLPlacemark?, Error?) -> ())  {
		CLGeocoder()
			.reverseGeocodeLocation(CLLocation(latitude: latitude, longitude: longitude)) { completion($0?.first, $1) }
	}
	
//	func getAddressForLocation(location: CLLocation) -> String? {
//		var address: String? = nil
//		geocoder.reverseGeocodeLocation(
//			location,
//			completionHandler: { (placemark, error) in
//				guard let placemark = placemark, error == nil else { return }
//				let street = placemark.t
//				let number = placemark.subThoroughfare ?? ""
//				let city = placemark.locality ?? ""
//				address = street + number + city
//				
//			}
//		)
//		return address
//	}
	
}

extension Location: CLLocationManagerDelegate {
	public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		currentLocation = manager.location
	}
}
