//
//  Configuration.swift
//  Hyperconnectivity
//
//  Created by Ross Butler on 07/05/2020.
//

import Foundation

public struct HyperconnectivityConfiguration {
    public static let defaultConnectivityLinks: [ConnectivityLink] = [
        URL(string: "https://www.apple.com/library/test/success.html"),
        URL(string: "https://captive.apple.com/hotspot-detect.html")
    ].compactMap { url in
        guard let url = url else { return nil }
        return .url(url)
    }
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
    let connectivityLinks: [ConnectivityLink]
    let responseValidator: ResponseValidator
    let shouldCheckConnectivity: Bool
    
    /// % successful connections required to be deemed to have connectivity
    let successThreshold: Percentage
    let urlSessionConfiguration: URLSessionConfiguration
    
    public init(callbackQueue: DispatchQueue = DispatchQueue.main,
                connectivityQueue: DispatchQueue = DispatchQueue.global(qos: .utility),
                connectivityLinks: [ConnectivityLink] = Self.defaultConnectivityLinks,
                responseValidator: ResponseValidator? = nil,
                shouldCheckConnectivity: Bool = true,
                successThreshold: Percentage = Percentage(50.0),
                urlSessionConfiguration: URLSessionConfiguration = Self.defaultURLSessionConfiguration
    ) {
        let defaultValidator = ResponseStringValidator(
            validationMode: .containsExpectedResponseString
        )
        self.callbackQueue = callbackQueue
        self.connectivityQueue = connectivityQueue
        self.connectivityLinks = connectivityLinks
        self.responseValidator = responseValidator ?? defaultValidator
        self.shouldCheckConnectivity = shouldCheckConnectivity
        self.successThreshold = successThreshold
        self.urlSessionConfiguration = urlSessionConfiguration
    }
    
    func cloneForReachability() -> Self {
        return HyperconnectivityConfiguration(
            callbackQueue: callbackQueue,
            connectivityQueue: connectivityQueue,
            connectivityLinks: [],
            responseValidator: responseValidator,
            shouldCheckConnectivity: false,
            successThreshold: Percentage(0.0),
            urlSessionConfiguration: urlSessionConfiguration)
    }
    
    /// Convenience method for determining whether or not the response is valid.
    func isResponseValid(_ response: (Data, URLResponse)) -> Bool {
        responseValidator.isResponseValid(response.1, data: response.0)
    }
}
