// ChromeStarter.swift
// Copyright (c) 2025 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.

import Foundation
import Logging
import SwiftWebDriver

internal struct ChromeStarter {
    /// Chrome starter payload
    public let payload: ChromeStarterPayload

    /// Start Chrome driver instance
    public func startChrome() async throws -> WebDriver<ChromeDriver> {
        let driver = try createDriver()
        try await startDriver(driver)

        if let url = payload.url {
            try await navigateDriverTo(url: url, driver: driver)
        }

        return driver
    }

    private func navigateDriverTo(url: URL, driver: WebDriver<ChromeDriver>) async throws {
        try await driver.navigateTo(url: url)
        payload.logger.info(
            "Navigating Chrome driver to URL.",
            metadata: [
                "to": .string("\(String(describing: Self.self)).\(#function)"),
                "url": .string(url.absoluteString),
            ]
        )
    }

    private func startDriver(_ driver: WebDriver<ChromeDriver>) async throws {
        try await driver.start()
        payload.logger.info(
            "Started new Chrome driver success.",
            metadata: [
                "to": .string("\(String(describing: Self.self)).\(#function)"),
            ]
        )
    }

    private func createDriver() throws -> WebDriver<ChromeDriver> {
        payload.logger.info(
            "Starting new Chrome driver.",
            metadata: [
                "to": .string("\(String(describing: Self.self)).\(#function)"),
            ]
        )
        return try WebDriver(
            driver: ChromeDriver(
                browserObject: payload.options
            )
        )
    }
}

/// `ChromeStarter` payload
public struct ChromeStarterPayload {
    /// Logger to log messages to program output
    public let logger: Logger

    /// Optional URL to navigate the driver to
    public let url: URL?

    /// ChromeOptions to initialize the browser instance with
    public let options: ChromeOptions

    /// Initialize `ChromeStarterPayload`
    /// - Parameters:
    ///   - urlString: Optional URL as `String`, when provided the driver will navigate to
    ///   - headless: Optional boolean, when provided as true, the driver will run in the background without any UI
    /// displayed
    ///   - maximize: Optional `Boolean`, when provided as true, the driver window will be fully maximized on the
    /// display
    ///   - options: Optional `ChromeOptions`, when provided will be used to configure the Chrome instance
    ///
    /// - Throws: `HeliumError.invalidURL` if the `urlString` parameter cannot be converted to a `URL` if provided
    public init(
        logger: Logger,
        urlString: String? = nil,
        headless: Bool? = nil,
        maximize: Bool? = nil,
        options: ChromeOptions? = nil
    ) throws {
        self.logger = logger

        if let urlString {
            url = try URL.from(string: urlString)
        } else {
            url = nil
        }

        var optionsCreator = ChromeOptionsCreator(
            headless: headless, maximize: maximize, options: options
        )
        self.options = optionsCreator.createChromeOptions()
    }

    private struct ChromeOptionsCreator {
        private let headless: Bool?
        private let maximize: Bool?
        private let options: ChromeOptions?
        private var chromeOptionArguments: [Args] = []

        /// Initialize a new `ChromeOptionsCreator` object
        public init(headless: Bool? = nil, maximize: Bool? = nil, options: ChromeOptions? = nil) {
            self.headless = headless
            self.maximize = maximize
            self.options = options
        }

        /// Create `ChromeOptions` object
        public mutating func createChromeOptions()
            -> ChromeOptions
        {
            if headless != nil && headless == true {
                addArgument(Args(.headless))
            }
            if maximize != nil && maximize == true {
                addArgument(Args(.startMaximized))
            }

            if let options, let additionalArguments = options.args {
                addArguments(additionalArguments)
            }

            removeAllDuplicateArguments()

            return .init(args: chromeOptionArguments)
        }

        private mutating func addArgument(_ arg: Args) {
            chromeOptionArguments.append(arg)
        }

        private mutating func addArguments(_ args: [Args]) {
            chromeOptionArguments.insert(contentsOf: args, at: 1)
        }

        private mutating func removeAllDuplicateArguments() {
            chromeOptionArguments = Array(Set(chromeOptionArguments))
        }
    }
}
