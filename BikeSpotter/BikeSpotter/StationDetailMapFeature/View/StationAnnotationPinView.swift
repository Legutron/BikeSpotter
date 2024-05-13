//
//  File.swift
//  BikeSpotter
//
//  Created by Jakub Legut on 11/05/2024.
//

import UIKit
import MapKit

protocol StationAnnotationPinProtocol {
	func setData(value: String)
}

final class StationAnnotationPinView: MKAnnotationView, StationAnnotationPinProtocol {
	enum Constants {
		static let frameWidth: CGFloat = 40
		static let frameheight: CGFloat = 40
	}
	
	// MARK: - Properties
	var pinView: MapPinView?
	
	// MARK: - Inits
	override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
		super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
		frame = CGRect(x: 0, y: 0, width: Constants.frameWidth, height: Constants.frameheight)
		centerOffset = CGPoint(x: 0, y: -frame.size.height / 2)
		canShowCallout = false
		setup()
	}
	
	required init?(coder aDecoder: NSCoder) {
		nil
	}

	// MARK: - Setup
	private func setup() {
		backgroundColor = .clear
		pinView = MapPinView()
		if let pinView {
			self.addSubview(pinView)
			pinView.frame = bounds
		}
	}
	
	public func setData(value: String) {
		pinView?.setData(value: value)
	}
}
