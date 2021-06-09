//
//  BlackSwanTestTests.swift
//  BlackSwanTestTests
//
//  Created by Максим Ламанский on 09.06.2021.
//

import XCTest
@testable import BlackSwanTest

class BlackSwanTestTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCount() throws {
        let testAccess = TestAccessOrder.shared
        
        let id: UInt = 10
        
        let viewModel: MainScreenViewModelDelegate = MainScreenViewModel()
        
        viewModel.addOrders(for: id)
        
        XCTAssertTrue(testAccess.orders.count == 3, "Wrong count!")
    }

    func testDate() throws {
            
        let dateStr = Date().toString()
        
        XCTAssertTrue(dateStr.count == 8, "Wrong count!")
    }

    func testFailure() throws {
        let testAccess = TestAccessOrder.shared
        
        let id: UInt = 10
        
        let viewModel: MainScreenViewModelDelegate = MainScreenViewModel()
        
        viewModel.addOrders(for: id)
        
        XCTAssertFalse(testAccess.orders.count != 6, "Wrong count!")
    }


}
