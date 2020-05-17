//
//  ConnectivitySubscriptionTests.swift
//  Hyperconnectivity_Tests
//
//  Created by Ross Butler on 15/05/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import Combine
import Network
import XCTest
@testable import Hyperconnectivity

class ConnectivitySubscriptionTests: XCTestCase {
    private let timeout: TimeInterval = 5.0
    
    private func sut(subscriber: Subscribers.Sink<ConnectivityResult, Never>? = nil, connectivity: Connectivity? = nil) -> ConnectivitySubscription<Subscribers.Sink<ConnectivityResult, Never>> {
        let mockSubscriber = subscriber ?? Subscribers.Sink<ConnectivityResult, Never>(receiveCompletion: { _ in }) { _ in }
        let mockConfiguration = Hyperconnectivity.Configuration()
        return ConnectivitySubscription(
            configuration: mockConfiguration,
            connectivity: connectivity,
            subscriber: mockSubscriber
        )
    }
    
    func testNotifierStartedWhenSubscriptionCreated() {
        let mockConfiguration = Hyperconnectivity.Configuration()
        let mockConnectivity = MockConnectivity(configuration: mockConfiguration)
        _ = sut(connectivity: mockConnectivity)
        XCTAssertTrue(mockConnectivity.startNotifierInvoked)
    }
    
    func testNotifierStoppedWhenSubscriptionCancelled() {
        let mockConfiguration = Hyperconnectivity.Configuration()
        let mockConnectivity = MockConnectivity(configuration: mockConfiguration)
        let sut = self.sut(connectivity: mockConnectivity)
        sut.cancel()
        XCTAssertTrue(mockConnectivity.stopNotifierInvoked)
    }
    
    func testNotificationSentWhenSubscriptionCreated() {
        expectation(
            forNotification: .ConnectivityDidStart,
            object: nil,
            handler: nil
        )
        _ = sut()
        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    func testNotificationSentWhenSubscriptionCancelled() {
        expectation(
            forNotification: .ConnectivityDidFinish,
            object: nil,
            handler: nil
        )
        let sut = self.sut()
        sut.cancel()
        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    func testSubscriberCompletesWhenSubscriptionCancelled() {
        let connectivityFinishedExpectation = expectation(description: "Connectivity finished")
        let mockSubscriber = Subscribers.Sink<ConnectivityResult, Never>(receiveCompletion: { _ in
            connectivityFinishedExpectation.fulfill()
        }) { _ in}
        let sut = self.sut(subscriber: mockSubscriber)
        sut.cancel()
        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    func testSubscriberNotifiedWhenConnectivityChanged() {
        let mockConfiguration = Hyperconnectivity.Configuration()
        let connectivityChangedExpectation = expectation(description: "Connectivity changed")
        let mockSubscriber = Subscribers.Sink<ConnectivityResult, Never>(receiveCompletion: { _ in }) { _ in
            connectivityChangedExpectation.fulfill()
        }
        let mockConnectivity = MockConnectivity(configuration: mockConfiguration)
        _ = sut(subscriber: mockSubscriber, connectivity: mockConnectivity)
        let mockPath = MockPath(interfaceType: .wiredEthernet)
        let mockResult = ConnectivityResult(path: mockPath, successThreshold: Percentage(100.0), totalChecks: 0)
        mockConnectivity.connectivityChanged?(mockResult)
        waitForExpectations(timeout: timeout, handler: nil)
    }
}
