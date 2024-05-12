//
//  Asset.swift
//  BikeSpotter
//
//  Created by Jakub Legut on 10/05/2024.
//

import UIKit

// in the future it'is good to use automation like SwiftGen to generate asset inputs.
public enum Asset {
	static let color = AppColors()
	static let image = AppImages()
}

public struct AppImages {
	let backIcon = "back_icon"
	let bikeIcon = "bike_icon"
	let lockIcon = "lock_icon"
}

public struct AppColors {
	let backgroundPrimary = UIColor(named: "background_primary")
	let backgroundSecondary = UIColor(named: "background_secondary")
	let backgroundNavbar = UIColor(named: "background_navbar")
	let backgroundActive = UIColor(named: "background_active")
	let contentPositive = UIColor(named: "content_positive")
	let contentNegative = UIColor(named: "content_negative")
}
