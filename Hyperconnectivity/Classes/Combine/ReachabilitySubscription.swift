//
//  ReachabilitySubscription.swift
//  Hyperconnectivity
//
//  Created by Ross Butler on 08/05/2020.
//

import Foundation
import Combine

class ReachabilitySubscription<S: Subscriber>: Subscription where S.Input == ReachabilityResult, S.Failure == Never {
    private let connectivity = Hyperconnectivity()
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

private extension ReachabilitySubscription {
    
    private func startNotifier(with subscriber: S) {
        let reachabilityChanged: (ReachabilityResult) -> Void = { result in
            _ = subscriber.receive(result)
        }
        connectivity.reachabilityChanged = reachabilityChanged
        connectivity.startNotifier()
    }
    
    private func stopNotifier() {
        connectivity.stopNotifier()
        subscriber = nil
    }
}

