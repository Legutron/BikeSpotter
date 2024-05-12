//
//  SpotValueModel.swift
//  BikeSpotter
//
//  Created by Jakub Legut on 09/05/2024.
//

import UIKit

struct SpotValueModel {
	let iconName: String
	let value: Int
	let title: String
	let color: UIColor
	
	init(
		iconName: String,
		value: Int,
		title: String,
		color: UIColor = .black
	) {
		self.iconName = iconName
		self.value = value
		self.title = title
		self.color = color
	}
}
