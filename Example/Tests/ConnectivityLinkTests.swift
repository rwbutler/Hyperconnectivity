//
//  ConnectivityLinkTests.swift
//  Hyperconnectivity_Tests
//
//  Created by Bruno Miguens on 13/10/2022.
//  Copyright © 2022 Bruno Miguens. All rights reserved.
//

import Foundation
import XCTest
@testable import Hyperconnectivity

class ConnectivityLinkTests: XCTestCase {
    
    func testIfUrlConstructsDataTaskPublisher() {
        let url = URL(string: "https://github.com")!
        let sut = URLSession(configuration: .default).dataTaskPublisher(for: ConnectivityLink.url(url))
        XCTAssertEqual(sut.request.url, url)
    }
    
    func testIfUrRequestlConstructsDataTaskPublisher() {
        let urlRequest = URLRequest(url: URL(string: "https://github.com")!)
        let sut = URLSession(configuration: .default).dataTaskPublisher(for: ConnectivityLink.request(urlRequest))
        XCTAssertEqual(sut.request, urlRequest)
    }
    
    func testIfUrRequestlConstructsDataTaskPublisherWithCustomData() {
        var urlRequest = URLRequest(url: URL(string: "https://github.com")!)
        urlRequest.setValue("Value", forHTTPHeaderField: "Field")
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = Data()
        
        let sut = URLSession(configuration: .default).dataTaskPublisher(for: ConnectivityLink.request(urlRequest))
        XCTAssertEqual(sut.request, urlRequest)
    }

}
