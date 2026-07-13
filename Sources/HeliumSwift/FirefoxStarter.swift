// FirefoxStarter.swift
// Copyright (c) 2026 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.

import AutomaUtilities
import Foundation
import Logging
import SwiftWebDriver

internal struct FirefoxStarter {
    /// Firefox starter payload
    public let payload: FirefoxStarterPayload?

    /// Initialize `FirefoxStarter`
    /// - Parameter payload: `FirefoxStarterPayload?`, optional payload to pass into Firefox driver initializer
    public init(payload: FirefoxStarterPayload? = nil) {
        self.payload = payload
    }

    /// Start Firefox driver instance
    public func startFirefox() async throws -> WebDriver<FirefoxDriver> {
        let driver = try createDriver()
        try await startDriver(driver)

        if let url = payload?.url {
            try await navigateDriverTo(url: url, driver: driver)
        }

        return driver
    }

    private func navigateDriverTo(url: URL, driver: WebDriver<FirefoxDriver>) async throws {
        try await driver.navigateTo(url: url)
        payload?.logger?.info(
            "Navigating Firefox driver to URL.",
            metadata: [
                "to": .string("\(String(describing: Self.self)).\(#function)"),
                "url": .string(url.absoluteString),
            ]
        )
    }

    private func startDriver(_ driver: WebDriver<FirefoxDriver>) async throws {
        try await driver.start()
        payload?.logger?.info(
            "Started new Firefox driver success.",
            metadata: [
                "to": .string("\(String(describing: Self.self)).\(#function)"),
            ]
        )
    }

    private func createDriver() throws -> WebDriver<FirefoxDriver> {
        payload?.logger?.info(
            "Starting new Firefox driver.",
            metadata: [
                "to": .string("\(String(describing: Self.self)).\(#function)"),
            ]
        )
        return try WebDriver(
            driver: FirefoxDriver(
                browserObject: payload?.options ?? .init(args: [])
            )
        )
    }
}

/// `FirefoxStarter` payload
public struct FirefoxStarterPayload {
    /// Logger to log messages to program output
    public let logger: Logger?

    /// Optional URL to navigate the driver to
    public let url: URL?

    /// FirefoxOptions to initialize the browser instance with
    public let options: FirefoxOptions

    /// Initialize `FirefoxStarterPayload`
    /// - Parameters:
    ///   - urlString: Optional URL as `String`, when provided the driver will navigate to
    ///   - headless: Optional boolean, when provided as true, the driver will run in the background without any UI
    /// displayed
    /// display
    ///   - options: Optional `FirefoxOptions`, when provided will be used to configure the Firefox instance
    ///
    /// - Throws: `AutomaGenericErrors.invalidURL` if the `urlString` parameter cannot be converted to a `URL` if
    /// provided
    public init(
        logger: Logger? = nil,
        urlString: String? = nil,
        headless: Bool? = nil,
        options: FirefoxOptions? = nil
    ) throws {
        self.logger = logger

        if let urlString {
            url = try URL.fromString(payload: .init(string: urlString))
        } else {
            url = nil
        }

        var optionsCreator = FirefoxOptionsCreator(
            headless: headless, options: options
        )
        self.options = optionsCreator.createFirefoxOptions()
    }

    private struct FirefoxOptionsCreator {
        private var firefoxOptionArguments: [FirefoxArgs] = []
        private let headless: Bool?
        private let options: FirefoxOptions?

        /// Initialize a new `FirefoxOptionsCreator` object
        public init(
            headless: Bool? = nil,
            options: FirefoxOptions? = nil,
        ) {
            self.headless = headless
            self.options = options
        }

        /// Create `FirefoxOptions` object
        public mutating func createFirefoxOptions() -> FirefoxOptions {
            if headless != nil, headless == true {
                addArgument(FirefoxArgs(.headless))
            }

            if let options, let additionalArguments = options.args {
                addArguments(additionalArguments)
            }

            removeAllDuplicateArguments()

            return .init(args: firefoxOptionArguments)
        }

        private mutating func addArgument(_ arg: FirefoxArgs) {
            firefoxOptionArguments.append(arg)
        }

        private mutating func addArguments(_ args: [FirefoxArgs]) {
            firefoxOptionArguments.insert(contentsOf: args, at: 1)
        }

        private mutating func removeAllDuplicateArguments() {
            firefoxOptionArguments = Array(Set(firefoxOptionArguments))
        }
    }
}
