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
    
    func testDescriptionForCellularWithInternetIsCorrect() {
        let sut = ConnectivityState.cellularWithInternet
        XCTAssertEqual(sut.description, "Cellular with Internet connectivity")
    }
    
    func testDescriptionForCellularWithoutInternetIsCorrect() {
        let sut = ConnectivityState.cellularWithoutInternet
        XCTAssertEqual(sut.description, "Cellular without Internet connectivity")
    }
    
    func testDescriptionForDisconnectedIsCorrect() {
        let sut = ConnectivityState.disconnected
        XCTAssertEqual(sut.description, "Disconnected")
    }
    
    func testDescriptionForEthernetWithInternetIsCorrect() {
        let sut = ConnectivityState.ethernetWithInternet
        XCTAssertEqual(sut.description, "Ethernet with Internet connectivity")
    }
    
    func testDescriptionForethernetWithoutInternetIsCorrect() {
        let sut = ConnectivityState.ethernetWithoutInternet
        XCTAssertEqual(sut.description, "Ethernet without Internet connectivity")
    }
    
    func testDescriptionForLoopbackIsCorrect() {
        let sut = ConnectivityState.loopback
        XCTAssertEqual(sut.description, "Loopback")
    }
    
    func testDescriptionForOtherWithInternetIsCorrect() {
        let sut = ConnectivityState.otherWithInternet
        XCTAssertEqual(sut.description, "Other with Internet connectivity")
    }
    
    func testDescriptionForOtherWithoutInternetIsCorrect() {
        let sut = ConnectivityState.otherWithoutInternet
        XCTAssertEqual(sut.description, "Other without Internet connectivity")
    }
    
    func testDescriptionForWiFiWithInternetIsCorrect() {
        let sut = ConnectivityState.wifiWithInternet
        XCTAssertEqual(sut.description, "Wi-Fi with Internet connectivity")
    }
    
    func testDescriptionForWiFiWithoutInternetIsCorrect() {
        let sut = ConnectivityState.wifiWithoutInternet
        XCTAssertEqual(sut.description, "Wi-Fi without Internet connectivity")
    }

}
