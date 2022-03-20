//
//  ResponseStringValidatorTests.swift
//  Hyperconnectivity_Tests
//
//  Created by Ross Butler on 17/05/2020.
//  Copyright © 2020 Ross Butler. All rights reserved.
//

import Foundation
import OHHTTPStubs
import XCTest
@testable import Hyperconnectivity

class ResponseStringEqualityValidatorTests: XCTestCase {
    private let timeout: TimeInterval = 5.0

    override func tearDown() {
        super.tearDown()
        HTTPStubs.removeAllStubs()
    }

    private func stubHost(_ host: String, withHTMLFrom fileName: String) throws {
        let stubPath = try XCTUnwrap(OHPathForFile(fileName, type(of: self)))
        stub(condition: isHost(host)) { _ in
            return fixture(filePath: stubPath, headers: ["Content-Type": "text/html"])
        }
    }

    /// Test response is valid when the response string is equal to the expected response.
    func testEqualsExpectedResponseString() throws {
        try stubHost("www.apple.com", withHTMLFrom: "string-equality-response.html")
        let expectation = XCTestExpectation(description: "Connectivity check succeeds")
        let config = Hyperconnectivity.Configuration(responseValidator: ResponseStringEqualityValidator(expectedResponse: "Success"))
        let connectivity = Hyperconnectivity(configuration: config)
        let connectivityChanged: (ConnectivityResult) -> Void = { result in
            XCTAssert(result.state == .wifiWithInternet || result.state == .ethernetWithInternet)
            expectation.fulfill()
        }
        connectivity.connectivityChanged = connectivityChanged
        connectivity.startNotifier()
        wait(for: [expectation], timeout: timeout)
        connectivity.stopNotifier()
    }
    
    /// Test response is valid when the response string is equal to the expected response.
    func testEqualsExpectedSpecifiedResponseString() throws {
        try stubHost("www.apple.com", withHTMLFrom: "string-equality-response.html")
        let expectation = XCTestExpectation(description: "Connectivity check succeeds")
        let config = Hyperconnectivity.Configuration(responseValidator: ResponseStringEqualityValidator(expectedResponse: "Success"))
        let connectivity = Hyperconnectivity(configuration: config)
        let connectivityChanged: (ConnectivityResult) -> Void = { result in
            XCTAssert(result.state == .wifiWithInternet || result.state == .ethernetWithInternet)
            expectation.fulfill()
        }
        connectivity.connectivityChanged = connectivityChanged
        connectivity.startNotifier()
        wait(for: [expectation], timeout: timeout)
        connectivity.stopNotifier()
    }

    /// Test response is invalid when the response string is not equal to the expected response.
    func testNotEqualsExpectedResponseString() throws {
        try stubHost("www.apple.com", withHTMLFrom: "string-contains-response.html")
        let expectation = XCTestExpectation(description: "Connectivity check fails")
        let config = Hyperconnectivity.Configuration(responseValidator: ResponseStringEqualityValidator(expectedResponse: "Success"))
        let connectivity = Hyperconnectivity(configuration: config)
        let connectivityChanged: (ConnectivityResult) -> Void = { result in
            XCTAssert(result.state == .wifiWithoutInternet || result.state == .ethernetWithoutInternet)
            expectation.fulfill()
        }
        connectivity.connectivityChanged = connectivityChanged
        connectivity.startNotifier()
        wait(for: [expectation], timeout: timeout)
        connectivity.stopNotifier()
    }
}
