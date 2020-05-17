//
//  ConnectivityPublisherTests.swift
//  Hyperconnectivity_Tests
//
//  Created by Ross Butler on 17/05/2020.
//  Copyright © 2020 Ross Butler. All rights reserved.
//

import Combine
import Foundation
import OHHTTPStubs
import XCTest
@testable import Hyperconnectivity

class ConnectivityPublisherTests: XCTestCase {
    
    private var cancellable: AnyCancellable?
    
    override func tearDown() {
        super.tearDown()
        HTTPStubs.removeAllStubs()
        cancellable = nil
    }
    
    private func stubHost(_ host: String, withHTMLFrom fileName: String) throws {
        let stubPath = try XCTUnwrap(OHPathForFile(fileName, type(of: self)))
        stub(condition: isHost(host)) { _ in
            return fixture(filePath: stubPath, headers: ["Content-Type": "text/html"])
        }
    }
    
    func testSubscriberInvokedOnSuccessfulConnectivityCheck() throws {
        try stubHost("captive.apple.com", withHTMLFrom: "string-contains-response.html")
        try stubHost("www.apple.com", withHTMLFrom: "string-contains-response.html")
        let expectation = XCTestExpectation(description: "Connectivity check succeeds")
        cancellable = Hyperconnectivity.Publisher().sink(receiveCompletion: { _ in
        }, receiveValue: { result in
            XCTAssertEqual(result.state, .wifiWithInternet)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testSubscriberInvokedOnFailedConnectivityCheck() throws {
        try stubHost("captive.apple.com", withHTMLFrom: "failure-response.html")
        try stubHost("www.apple.com", withHTMLFrom: "failure-response.html")
        let expectation = XCTestExpectation(description: "Connectivity check fails")
        cancellable = Hyperconnectivity.Publisher().sink(receiveCompletion: { _ in
        }, receiveValue: { result in
            print(result.state.description)
            XCTAssertEqual(result.state, .wifiWithoutInternet)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 2.0)
    }
}
