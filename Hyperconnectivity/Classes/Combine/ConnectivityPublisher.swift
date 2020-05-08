//
//  Publisher.swift
//  Hyperconnectivity
//
//  Created by Ross Butler on 07/05/2020.
//

import Combine
import Foundation

public struct ConnectivityPublisher: Publisher {
    
    // MARK: - Type Definitions
    public typealias Failure = Never
    public typealias Output = ConnectivityResult
    
    public init() {}
    
    public func receive<S>(subscriber: S) where S : Subscriber, Self.Failure == S.Failure, Self.Output == S.Input {
        let subscription = ConnectivitySubscription(subscriber: subscriber)
        subscriber.receive(subscription: subscription)
    }
}

