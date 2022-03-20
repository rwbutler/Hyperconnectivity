//
//  ReachabilityPublisherTests.swift
//  Hyperconnectivity
//
//  Created by Ross Butler on 17/05/2020.
//  Copyright © 2020 Ross Butler. All rights reserved.
//

import Combine
import Foundation
import OHHTTPStubs
import XCTest
@testable import Hyperconnectivity

class ReachabilityPublisherTests: XCTestCase {
    private var cancellable: AnyCancellable?
    private let timeout: TimeInterval = 5.0
    
    func testSubscriberInvokedOnSuccessfulReachabilityCheck() throws {
        let expectation = XCTestExpectation(description: "Reachability check succeeds")
        cancellable = Publishers.Reachability().sink(receiveCompletion: { _ in
        }, receiveValue: { result in
            XCTAssert(result.connection == .wifi || result.connection == .ethernet)
            XCTAssertTrue(result.isReachable)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: timeout)
    }
}
