//
//  MockConnectivity.swift
//  Hyperconnectivity_Tests
//
//  Created by Ross Butler on 17/05/2020.
//  Copyright © 2020 Ross Butler. All rights reserved.
//

import Foundation
@testable import Hyperconnectivity

class MockConnectivity: Connectivity {
    var connectivityChanged: Hyperconnectivity.ConnectivityChanged?
    var initInvoked = false
    var startNotifierInvoked = false
    var stopNotifierInvoked = false
    
    required init(configuration: Hyperconnectivity.Configuration) {
        initInvoked = true
    }
    
    func startNotifier() {
        startNotifierInvoked = true
    }
    
    func stopNotifier() {
        stopNotifierInvoked = true
    }
}
