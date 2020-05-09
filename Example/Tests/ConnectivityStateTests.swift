//
//  ConnectivityStateTests.swift
//  Hyperconnectivity
//
//  Created by Ross Butler on 09/05/2020.
//  Copyright © 2020 Ross Butler. All rights reserved.
//

import Foundation
import XCTest
@testable import Hyperconnectivity

class ConnectivityStateTests: XCTestCase {
    
    func testConnectionIsCellularAndIsConnected() {
        let sut = ConnectivityState(connection: .cellular, isConnected: true)
        XCTAssertEqual(sut, .cellularWithInternet)
    }
    
    func testConnectionIsCellularAndIsNotConnected() {
        let sut = ConnectivityState(connection: .cellular, isConnected: false)
        XCTAssertEqual(sut, .cellularWithoutInternet)
    }
    
    func testConnectionIsDisconnectedAndIsConnected() {
        let sut = ConnectivityState(connection: .disconnected, isConnected: true)
        XCTAssertEqual(sut, .disconnected)
    }
    
    func testConnectionIsDisconnectedAndIsNotConnected() {
        let sut = ConnectivityState(connection: .disconnected, isConnected: false)
        XCTAssertEqual(sut, .disconnected)
    }
    
    func testConnectionIsEthernetAndIsConnected() {
        let sut = ConnectivityState(connection: .ethernet, isConnected: true)
        XCTAssertEqual(sut, .ethernetWithInternet)
    }
    
    func testConnectionIsEthernetAndIsNotConnected() {
        let sut = ConnectivityState(connection: .ethernet, isConnected: false)
        XCTAssertEqual(sut, .ethernetWithoutInternet)
    }
    
    func testConnectionIsLoopbackAndIsConnected() {
        let sut = ConnectivityState(connection: .loopback, isConnected: true)
        XCTAssertEqual(sut, .loopback)
    }
    
    func testConnectionIsLoopbackAndIsNotConnected() {
        let sut = ConnectivityState(connection: .loopback, isConnected: false)
        XCTAssertEqual(sut, .loopback)
    }
    
    func testConnectionIsOtherAndIsConnected() {
        let sut = ConnectivityState(connection: .other, isConnected: true)
        XCTAssertEqual(sut, .otherWithInternet)
    }
    
    func testConnectionIsOtherAndIsNotConnected() {
        let sut = ConnectivityState(connection: .other, isConnected: false)
        XCTAssertEqual(sut, .otherWithoutInternet)
    }
    
    func testConnectionIsWiFiAndIsConnected() {
        let sut = ConnectivityState(connection: .wifi, isConnected: true)
        XCTAssertEqual(sut, .wifiWithInternet)
    }
    
    func testConnectionIsWiFiAndIsNotConnected() {
        let sut = ConnectivityState(connection: .wifi, isConnected: false)
        XCTAssertEqual(sut, .wifiWithoutInternet)
    }

}
