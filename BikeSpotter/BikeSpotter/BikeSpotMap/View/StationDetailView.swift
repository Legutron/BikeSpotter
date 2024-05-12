//
//  StationDetailView.swift
//  BikeSpotter
//
//  Created by Jakub Legut on 12/05/2024.
//

import UIKit

final class StationDetailView: UIView {
	enum Constants {
		static let padding: CGFloat = 16
		static let bottomPadding: CGFloat = 64
		static let spacing: CGFloat = 8
		static let cornerRadius: CGFloat = 24
	}
	// MARK: - UI
	private lazy var contentView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = Asset.color.backgroundPrimary
		view.layer.cornerRadius = Constants.cornerRadius
		view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
		return view
	}()
	
	private lazy var titleLabel: UILabel = {
		let lbl = UILabel()
		lbl.translatesAutoresizingMaskIntoConstraints = false
		lbl.font = .systemFont(ofSize: 24, weight: .bold)
		return lbl
	}()
	
	private lazy var distanceLabel: UILabel = {
		let lbl = UILabel()
		lbl.translatesAutoresizingMaskIntoConstraints = false
		lbl.font = .systemFont(ofSize: 16, weight: .bold)
		lbl.setContentHuggingPriority(.required, for: .horizontal)
		return lbl
	}()
	
	private lazy var addressLabel: UILabel = {
		let lbl = UILabel()
		lbl.translatesAutoresizingMaskIntoConstraints = false
		lbl.font = .systemFont(ofSize: 16, weight: .regular)
		lbl.setContentHuggingPriority(.defaultLow, for: .horizontal)
		return lbl
	}()
	
	private lazy var subtitleStack: UIStackView = {
		let vw = UIStackView(arrangedSubviews: [
			distanceLabel,
			addressLabel
		])
		vw.translatesAutoresizingMaskIntoConstraints = false
		vw.axis = .horizontal
		vw.spacing = .zero
		return vw
	}()
	
	// MARK: - Values stacks
	private lazy var bikeImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleAspectFill
		imageView.image = UIImage(named:Asset.image.bikeIcon)
		return imageView
	}()
	
	private lazy var placeImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleAspectFill
		imageView.image = UIImage(named:Asset.image.lockIcon)
		return imageView
	}()
	
	private lazy var bikeAvailableValueLabel: UILabel = {
		let lbl = UILabel()
		lbl.translatesAutoresizingMaskIntoConstraints = false
		lbl.font = .systemFont(ofSize: 44, weight: .bold)
		return lbl
	}()
	
	private lazy var placeAvailableValueLabel: UILabel = {
		let lbl = UILabel()
		lbl.translatesAutoresizingMaskIntoConstraints = false
		lbl.font = .systemFont(ofSize: 44, weight: .bold)
		return lbl
	}()
	
	private lazy var bikeAvailableLabel: UILabel = {
		let lbl = UILabel()
		lbl.translatesAutoresizingMaskIntoConstraints = false
		lbl.font = .systemFont(ofSize: 16, weight: .regular)
		return lbl
	}()
	
	private lazy var placeAvailableLabel: UILabel = {
		let lbl = UILabel()
		lbl.translatesAutoresizingMaskIntoConstraints = false
		lbl.font = .systemFont(ofSize: 16, weight: .regular)
		return lbl
	}()
	
	private lazy var bikeAvailableStackView: UIStackView = {
		let vw = UIStackView(arrangedSubviews: [
			bikeImageView,
			bikeAvailableValueLabel,
			bikeAvailableLabel
		])
		vw.translatesAutoresizingMaskIntoConstraints = false
		vw.axis = .vertical
		vw.spacing = 8
		vw.alignment = .center
		vw.distribution = .fillProportionally
		return vw
	}()
	
	private lazy var placeAvailableStackView: UIStackView = {
		let vw = UIStackView(arrangedSubviews: [
			placeImageView,
			placeAvailableValueLabel,
			placeAvailableLabel
		])
		vw.translatesAutoresizingMaskIntoConstraints = false
		vw.axis = .vertical
		vw.spacing = 8
		vw.alignment = .center
		vw.distribution = .fillProportionally
		return vw
	}()
	
	private lazy var valuesStack: UIStackView = {
		let vw = UIStackView(arrangedSubviews: [
			bikeAvailableStackView,
			placeAvailableStackView
		])
		vw.translatesAutoresizingMaskIntoConstraints = false
		vw.axis = .horizontal
		vw.spacing = 8
		vw.alignment = .center
		vw.distribution = .fillEqually
		return vw
	}()	
	
	// MARK: - Properties
	private var viewModel: StationDetailViewModelProtocol?
	
	// MARK: - Inits -
	
	convenience init() {
		self.init(frame: .zero)
		setupViews()
	}
	
	// MARK: - Setup -
	
	func setupViews() {
		self.addSubview(contentView)
		self.addSubview(titleLabel)
		self.addSubview(subtitleStack)
		self.addSubview(valuesStack)
		
		NSLayoutConstraint.activate([
			contentView.topAnchor.constraint(equalTo: self.topAnchor),
			contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
			contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
			contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
			
			titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.padding),
			titleLabel.heightAnchor.constraint(equalToConstant: 30),
			titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.padding),
			titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.padding),
			
			subtitleStack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
			subtitleStack.heightAnchor.constraint(equalToConstant: 30),
			subtitleStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.padding),
			subtitleStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.padding),
			
			valuesStack.topAnchor.constraint(equalTo: subtitleStack.bottomAnchor, constant: 8),
			valuesStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.padding),
			valuesStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.padding),
			valuesStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.bottomPadding),
		])
	}
	
	func setupData(viewModel: StationDetailViewModelProtocol) {
		self.viewModel = viewModel
		self.titleLabel.text = self.viewModel?.label
		self.distanceLabel.text = self.viewModel?.distance
		self.addressLabel.text = self.viewModel?.address
		
		self.bikeAvailableValueLabel.text = self.viewModel?.bikeAvailableValue
		self.placeAvailableValueLabel.text = self.viewModel?.placeAvailableValue
		self.bikeAvailableLabel.text = self.viewModel?.bikeAvailableLabel
		self.placeAvailableLabel.text = self.viewModel?.placeAvailableLabel
		
		self.bikeAvailableValueLabel.textColor = self.viewModel?.bikeLabelColor
	}
	
}

