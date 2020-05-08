//
//  Connection.swift
//  Hyperconnectivity
//
//  Created by Ross Butler on 07/05/2020.
//

import Foundation
import Network

public enum Connection {
    case cellular
    case disconnected
    case ethernet
    case loopback
    case other
    case wifi
    
    init(_ interfaceType: NWInterface.InterfaceType) {
        switch interfaceType {
        case .cellular:
            self = .cellular
        case .loopback:
            self = .loopback
        case .other:
            self = .other
        case .wifi:
            self = .wifi
        case .wiredEthernet:
            self = .ethernet
        @unknown default:
            self = .other
        }
    }
    
    init(_ path: NWPath) {
        if path.usesInterfaceType(.wiredEthernet) {
            self = .ethernet
        } else if path.usesInterfaceType(.wifi) {
            self = .wifi
        } else if path.usesInterfaceType(.cellular) {
            self = .cellular
        } else if path.usesInterfaceType(.other) {
            self = .other
        } else if path.usesInterfaceType(.loopback) {
            self = .loopback
        } else {
            self = .disconnected
        }
    }
}
