//
//  LoadingView.swift
//  BikeSpotter
//
//  Created by Jakub Legut on 12/05/2024.
//

import UIKit

final class LoadingView: UIView {
	
	// MARK: - UI
	private lazy var progressView: UIActivityIndicatorView = {
		let progress = UIActivityIndicatorView()
		progress.translatesAutoresizingMaskIntoConstraints = false
		progress.color = Asset.color.backgroundActive
		progress.startAnimating()
		return progress
	}()
	
	// MARK: - Inits -
	
	convenience init() {
		self.init(frame: .zero)
		setupViews()
	}
	
	// MARK: - Setup -
	
	private func setupViews() {
		self.addSubview(progressView)

		NSLayoutConstraint.activate([
			progressView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
			progressView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
		])
	}
	
}
