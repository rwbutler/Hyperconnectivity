//
//  MockResponseValidator.swift
//  Hyperconnectivity
//
//  Created by Ross Butler on 13/05/2022.
//  Copyright © 2022 Ross Butler. All rights reserved.
//

import Foundation
import Hyperconnectivity

class MockResponseValidator: ResponseValidator {
    private let isResponseValid: Bool
    private (set) var isResponseValidCalled = false
    private (set) var lastData: Data?
    private (set) var lastResponse: URLResponse?
    
    init(isResponseValid: Bool = true) {
        self.isResponseValid = isResponseValid
    }
    
    func isResponseValid(_ response: URLResponse, data: Data) -> Bool {
        isResponseValidCalled = true
        lastData = data
        lastResponse = response
        return isResponseValid
    }
}
