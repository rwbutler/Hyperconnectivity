//
//  ReachabilityResult.swift
//  Hyperconnectivity
//
//  Created by Ross Butler on 08/05/2020.
//

import Foundation
import Network

public struct ReachabilityResult {
    
    let connection: Connection
    let isExpensive: Bool
    let isReachable: Bool
    
    init(path: NWPath) {
        connection = Connection(path)
        isExpensive = path.isExpensive
        isReachable = path.status == .satisfied
    }
}
