//
//  ConnectivityOperation.swift
//  Hyperconnectivity
//
//  Created by Ross Butler on 07/05/2020.
//

import Foundation

final class HyperconnectivityOperation: Operation {

    private let completion: (Bool) -> Void

    init(completion: @escaping (Bool) -> Void) {
        self.completion = completion
        super.init()
    }

    override func main() {
        guard !isCancelled else {
            return
        }
        print("Importing content..")

    }
}
