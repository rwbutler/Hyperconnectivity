//
//  ResponseContainsStringValidatorTests.swift
//  Hyperconnectivity_Tests
//
//  Created by Ross Butler on 17/05/2020.
//  Copyright © 2020 Ross Butler. All rights reserved.
//

import Foundation
import OHHTTPStubs
#if canImport(OHHTTPStubsSwift)
import OHHTTPStubsSwift
#endif
import XCTest
@testable import Hyperconnectivity

class ResponseContainsStringValidatorTests: XCTestCase {
    private let timeout: TimeInterval = 5.0
    
    override func tearDown() {
        super.tearDown()
        HTTPStubs.removeAllStubs()
    }
    
    private func stubHost(_ host: String, withHTMLFrom fileName: String) throws {
#if SWIFT_PACKAGE
        let bundle = Bundle.module
#else
        let bundle = Bundle(for: type(of: self))
#endif
        let fileURL = bundle.url(
            forResource: (fileName as NSString).deletingPathExtension,
            withExtension: (fileName as NSString).pathExtension
        )
        let stubPath = try XCTUnwrap(fileURL?.relativePath)
        stub(condition: isHost(host)) { _ in
            return fixture(filePath: stubPath, headers: ["Content-Type": "text/html"])
        }
    }
    
    /// Test response is valid when the response string contains the expected response.
    func testContainsExpectedResponseString() throws {
        try stubHost("www.apple.com", withHTMLFrom: "string-contains-response.html")
        let expectation = XCTestExpectation(description: "Connectivity check succeeds")
        let config = Hyperconnectivity.Configuration(responseValidator: ResponseContainsStringValidator(expectedResponse: "Success"))
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
    
    /// Test response is valid when the response string does not contain the expected response.
    func testDoesNotContainExpectedResponseString() throws {
        try stubHost("www.apple.com", withHTMLFrom: "string-contains-response.html")
        let expectation = XCTestExpectation(description: "Connectivity check succeeds")
        let config = Hyperconnectivity.Configuration(responseValidator: ResponseContainsStringValidator(expectedResponse: "Failure"))
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
