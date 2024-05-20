//
//  ApiError.swift
//  BikeSpotter
//
//  Created by Jakub Legut on 10/05/2024.
//

import Foundation

public enum ApiError: Error {
	case invalidURL(String)
	case badServerResponse(String)
	case unknownDataType(String)
	case unknown(String)
}
