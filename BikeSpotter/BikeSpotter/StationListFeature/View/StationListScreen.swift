//
//  StationListScreen.swift
//  BikeSpotter
//
//  Created by Jakub Legut on 08/05/2024.
//

import UIKit

class StationListScreen: UIViewController, StationListUpdateDelegate {
	enum Constants {
		static let cellIdentifier: String = "station_cell"
		static let rowHeight: CGFloat = 250
	}
	
	// MARK: - UI
	lazy var contentView: UIView = {
		let vw = UIView()
		vw.translatesAutoresizingMaskIntoConstraints = false
		vw.backgroundColor = Asset.color.backgroundSecondary
		return vw
	}()
	
	private lazy var tableView: UITableView = {
		let tableView = UITableView(frame: .zero, style: .plain)
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.backgroundColor = Asset.color.backgroundSecondary
		tableView.separatorStyle = .none
		tableView.allowsSelection = true
		tableView.rowHeight = Constants.rowHeight
		tableView.dataSource = self
		tableView.delegate = self
		tableView.register(StationListViewCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
		return tableView
	}()
	
	private lazy var loadingView: UIView = {
		let vw = LoadingView()
		vw.translatesAutoresizingMaskIntoConstraints = false
		vw.backgroundColor = Asset.color.backgroundSecondary
		return vw
	}()
	
	// MARK: - Properties
	private var viewModel: StationListViewModelProtocol
	private let refreshControl = UIRefreshControl()
	
	// MARK: - Inits
	init(viewModel: StationListViewModelProtocol) {
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
		viewModel.onLoad()
		setPullToRefresh()
		setupNavBar()
		setupLoadingView()
	}
	
	// MARK: - Setup views
	func setPullToRefresh() {
		refreshControl.tintColor = Asset.color.backgroundActive
		refreshControl.addTarget(self, action: #selector(self.refresh), for: .valueChanged)
		tableView.addSubview(refreshControl)
	}
	
	func setupNavBar() {
		let appearance = UINavigationBarAppearance()
		appearance.backgroundColor = Asset.color.backgroundNavbar
		if let backIcon = UIImage(named: Asset.image.backIcon) {
			appearance.setBackIndicatorImage(backIcon, transitionMaskImage: backIcon)
		}
		navigationController?.navigationBar.tintColor = .white
		navigationController?.navigationBar.standardAppearance = appearance
		navigationController?.navigationBar.compactAppearance = appearance
		navigationController?.navigationBar.scrollEdgeAppearance = appearance
		navigationController?.navigationBar.prefersLargeTitles = false
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
	
	func setupViews() {
		view.backgroundColor = Asset.color.backgroundSecondary
		view.addSubview(contentView)
		view.addSubview(tableView)
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
	
	// MARK: - Notify Actions
	func stationsUpdated() {
		DispatchQueue.main.async {
			self.refreshControl.endRefreshing()
			self.tableView.reloadData()
			self.setupViews()
		}
	}
	
	// MARK: - Behaviors
	@objc 
	func refresh() {
		viewModel.fetchData()
	}
}

// MARK: - UITableViewDelegate
extension StationListScreen: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel.cellViewModels.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier) as! StationListViewCell
		let cellModel = viewModel.cellViewModels[indexPath.row]
		cell.setupCell(viewModel: cellModel)
		cell.selectionStyle = .none
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let station = viewModel.cellViewModels[indexPath.row]
		navigationController?.pushViewController(
			StationDetailMapScreen(
				viewModel: StationDetailMapViewModel(
					userLocation: viewModel.userLocation,
					stationLocation: station.location,
					stationDetailViewModel: StationDetailViewModel(stationData: station)
				)
			),
			animated: true
		)
	}
}

// MARK: - Preview
#if DEBUG
#Preview("StationListScreen") {
	StationListScreen(viewModel: StationListViewModel())
}
#endif
