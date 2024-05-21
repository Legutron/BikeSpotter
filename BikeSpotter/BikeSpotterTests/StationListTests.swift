//
//  StationListTest.swift
//  BikeSpotterTests
//
//  Created by Jakub Legut on 17/05/2024.
//

@testable import BikeSpotter
import XCTest

final class BikeSpotterListTests: XCTestCase {
	
	override func setUpWithError() throws {
		continueAfterFailure = false
	}
	
	func testFetchOneMockStations() throws {
		let vm = StationListViewModel(api: ApiMock())
		let timeInterval: TimeInterval = 0.2 // wait for async
		let expectation = expectation(description: "Test after \(timeInterval) seconds")
		
		vm.onLoad()
		_ = XCTWaiter.wait(for: [expectation], timeout: timeInterval)
		XCTAssertEqual(vm.cellViewModels.count, 1)
	}
	
	func testFetchApiStations() throws {
		let vm = StationListViewModel()
		let timeInterval: TimeInterval = 4.0 // adjust to the internet speed
		let expectation = expectation(description: "Test after \(timeInterval) seconds")
		
		vm.onLoad()
		_ = XCTWaiter.wait(for: [expectation], timeout: timeInterval)
		XCTAssertEqual(vm.cellViewModels.isEmpty, false)
	}
}
