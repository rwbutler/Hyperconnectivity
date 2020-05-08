//
//  Subscription.swift
//  Hyperconnectivity
//
//  Created by Ross Butler on 07/05/2020.
//

import Foundation
import Combine

class ConnectivitySubscription<S: Subscriber>: Subscription where S.Input == ConnectivityResult, S.Failure == Never {
    private var connectivity: Hyperconnectivity?
    private var subscriber: S?

    init(subscriber: S) {
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
        connectivity = Hyperconnectivity()
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
