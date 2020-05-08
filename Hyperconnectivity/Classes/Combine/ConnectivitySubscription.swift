//
//  Subscription.swift
//  Hyperconnectivity
//
//  Created by Ross Butler on 07/05/2020.
//

import Foundation
import Combine

class ConnectivitySubscription<S: Subscriber>: Subscription where S.Input == ConnectivityResult, S.Failure == Never {
    private let configuration: Hyperconnectivity.Configuration
    private var connectivity: Hyperconnectivity?
    private var subscriber: S?

    init(configuration: Hyperconnectivity.Configuration, subscriber: S) {
        self.configuration = configuration
        self.subscriber = subscriber
        startNotifier(with: subscriber)
    }

    func cancel() {
        stopNotifier()
    }

    func request(_: Subscribers.Demand) {}
}

private extension ConnectivitySubscription {
    
    private func startNotifier(with subscriber: S) {
        connectivity = Hyperconnectivity(configuration: configuration)
        let connectivityChanged: (ConnectivityResult) -> Void = { connectivity in
            _ = subscriber.receive(connectivity)
        }
        connectivity?.connectivityChanged = connectivityChanged
        connectivity?.startNotifier()
    }
    
    private func stopNotifier() {
        connectivity?.stopNotifier()
        connectivity = nil
        subscriber = nil
    }
}
