//
//  ViewController.swift
//  BikeSpotter
//
//  Created by Jakub Legut on 08/05/2024.
//

import UIKit

class BikeSpotListScreen: UIViewController, MyViewUpdateDelegate {
	enum Constants {
		static let cellIdentifier: String = "station_cell"
	}
	
	// MARK: - UI
	lazy var contentView: UIView = {
		let vw = UIView()
		vw.translatesAutoresizingMaskIntoConstraints = false
		vw.backgroundColor = Asset.color.backgroundSecondary
		return vw
	}()
	
	private lazy var tableView: UITableView = {
		let tableView = UITableView(frame: .zero, style: .grouped)
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.backgroundColor = Asset.color.backgroundSecondary
		tableView.separatorStyle = .none
		tableView.allowsSelection = true
		tableView.rowHeight = 250
		tableView.dataSource = self
		tableView.delegate = self
		tableView.contentInsetAdjustmentBehavior = .never
		tableView.register(BikeSpotViewCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
		
		return tableView
	}()
	
	private lazy var loadingView: UIView = {
		let vw = LoadingView()
		vw.translatesAutoresizingMaskIntoConstraints = false
		vw.backgroundColor = Asset.color.backgroundSecondary
		return vw
	}()
	
	// MARK: - Properties
	
	private var viewModel: BikeSpotListViewModelProtocol
	
	// MARK: - Lifecycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		viewModel.delegate = self
		viewModel.fetchData()
		setupNavBar()
		setupLoadingView()
	}
	
	// MARK: - Setup views
	
	func setupViews() {
		self.view.backgroundColor = Asset.color.backgroundSecondary
		self.view.addSubview(contentView)
		self.view.addSubview(tableView)
		loadingView.isHidden = true
		
		NSLayoutConstraint.activate([
			contentView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
			contentView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
			contentView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
			contentView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
			
			tableView.topAnchor.constraint(equalTo: contentView.topAnchor),
			tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
			tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
		])
	}
	
	func setupNavBar() {
		navigationController?.navigationBar.prefersLargeTitles = false
		let appearance = UINavigationBarAppearance()
		appearance.backgroundColor = Asset.color.backgroundNavbar
		navigationController?.navigationBar.tintColor = .white
		navigationController?.navigationBar.standardAppearance = appearance
		navigationController?.navigationBar.compactAppearance = appearance
		navigationController?.navigationBar.scrollEdgeAppearance = appearance
	}
	
	func setupLoadingView() {
		self.view.addSubview(loadingView)
		
		NSLayoutConstraint.activate([
			loadingView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
			loadingView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
			loadingView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
			loadingView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
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
	
	// MARK: - Behaviour
	func update() {
		DispatchQueue.main.async {
			self.tableView.reloadData()
			self.setupViews()
		}
	}
}

// MARK: - UITableViewDelegate

extension BikeSpotListScreen: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel.stations.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier) as! BikeSpotViewCell
		let station = viewModel.stations[indexPath.row]
		cell.setupWithData(
			label: station.name,
			distance: station.distance,
			address: station.address,
			bikeAvailableValueLabel: String(station.numBikesAvailable),
			placeAvailableValueLabel: String(station.numDocksAvailable),
			bikeAvailableLabel: "Bike Available",
			placeAvailableLabel: "Place Available"
		)
		cell.selectionStyle = .none
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let station = viewModel.stations[indexPath.row]
		navigationController?.pushViewController(
			BikeSpotMapScreen(
				viewModel: BikeSpotMapViewModel(
					stationLocation: station.location, 
					bikeAvailableValueLabel: station.numBikesAvailable
				)
			),
			animated: true
		)
	}
}

// MARK: - Preview
#if DEBUG
#Preview("BikeSpotListScreen") {
	BikeSpotListScreen(viewModel: BikeSpotListViewModel())
}
#endif
