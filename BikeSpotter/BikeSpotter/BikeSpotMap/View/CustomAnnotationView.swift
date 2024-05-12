//
//  File.swift
//  BikeSpotter
//
//  Created by Jakub Legut on 11/05/2024.
//

import UIKit
import MapKit

protocol CustomAnnotationProtocol {
	func setData(value: String)
}

final class CustomAnnotationView: MKAnnotationView, CustomAnnotationProtocol {
	// MARK: - Properties
	var pinView: MapPinView?
	
	// MARK: - Initialization

	override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
		super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)

		frame = CGRect(x: 0, y: 0, width: 40, height: 50)
		centerOffset = CGPoint(x: 0, y: -frame.size.height / 2)

		canShowCallout = true
		setup()
	}

	@available(*, unavailable)
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
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

// MARK: - MapPinView

class MapPinView: UIView {
	
	// MARK: - UI
	
	private lazy var bikeImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleAspectFill
		imageView.image = UIImage(named: Asset.image.bikeIcon)
		return imageView
	}()
	
	private lazy var label: UILabel = {
		let lbl = UILabel()
		lbl.translatesAutoresizingMaskIntoConstraints = false
		lbl.font = .systemFont(ofSize: 18, weight: .semibold)
		lbl.text = ""
		return lbl
	}()
	
	private lazy var stack: UIStackView = {
		let vw = UIStackView(arrangedSubviews: [
			label,
			bikeImageView
		])
		vw.translatesAutoresizingMaskIntoConstraints = false
		vw.spacing = 2
		vw.alignment = .center
		vw.distribution = .fillEqually
		return vw
	}()

	// MARK: - Inits
	
	init() {
		super.init(frame: .zero)
		setupViews()
	}
	
	required init?(coder aDecoder: NSCoder) { nil }
	
	// MARK: - Setup
	
	private func setupViews() {
		self.translatesAutoresizingMaskIntoConstraints = false
		self.addSubview(stack)
		self.backgroundColor = Asset.color.backgroundPrimary
		self.layer.cornerRadius = 20
		
		NSLayoutConstraint.activate([
			stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
			stack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
			stack.topAnchor.constraint(equalTo: topAnchor, constant: 8),
			stack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
		])
	}
	
	func setData(value: String) {
		label.text = value
	}
}

// MARK: - Preview
#if DEBUG
#Preview("MapPinView") {
	MapPinView()
}
#endif
