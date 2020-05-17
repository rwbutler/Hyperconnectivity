//
//  MockPath.swift
//  Hyperconnectivity_Tests
//
//  Created by Ross Butler on 17/05/2020.
//  Copyright © 2020 Ross Butler. All rights reserved.
//

import Foundation
import Network
@testable import Hyperconnectivity

struct MockPath: Path {
    var isExpensive: Bool = false
    private let interfaceType: NWInterface.InterfaceType?
    
    init(interfaceType: NWInterface.InterfaceType?) {
        self.interfaceType = interfaceType
    }
    
    func usesInterfaceType(_ type: NWInterface.InterfaceType) -> Bool {
        return interfaceType == type
    }
}
