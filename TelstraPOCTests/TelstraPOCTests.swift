//
//  TelstraPOCTests.swift
//  TelstraPOCTests
//
//  Created by Anil Gupta on 17/12/20.
//  Copyright © 2020 Anil Gupta. All rights reserved.
//

import XCTest
@testable import TelstraPOC

class TelstraPOCTests: XCTestCase {
    var urlSession: URLSession!
    let homeViewController = HomeViewController()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    // Test table view present at home screen
    func testViewController() {
     XCTAssertNotNil(homeViewController.tableView, "should have a table view" )
    }
    override func setUp() {
      super.setUp()
      urlSession = URLSession(configuration: .default)
    }

    override func tearDown() {
      urlSession = nil
      super.tearDown()
    }
    // Asynchronous api call unit test cases for success and fail.
    func testHomeDataGetsHTTPStatusCode200() {
      let url = URL(string: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json")
      let promise = expectation(description: "Status code: 200")
      // when
      let dataTask = urlSession.dataTask(with: url!) { data, response, error in
        // then
        if let error = error {
          XCTFail("Error: \(error.localizedDescription)")
          return
        } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
          if statusCode == 200 {
            promise.fulfill() // tells process is complete
          } else {
            XCTFail("Status code: \(statusCode)")  // show error
          }
        }
      }
      dataTask.resume()
      wait(for: [promise], timeout: 5) // tells wait for 5secs or throw error
    }

}
