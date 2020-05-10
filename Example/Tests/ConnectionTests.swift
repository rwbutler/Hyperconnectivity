//
//  ConnectionTests.swift
//  Hyperconnectivity
//
//  Created by Ross Butler on 10/05/2020.
//  Copyright © 2020 Ross Butler. All rights reserved.
//

import Foundation
import Network
import XCTest
@testable import Hyperconnectivity

struct MockPath: Path {
    private let interfaceType: NWInterface.InterfaceType?
    
    init(interfaceType: NWInterface.InterfaceType?) {
        self.interfaceType = interfaceType
    }
    
    func usesInterfaceType(_ type: NWInterface.InterfaceType) -> Bool {
        return interfaceType == type
    }
}

class ConnectionTests: XCTestCase {
    
    func testIfPathIsWiredEthernetThenConnectionIsEthernet() {
        let path = MockPath(interfaceType: .wiredEthernet)
        let sut = Connection(path)
        XCTAssertEqual(sut, .ethernet)
    }
    
    func testIfPathIsWiFiThenConnectionIsWiFi() {
        let path = MockPath(interfaceType: .wifi)
        let sut = Connection(path)
        XCTAssertEqual(sut, .wifi)
    }
    
    func testIfPathIsCellularThenConnectionIsCellular() {
        let path = MockPath(interfaceType: .cellular)
        let sut = Connection(path)
        XCTAssertEqual(sut, .cellular)
    }
    
    func testIfPathIsWiFiThenConnectionIsOther() {
        let path = MockPath(interfaceType: .other)
        let sut = Connection(path)
        XCTAssertEqual(sut, .other)
    }
    
    func testIfPathIsLoopbackThenConnectionIsLoopback() {
        let path = MockPath(interfaceType: .loopback)
        let sut = Connection(path)
        XCTAssertEqual(sut, .loopback)
    }
    
    func testIfPathIsNilThenConnectionIsDisconnected() {
        let path = MockPath(interfaceType: nil)
        let sut = Connection(path)
        XCTAssertEqual(sut, .disconnected)
    }

}
