//
//  MapPinView.swift
//  BikeSpotter
//
//  Created by Jakub Legut on 12/05/2024.
//

import UIKit

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
