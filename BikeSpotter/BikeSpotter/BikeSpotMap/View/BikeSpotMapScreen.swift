//
//  ViewController.swift
//  BikeSpotter
//
//  Created by Jakub Legut on 08/05/2024.
//

import UIKit

class BikeSpotMapScreen: UIViewController {
	enum Constants {
		static let padding: CGFloat = 16
	}
	
	// MARK: - UI
	lazy var contentView: UIView = {
		let vw = UIView()
		vw.translatesAutoresizingMaskIntoConstraints = false
		return vw
	}()
	
	// MARK: - Properties
	
	private let viewModel: BikeSpotListViewModelProtocol
	
	// MARK: - Lifecycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupViews()
	}
	
	// MARK: - Setup views
	
	func setupViews() {
		self.view.backgroundColor = Asset.color.backgroundSecondary
		self.view.addSubview(contentView)
		
		NSLayoutConstraint.activate([
			contentView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
			contentView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 8),
			contentView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
			contentView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
			contentView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
		])
	}
	
	// MARK: - Inits
	
	init(viewModel: BikeSpotListViewModelProtocol) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		nil
	}
}

#Preview("BikeSpotListScreen") {
	BikeSpotMapScreen(viewModel: BikeSpotListViewModel())
}
