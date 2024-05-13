//
//  StationDetailMapScreen.swift
//  BikeSpotter
//
//  Created by Jakub Legut on 08/05/2024.
//

import UIKit
import MapKit
import CoreLocation

class StationDetailMapScreen: UIViewController, StationDetailMapUpdateDelegate {
	enum Constants {
		static let mapEdgeInsets: UIEdgeInsets = .init(
			top: 50,
			left: 50,
			bottom: 250,
			right: 50
		)
		static let defaultDistance: Double = 500
		static let lineWidth: CGFloat = 2.0
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
		map.register(StationAnnotationPinView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
		map.tintColor = Asset.color.backgroundActive
		return map
	}()
	
	// MARK: - Properties
	private var viewModel: StationDetailMapViewModelProtocol
	
	// MARK: - Inits
	init(viewModel: StationDetailMapViewModelProtocol) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		nil
	}
	
	// MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		viewModel.delegate = self
		viewModel.requestUserLocation()
		setupViews()
		setupStationDetailView()
		addCustomPin()
	}
	
	// MARK: - Setup views
	func setupViews() {
		view.backgroundColor = Asset.color.backgroundSecondary
		view.addSubview(mapView)
		
		NSLayoutConstraint.activate([
			mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
		])
	}
	
	func setupStationDetailView() {
		let detailView = StationDetailView()
		detailView.setupData(viewModel: viewModel.stationDetailViewModel)
		detailView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(detailView)
		
		NSLayoutConstraint.activate([
			detailView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			detailView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			detailView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
		])
	}
	
	// MARK: - Notify Actions
	func userLocationUpdated() {
		DispatchQueue.main.async {
			if let userLocation = self.viewModel.userLocation {
				self.showRouteOnMap(
					pickupCoordinate: userLocation.coordinate,
					destinationCoordinate: self.viewModel.stationLocation.coordinate
				)
			}
		}
	}
}

// MARK: - MKMapViewDelegate
extension StationDetailMapScreen: MKMapViewDelegate {
	func addCustomPin() {
		let pin = MKPointAnnotation()
		pin.coordinate = viewModel.stationLocation.coordinate
		mapView.addAnnotation(pin)
		self.mapView.setRegion(
			MKCoordinateRegion(
				center: pin.coordinate,
				latitudinalMeters: Constants.defaultDistance,
				longitudinalMeters: Constants.defaultDistance
			),
			animated: true
		)
	}
	
	func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
		if annotation is MKUserLocation {
			return nil
		} else {
			let annotationView: StationAnnotationPinProtocol = StationAnnotationPinView(annotation: annotation, reuseIdentifier: "custom")
			annotationView.setData(value: viewModel.bikeAvailableValueLabel)
			return annotationView as? MKAnnotationView
		}
	}
	
	func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
		let renderer = MKPolylineRenderer(overlay: overlay)
		renderer.strokeColor = Asset.color.backgroundActive
		renderer.lineWidth = Constants.lineWidth
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
					print("🔴 Error: \(error.localizedDescription)")
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
#if DEBUG
#Preview("StationDetailMapScreen") {
	StationDetailMapScreen(
		viewModel: StationDetailMapViewModel(
			stationLocation: .init(
				latitude: 54.375998,
				longitude: 18.626554
			),
			bikeAvailableValueLabel: Translations.bikesValueLabel,
			stationDetailViewModel: StationDetailViewModel(
				stationData: .init(stationData: .mock)
			)
		)
	)
}
#endif
