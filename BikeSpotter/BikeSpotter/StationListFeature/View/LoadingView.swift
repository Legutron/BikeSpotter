//
//  LoadingView.swift
//  BikeSpotter
//
//  Created by Jakub Legut on 12/05/2024.
//

import UIKit

final class LoadingView: UIView {
	
	// MARK: - UI
	private lazy var indicatiorView: UIActivityIndicatorView = {
		let indicator = UIActivityIndicatorView()
		indicator.translatesAutoresizingMaskIntoConstraints = false
		indicator.color = Asset.color.backgroundActive
		indicator.startAnimating()
		return indicator
	}()
	
	// MARK: - Inits -
	convenience init() {
		self.init(frame: .zero)
		setupViews()
	}
	
	// MARK: - Setup -
	private func setupViews() {
		addSubview(indicatiorView)

		NSLayoutConstraint.activate([
			indicatiorView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
			indicatiorView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
		])
	}
}
