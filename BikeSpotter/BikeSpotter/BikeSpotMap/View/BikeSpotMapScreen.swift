//
//  BikeSpotMapScreen.swift
//  BikeSpotter
//
//  Created by Jakub Legut on 08/05/2024.
//

import UIKit
import MapKit
import CoreLocation

class BikeSpotMapScreen: UIViewController {
	enum Constants {
		static let mapEdgeInsets: UIEdgeInsets = .init(
			top: 50,
			left: 50,
			bottom: 200,
			right: 50
		)
	}
	
	// MARK: - UI
	lazy var contentView: UIView = {
		let vw = UIView()
		vw.translatesAutoresizingMaskIntoConstraints = false
		return vw
	}()
	
	lazy var mapView: MKMapView = {
		let map = MKMapView()
		map.translatesAutoresizingMaskIntoConstraints = false
		map.showsUserLocation = true
		map.delegate = self
		map.setUserTrackingMode(.follow, animated:true)
		map.register(CustomAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
		map.tintColor = Asset.color.backgroundActive
		return map
	}()
	
	// MARK: - Properties
	private let viewModel: BikeSpotMapViewModelProtocol
	var locationManager: CLLocationManager?
	var routeOverlay: MKOverlay?
	
	// MARK: - Lifecycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupLocationManager()
		setupViews()
		setupStationDetailView()
		addCustomPin()
		if let userLocation = viewModel.userLocation {
			showRouteOnMap(
				pickupCoordinate: userLocation.coordinate,
				destinationCoordinate: viewModel.stationLocation.coordinate
			)
		}
	}
	
	// MARK: - Setup views
	
	func setupViews() {
		self.view.backgroundColor = Asset.color.backgroundSecondary
		self.view.addSubview(mapView)
		
		NSLayoutConstraint.activate([
			mapView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
			mapView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
			mapView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
			mapView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
		])
	}
	
	func setupStationDetailView() {
		let detailView = StationDetailView()
		detailView.setupData(viewModel: viewModel.stationDetailViewModel)
		detailView.translatesAutoresizingMaskIntoConstraints = false
		self.view.addSubview(detailView)
		
		NSLayoutConstraint.activate([
			detailView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
			detailView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
			detailView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
		])
	}
	
	func setupLocationManager() {
		self.locationManager = CLLocationManager()
		self.locationManager?.delegate = self
		self.locationManager?.requestWhenInUseAuthorization()
		self.locationManager?.requestLocation()
		if let userLocation = self.locationManager?.location {
			viewModel.setUserLocation(location: userLocation)
		}
	}
	
	// MARK: - Inits
	
	init(viewModel: BikeSpotMapViewModelProtocol) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		nil
	}
}

// MARK: - CLLocationManagerDelegate

extension BikeSpotMapScreen: CLLocationManagerDelegate {
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		return
	}
	
	func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
		print(error)
	}
}

// MARK: - MKMapViewDelegate

extension BikeSpotMapScreen: MKMapViewDelegate {
	func addCustomPin() {
		let pin = MKPointAnnotation()
		pin.coordinate = viewModel.stationLocation.coordinate
		mapView.addAnnotation(pin)
	}
	
	func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
		if annotation is MKUserLocation {
			return nil
		} else {
			let annotationView: CustomAnnotationProtocol = CustomAnnotationView(annotation: annotation, reuseIdentifier: "custom")
			annotationView.setData(value: viewModel.bikeAvailableValueLabel)
			return annotationView as? MKAnnotationView
		}
	}
	
	func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
		let renderer = MKPolylineRenderer(overlay: overlay)
		renderer.strokeColor = Asset.color.backgroundActive
		renderer.lineWidth = 3.0
		renderer.lineDashPattern = [2,6]
		return renderer
	}
	
	func showRouteOnMap(pickupCoordinate: CLLocationCoordinate2D, destinationCoordinate: CLLocationCoordinate2D) {
		let sourcePlacemark = MKPlacemark(coordinate: pickupCoordinate, addressDictionary: nil)
		let destinationPlacemark = MKPlacemark(coordinate: destinationCoordinate, addressDictionary: nil)
		let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
		let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
		
		let directionRequest = MKDirections.Request()
		directionRequest.source = sourceMapItem
		directionRequest.destination = destinationMapItem
		directionRequest.transportType = .walking // setting walking direction

		let directions = MKDirections(request: directionRequest)

		directions.calculate { (response, error) -> Void in
			guard let response = response else {
				if let error = error {
					print("Error: \(error)")
				}
				return
			}
			let route = response.routes[0]
			self.mapView.addOverlay((route.polyline), level: MKOverlayLevel.aboveRoads)
			let rect = route.polyline.boundingMapRect
			self.mapView.setVisibleMapRect(rect, edgePadding: Constants.mapEdgeInsets, animated: true)
		}
	}
}

// MARK: - Preview
#warning("TO DO")
#if DEBUG
//#Preview("BikeSpotMapScreen") {
//	BikeSpotMapScreen(
//		viewModel: BikeSpotMapViewModel(
//			stationLocation: .init(
//				latitude: 51.11022974300518,
//				longitude: 16.880345184560777
//			),
//			bikeAvailableValueLabel: "22", 
//			stationDetailViewModel: StationDetailViewModel(
//				spotData: .init(
//				station: <#T##Station#>,
//				status: <#T##StationStatusModel#>)
//			)
//		)
//	)
//}
#endif
