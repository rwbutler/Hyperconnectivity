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
#if canImport(OHHTTPStubsSwift)
import OHHTTPStubsSwift
#endif
import XCTest
@testable import Hyperconnectivity

class ConnectivityPublisherTests: XCTestCase {
    private var cancellable: AnyCancellable?
    private let timeout: TimeInterval = 5.0
    
    override func tearDown() {
        super.tearDown()
        HTTPStubs.removeAllStubs()
        cancellable = nil
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
    
    func testSubscriberInvokedOnSuccessfulConnectivityCheck() throws {
        try stubHost("captive.apple.com", withHTMLFrom: "string-contains-response.html")
        try stubHost("www.apple.com", withHTMLFrom: "string-contains-response.html")
        let expectation = XCTestExpectation(description: "Connectivity check succeeds")
        cancellable = Hyperconnectivity.Publisher().sink(receiveCompletion: { _ in
        }, receiveValue: { result in
            XCTAssert(result.state == .wifiWithInternet || result.state == .ethernetWithInternet)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: timeout)
    }
    
    func testSubscriberInvokedOnFailedConnectivityCheck() throws {
        try stubHost("captive.apple.com", withHTMLFrom: "failure-response.html")
        try stubHost("www.apple.com", withHTMLFrom: "failure-response.html")
        let expectation = XCTestExpectation(description: "Connectivity check fails")
        cancellable = Hyperconnectivity.Publisher().sink(receiveCompletion: { _ in
        }, receiveValue: { result in
            XCTAssert(result.state == .wifiWithoutInternet || result.state == .ethernetWithoutInternet)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: timeout)
    }
}
