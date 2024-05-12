//
//  BikeSpotCellView.swift
//  BikeSpotter
//
//  Created by Jakub Legut on 10/05/2024.
//

import UIKit

class BikeSpotViewCell: UITableViewCell {
	enum Constants {
		static let padding: CGFloat = 16
		static let spacing: CGFloat = 8
		static let cornerRadius: CGFloat = 24
	}
	
	// MARK: - UI properties
	private lazy var cellView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = Asset.color.backgroundPrimary
		view.layer.cornerRadius = Constants.cornerRadius
		view.layer.shadowColor = UIColor.black.cgColor
		view.layer.shadowOpacity = 0.2
		view.layer.shadowOffset = .zero
		view.layer.shadowRadius = 6
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
	private var viewModel: BikeSpotViewCellViewModelProtocol?
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupViews()
	}
	
	required init?(coder: NSCoder) {
		nil
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
	}
	
	func setupViews() {
		self.backgroundColor = Asset.color.backgroundSecondary
		self.addSubview(cellView)
		self.addSubview(titleLabel)
		self.addSubview(subtitleStack)
		self.addSubview(valuesStack)
		
		NSLayoutConstraint.activate([
			cellView.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.spacing),
			cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Constants.spacing),
			cellView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.padding),
			cellView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.padding),
			
			titleLabel.topAnchor.constraint(equalTo: cellView.topAnchor, constant: Constants.padding),
			titleLabel.heightAnchor.constraint(equalToConstant: 30),
			titleLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: Constants.padding),
			titleLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -Constants.padding),
			
			subtitleStack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
			subtitleStack.heightAnchor.constraint(equalToConstant: 30),
			subtitleStack.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: Constants.padding),
			subtitleStack.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -Constants.padding),
			
			valuesStack.topAnchor.constraint(equalTo: subtitleStack.bottomAnchor, constant: 8),
			valuesStack.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: Constants.padding),
			valuesStack.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -Constants.padding),
			valuesStack.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -Constants.padding),
		])
	}
	
	func setupCell(viewModel: BikeSpotViewCellViewModelProtocol) {
		self.viewModel = viewModel
		setupData()
	}
	
	func setupData() {
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

// MARK: - Preview
#if DEBUG
#Preview("BikeSpotViewCell") {
	BikeSpotViewCell(
		style: .default,
		reuseIdentifier: nil
	)
}
#endif
