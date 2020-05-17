//
//  ResponseRegExValidatorTests.swift
//  Hyperconnectivity_Tests
//
//  Created by Ross Butler on 17/05/2020.
//  Copyright © 2020 Ross Butler. All rights reserved.
//

import Foundation
import XCTest
@testable import Hyperconnectivity

class ResponseRegExValidatorTests: XCTestCase {
    func testRegexStringValidation() throws {
        try checkValid(string: "test1234", matchedBy: "test[0-9]+", expectedResult: true)
        try checkValid(string: "testa1234", matchedBy: "test[0-9]+", expectedResult: false)
    }

    private func checkValid(
        string: String,
        matchedBy regEx: String,
        expectedResult: Bool,
        file: StaticString = #file,
        line: UInt = #line
    ) throws {
        let validator = ResponseRegExValidator(regEx: regEx)
        let data = try XCTUnwrap(string.data(using: .utf8))
        let url = try XCTUnwrap(URL(string: "https://example.com"))
        let response = URLResponse(url: url, mimeType: nil, expectedContentLength: data.count, textEncodingName: nil)
        let result = validator.isResponseValid(response, data: data)
        let expectedResultStr = expectedResult ? "match" : "not match"
        let message = "Expected \"\(string)\" to \(expectedResultStr) \(regEx) via regex"
        XCTAssertEqual(result, expectedResult, message, file: file, line: line)
    }

    func testResponseInvalidWhenDataIsNil() throws {
        let regEx = "test[0-9]+"
        let validator = ResponseRegExValidator(regEx: regEx)
        let url = try XCTUnwrap(URL(string: "https://example.com"))
        let data = try XCTUnwrap("".data(using: .utf8))
        let response = URLResponse(url: url, mimeType: nil, expectedContentLength: 0, textEncodingName: nil)
        let responseValid = validator.isResponseValid(response, data: data)
        XCTAssertFalse(responseValid)
    }
}
