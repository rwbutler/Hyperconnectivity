//
//  Configuration.swift
//  Hyperconnectivity
//
//  Created by Ross Butler on 07/05/2020.
//

import Foundation

typealias Configuration = HyperconnectivityConfiguration // For internal use.

public class HyperconnectivityConfiguration {
    public static let defaultConnectivityURLs = [
        URL(string: "https://www.apple.com/library/test/success.html"),
        URL(string: "https://captive.apple.com/hotspot-detect.html")
    ]
        .compactMap { $0 }
    public static let defaultURLSessionConfiguration: URLSessionConfiguration = {
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.requestCachePolicy = .reloadIgnoringCacheData
        sessionConfiguration.urlCache = nil
        sessionConfiguration.timeoutIntervalForRequest = 5.0
        sessionConfiguration.timeoutIntervalForResource = 5.0
        return sessionConfiguration
    }()
    
    let callbackQueue: DispatchQueue
    let connectivityQueue: DispatchQueue
    let connectivityURLs: [URL]
    private (set) var pollingInterval: Double
    private (set) var  pollingIsEnabled: Bool
    private (set) var  pollWhileOfflineOnly: Bool
    private (set) var responseValidator: ResponseValidator
    let shouldCheckConnectivity: Bool
    
    /// % successful connections required to be deemed to have connectivity
    let successThreshold: Percentage
    private (set) var urlSessionConfiguration: URLSessionConfiguration
    
    public init(
        callbackQueue: DispatchQueue = DispatchQueue.main,
        connectivityQueue: DispatchQueue = DispatchQueue.global(qos: .default),
        connectivityURLs: [URL] = defaultConnectivityURLs,
        pollingInterval: Double = 10.0,
        pollingIsEnabled: Bool = true,
        pollWhileOfflineOnly: Bool = true,
        responseValidator: ResponseValidator = ResponseStringValidator(
            validationMode: .containsExpectedResponseString
        ),
        shouldCheckConnectivity: Bool = true,
        successThreshold: Percentage = Percentage(50.0),
        urlSessionConfiguration: URLSessionConfiguration = defaultURLSessionConfiguration
    ) {
        self.callbackQueue = callbackQueue
        self.connectivityQueue = connectivityQueue
        self.connectivityURLs = connectivityURLs
        self.pollingInterval = pollingInterval
        self.pollingIsEnabled = pollingIsEnabled
        self.pollWhileOfflineOnly = pollWhileOfflineOnly
        self.responseValidator = responseValidator
        self.shouldCheckConnectivity = shouldCheckConnectivity
        self.successThreshold = successThreshold
        self.urlSessionConfiguration = urlSessionConfiguration
    }
    
    func cloneForReachability() -> HyperconnectivityConfiguration {
        return HyperconnectivityConfiguration(
            callbackQueue: callbackQueue,
            connectivityQueue: connectivityQueue,
            connectivityURLs: [],
            responseValidator: responseValidator,
            shouldCheckConnectivity: false,
            successThreshold: Percentage(0.0),
            urlSessionConfiguration: urlSessionConfiguration
        )
        .configurePolling(isEnabled: false)
    }
    
    public func configurePolling(isEnabled: Bool = true, interval: Double = 10.0, offlineOnly: Bool = true) -> Self {
        pollingIsEnabled = isEnabled
        pollingInterval = interval
        pollWhileOfflineOnly = offlineOnly
        return self
    }
    
    public func configureResponseValidation(_ validation: ResponseStringValidator.ValidationMode, expected: String) -> Self {
        responseValidator = ResponseStringValidator(validationMode: validation, expectedResponse: expected)
        return self
    }
    
    public func configureResponseValidator(_ responseValidator: ResponseValidator) -> Self {
        self.responseValidator = responseValidator
        return self
    }
    
    public func configureURLSession(_ urlSessionConfiguration: URLSessionConfiguration) -> Self {
        self.urlSessionConfiguration = urlSessionConfiguration
        return self
    }
    
    /// Convenience method for determining whether or not the response is valid.
    func isResponseValid(_ response: (Data, URLResponse)) -> Bool {
        responseValidator.isResponseValid(response.1, data: response.0)
    }
}
