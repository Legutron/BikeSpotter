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
		let appearance = UINavigationBarAppearance()
		appearance.backgroundColor = Asset.color.backgroundNavbar
		if let backIcon = UIImage(named: Asset.image.backIcon) {
			appearance.setBackIndicatorImage(backIcon, transitionMaskImage: backIcon)
		}
		self.navigationController?.navigationBar.tintColor = .white
		self.navigationController?.navigationBar.standardAppearance = appearance
		self.navigationController?.navigationBar.compactAppearance = appearance
		self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
		self.navigationController?.navigationBar.prefersLargeTitles = false
		navigationItem.backButtonTitle = Sign.empty
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
		return viewModel.cellViewModels.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier) as! BikeSpotViewCell
		let cellModel = viewModel.cellViewModels[indexPath.row]
		cell.setupCell(viewModel: cellModel)
		cell.selectionStyle = .none
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let station = viewModel.cellViewModels[indexPath.row]
		navigationController?.pushViewController(
			BikeSpotMapScreen(
				viewModel: BikeSpotMapViewModel(
					stationLocation: station.location, 
					bikeAvailableValueLabel: station.bikeAvailableValue, 
					stationDetailViewModel: StationDetailViewModel(spotData: station)
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
