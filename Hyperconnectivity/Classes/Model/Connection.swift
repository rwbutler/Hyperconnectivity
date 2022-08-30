//
//  Connection.swift
//  Hyperconnectivity
//
//  Created by Ross Butler on 07/05/2020.
//

import Foundation
import Network

protocol Path {
    var isExpensive: Bool { get }
    var ipAddress: String? { get }
    func usesInterfaceType(_ type: NWInterface.InterfaceType) -> Bool
}

extension NWPath: Path {
    var ipAddress: String? {
        guard
            let endpoint = gateways.first,
            case let .hostPort(host, _) = endpoint,
            case .ipv6 = host
        else {
            return availableInterfaces.first?.ipv4
        }

        return endpoint.interface?.ipv6
    }
}

public enum Connection {
    case cellular(ipAddress: String?)
    case disconnected
    case ethernet(ipAddress: String?)
    case loopback(ipAddress: String?)
    case other(ipAddress: String?)
    case wifi(ipAddress: String?)
    
    init(_ path: Path) {
        if path.usesInterfaceType(.wiredEthernet) {
            self = .ethernet(ipAddress: path.ipAddress)
        } else if path.usesInterfaceType(.wifi) {
            self = .wifi(ipAddress: path.ipAddress)
        } else if path.usesInterfaceType(.cellular) {
            self = .cellular(ipAddress: path.ipAddress)
        } else if path.usesInterfaceType(.other) {
            self = .other(ipAddress: path.ipAddress)
        } else if path.usesInterfaceType(.loopback) {
            self = .loopback(ipAddress: path.ipAddress)
        } else {
            self = .disconnected
        }
    }
}

extension Connection: Equatable {
    public static func == (lhs: Connection, rhs: Connection) -> Bool {
        switch (lhs, rhs) {
        case (.cellular(let lhIP), .cellular(let rhIP)),
            (.ethernet(let lhIP), .ethernet(let rhIP)),
            (.loopback(let lhIP), .loopback(let rhIP)),
            (.other(let lhIP), .other(let rhIP)),
            (.wifi(let lhIP), .wifi(let rhIP)):
            return lhIP == rhIP

        case (.disconnected, .disconnected):
            return true

        default:
            return false

        }
    }
}

public extension Connection {
    var ipAddress: String? {
        switch self {
        case .disconnected:
            return nil

        case .loopback(let ip),
                .cellular(let ip),
                .ethernet(let ip),
                .other(let ip),
                .wifi(let ip):
            return ip
        }
    }
}

private extension NWInterface {
    func address(family: Int32) -> String? {
        var address: String?

        // Get list of all interfaces on the local machine:
        var ifaddr: UnsafeMutablePointer<ifaddrs>?
        guard getifaddrs(&ifaddr) == 0, let firstAddr = ifaddr else { return nil }

        // For each interface ...
        for ifptr in sequence(first: firstAddr, next: { $0.pointee.ifa_next }) {
            let interface = ifptr.pointee

            let addrFamily = interface.ifa_addr.pointee.sa_family
            if addrFamily == UInt8(family)
            {
                // Check interface name:
                if name == String(cString: interface.ifa_name) {
                    // Convert interface address to a human readable string:
                    var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                    getnameinfo(interface.ifa_addr, socklen_t(interface.ifa_addr.pointee.sa_len),
                                &hostname, socklen_t(hostname.count),
                                nil, socklen_t(0), NI_NUMERICHOST)
                    address = String(cString: hostname)
                }
            }
        }
        freeifaddrs(ifaddr)

        return address
    }

    var ipv4 : String? { self.address(family: AF_INET) }
    var ipv6 : String? { self.address(family: AF_INET6) }
}
