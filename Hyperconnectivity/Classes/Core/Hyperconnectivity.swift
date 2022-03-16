//
//  Hyperconnectivity.swift
//  Hyperconnectivity
//
//  Created by Ross Butler on 07/05/2020.
//

import Combine
import Foundation
import Network

public class Hyperconnectivity {
    
    // MARK: Type declarations
    public typealias Configuration = HyperconnectivityConfiguration
    public typealias ConnectivityChanged = (ConnectivityResult) -> Void
    public typealias Publisher = ConnectivityPublisher
    public typealias ReachabilityChanged = (ReachabilityResult) -> Void
    public typealias State = ConnectivityState
    
    // MARK: State
    private var cancellable: AnyCancellable?
    private let configuration: Configuration
    internal var connectivityChanged: ConnectivityChanged?
    private let notifier = NotificationCenter.default
    private var pathMonitor: NWPathMonitor?
    internal var reachabilityChanged: ReachabilityChanged?
    
    required init(configuration: Configuration = Configuration()) {
        self.configuration = configuration
    }
    
    func startNotifier() {
        let configuration = self.configuration
        let pathMonitor = NWPathMonitor()
        pathMonitor.pathUpdateHandler = { [weak self] path in
            guard let strongSelf = self else {
                return
            }
            strongSelf.handleReachability(for: path)
            if configuration.shouldCheckConnectivity {
                strongSelf.checkConnectivity(of: path, using: configuration)
            }
        }
        self.pathMonitor = pathMonitor
        notifier.post(name: .ConnectivityDidStart, object: nil)
        pathMonitor.start(queue: configuration.connectivityQueue)
    }
    
    func stopNotifier() {
        cancellable?.cancel()
        cancellable = nil
        notifier.post(name: .ConnectivityDidFinish, object: nil)
        pathMonitor = nil
    }
}

private extension Hyperconnectivity {
    private func checkConnectivity(of path: NWPath, using configuration: Configuration) {
        // Ensure that we never use cached results, including with custom `URLSessionConfiguration`s.
        let urlSessionConfiguration = configuration.urlSessionConfiguration.copy() as! URLSessionConfiguration
        urlSessionConfiguration.requestCachePolicy = .reloadIgnoringCacheData
        urlSessionConfiguration.urlCache = nil
        
        let publishers = configuration.connectivityURLs.map { url in
            URLSession(configuration: urlSessionConfiguration).dataTaskPublisher(for: url)
        }
        let totalChecks = UInt(configuration.connectivityURLs.count)
        let result = ConnectivityResult(path: path, successThreshold: configuration.successThreshold, totalChecks: totalChecks)
        let combinedPublisher = Publishers.MergeMany(publishers)
        cancellable =  combinedPublisher.sink(receiveCompletion:{ [weak self] _ in
            self?.connectivityChanged(result)
        }, receiveValue: { [weak self] response in
            result.connectivityCheck(successful: configuration.isResponseValid(response))
            guard result.isConnected else {
                return
            }
            self?.connectivityChanged(result)
        })
    }
    
    private func connectivityChanged(_ result: ConnectivityResult) {
        connectivityChanged?(result)
        cancellable?.cancel()
        notifier.post(name: .ConnectivityDidChange, object: result)
    }
    
    private func handleReachability(for path: NWPath) {
        let result = ReachabilityResult(path: path)
        reachabilityChanged?(result)
    }
}
