//
//  NonCachingURLSessionConfigurationFactoryTests.swift
//  Hyperconnectivity_Tests
//
//  Created by Ross Butler on 20/03/2022.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
@testable import Hyperconnectivity
import XCTest

class NonCachingURLSessionConfigurationFactoryTests: XCTestCase {
    /// Tests that given a `URLSessionConfiguration` object with a response cache set, the factory will return a  `URLSessionConfiguration` object which does not cache.
    func testResponseCachingIsDisabled() {
        let sut = NonCachingURLSessionConfigurationFactory()
        let originalURLSessionConfiguration = URLSessionConfiguration.default
        XCTAssertNotNil(originalURLSessionConfiguration.urlCache)
        let newURLSessionConfiguration = sut.urlSessionConfiguration(from: originalURLSessionConfiguration)
        XCTAssertNil(newURLSessionConfiguration.urlCache, "URL cache should be nil.")
    }
    
    /// Tests that the `URLSessionConfiguration` passed as input to the factory is copied i.e. the output of the factory is a different object.
    func testThatFactoryProducesACopy() {
        let sut = NonCachingURLSessionConfigurationFactory()
        let originalURLSessionConfiguration = URLSessionConfiguration.default
        let newURLSessionConfiguration = sut.urlSessionConfiguration(from: originalURLSessionConfiguration)
        XCTAssertFalse(originalURLSessionConfiguration === newURLSessionConfiguration)
    }
    
    /// Tests that given a `URLSessionConfiguration` object passed as input to the factory, the request caching policy of the output ignores the local cache.
    func testRequestCachePolicyIgnoresLocalCache() {
        let sut = NonCachingURLSessionConfigurationFactory()
        let originalURLSessionConfiguration = URLSessionConfiguration.default
        XCTAssertEqual(originalURLSessionConfiguration.requestCachePolicy, .useProtocolCachePolicy)
        let newURLSessionConfiguration = sut.urlSessionConfiguration(from: originalURLSessionConfiguration)
        XCTAssertEqual(newURLSessionConfiguration.requestCachePolicy, .reloadIgnoringLocalCacheData)
    }
}
