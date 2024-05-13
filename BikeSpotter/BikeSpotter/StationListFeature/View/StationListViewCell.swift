//
//  StationListViewCell.swift
//  BikeSpotter
//
//  Created by Jakub Legut on 10/05/2024.
//

import UIKit

class StationListViewCell: UITableViewCell {
	enum Constants {
		static let padding: CGFloat = 16
		static let spacing: CGFloat = 8
		static let cornerRadius: CGFloat = 24
		static let titleLabelHeight: CGFloat = 30
	}
	
	// MARK: - UI properties
	private lazy var cellView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = Asset.color.backgroundPrimary
		view.layer.cornerRadius = Constants.cornerRadius
		view.layer.shadowColor = UIColor.black.cgColor
		view.layer.shadowOpacity = 0.05
		view.layer.shadowOffset = .zero
		view.layer.shadowRadius = 8
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
		lbl.font = .systemFont(ofSize: 12, weight: .bold)
		lbl.setContentHuggingPriority(.required, for: .horizontal)
		return lbl
	}()
	
	private lazy var addressLabel: UILabel = {
		let lbl = UILabel()
		lbl.translatesAutoresizingMaskIntoConstraints = false
		lbl.font = .systemFont(ofSize: 12, weight: .regular)
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
		imageView.image = UIImage(named: Asset.image.bikeIcon)
		return imageView
	}()
	
	private lazy var placeImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleAspectFill
		imageView.image = UIImage(named: Asset.image.lockIcon)
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
		lbl.font = .systemFont(ofSize: 12, weight: .regular)
		return lbl
	}()
	
	private lazy var placeAvailableLabel: UILabel = {
		let lbl = UILabel()
		lbl.translatesAutoresizingMaskIntoConstraints = false
		lbl.font = .systemFont(ofSize: 12, weight: .regular)
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
		vw.spacing = Constants.spacing
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
		vw.spacing = Constants.spacing
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
		vw.spacing = Constants.spacing
		vw.alignment = .center
		vw.distribution = .fillEqually
		return vw
	}()
	
	// MARK: - Properties
	private var viewModel: StationListCellViewModelProtocol?
	
	// MARK: - Inits
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
	
	// MARK: - Setup views
	func setupViews() {
		backgroundColor = Asset.color.backgroundSecondary
		addSubview(cellView)
		addSubview(titleLabel)
		addSubview(subtitleStack)
		addSubview(valuesStack)
		
		NSLayoutConstraint.activate([
			cellView.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.padding),
			cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
			cellView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.padding),
			cellView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.padding),
			
			titleLabel.topAnchor.constraint(equalTo: cellView.topAnchor, constant: Constants.padding),
			titleLabel.heightAnchor.constraint(equalToConstant: Constants.titleLabelHeight),
			titleLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: Constants.padding),
			titleLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -Constants.padding),
			
			subtitleStack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
			subtitleStack.heightAnchor.constraint(equalToConstant: Constants.titleLabelHeight),
			subtitleStack.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: Constants.padding),
			subtitleStack.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -Constants.padding),
			
			valuesStack.topAnchor.constraint(equalTo: subtitleStack.bottomAnchor, constant: Constants.spacing),
			valuesStack.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: Constants.padding),
			valuesStack.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -Constants.padding),
			valuesStack.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -Constants.padding),
		])
	}
	
	func setupCell(viewModel: StationListCellViewModelProtocol) {
		self.viewModel = viewModel
		setupData()
	}
	
	func setupData() {
		titleLabel.text = viewModel?.label
		distanceLabel.text = viewModel?.distance
		addressLabel.text = viewModel?.address
		
		bikeAvailableValueLabel.text = viewModel?.bikeAvailableValue
		placeAvailableValueLabel.text = viewModel?.placeAvailableValue
		bikeAvailableLabel.text = viewModel?.bikeAvailableLabel
		placeAvailableLabel.text = viewModel?.placeAvailableLabel
		
		bikeAvailableValueLabel.textColor = viewModel?.bikeLabelColor
	}
	
	// MARK: - Behaviors
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		 super.touchesBegan(touches, with: event)
		 animate(isHighlighted: true)
	 }

	 override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		 super.touchesEnded(touches, with: event)
		 animate(isHighlighted: false)
	 }

	 override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
		 super.touchesCancelled(touches, with: event)
		 animate(isHighlighted: false)
	 }

	 private func animate(isHighlighted: Bool, completion: ((Bool) -> Void)?=nil) {
		 let animationOptions: UIView.AnimationOptions = [.allowUserInteraction]
		 if isHighlighted {
			 UIView.animate(
				withDuration: 0.2,
				delay: 0,
				usingSpringWithDamping: 1,
				initialSpringVelocity: 0,
				options: animationOptions, animations: {
					self.transform = .init(scaleX: 0.96, y: 0.96
					)
				}, completion: completion
			 )
		 } else {
			 UIView.animate(
				withDuration: 0.2,
				delay: 0,
				usingSpringWithDamping: 1,
				initialSpringVelocity: 0,
				options: animationOptions, animations: {
					self.transform = .identity
				}, completion: completion
			 )
		 }
	 }
}

// MARK: - Preview
#if DEBUG
#Preview("StationListViewCell") {
	StationListViewCell(
		style: .default,
		reuseIdentifier: nil
	)
}
#endif
