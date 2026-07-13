// DriverIntegrationTest.swift
// Copyright (c) 2026 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.

import Foundation
@testable import HeliumSwift
import SwiftWebDriver
import Testing

internal protocol DriverIntegrationTestsBase {
    var driver: WebDriver<ChromeDriver> { get set }
    var testPageURL: URL { get }
    var baseUrl: String { get }
    var page: String { get set }
}

internal class DriverIntegrationTest: DriverIntegrationTestsBase {
    public let baseUrl: String = "http://localhost"
    public var testPageURL: URL {
        // swiftlint:disable:next force_unwrapping
        .init(string: "\(baseUrl)/\(page)")!
    }

    public var page: String = "index.html"
    public var driver: WebDriver<ChromeDriver>

    public init() async throws {
        // swiftlint:disable:next force_unwrapping
        let driverURL = URL(string: "http://localhost:4444")!
        let chromeOptions = ChromeOptions(args: [
            ChromeArgs(.disableDevShmUsage),
            ChromeArgs(.noSandbox),
        ])

        // Initialize the WebDriver on the main actor
        driver = WebDriver(
            driver: ChromeDriver(
                driverURL: driverURL,
                browserObject: chromeOptions
            )
        )

        try await driver.start()
    }

    internal func getElementValue(_ element: Element) async throws -> String {
        guard
            let elementValue = try await driver.getProperty(element: element, propertyName:
                "value").value?.stringValue
        else {
            let errorMessage = "Element value could not be converted to a string"
            #expect(Bool(false), .init(rawValue: errorMessage))
            throw HeliumError.unknown(message: errorMessage)
        }

        return elementValue
    }

    deinit {}
}
