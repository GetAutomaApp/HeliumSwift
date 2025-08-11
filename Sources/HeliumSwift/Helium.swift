// Helium.swift
// Copyright (c) 2025 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.

import Foundation
import SwiftWebDriver

/// Main object that simplifies the use of Selenium
public enum Helium {
    /// Create a new chrome browser instance with minimal lines of code, specify some common option
    /// - Parameter payload: `ChromeStarterPayload`, a payload to easily configure driver options
    /// - Throws: An error if there is a problem instantiating/starting the driver, or when navigating to a URL if
    /// provided in the options
    /// - Returns: `WebDriver<ChromeDriver>`
    public static func startChrome(payload: ChromeStarterPayload)
        async throws -> WebDriver<ChromeDriver>
    {
        return try await ChromeStarter(payload: payload).startChrome()
    }
}

internal struct ChromeStarter {
    /// Chrome starter payload
    public let payload: ChromeStarterPayload

    /// Strart Chrome driver instance
    public func startChrome() async throws -> WebDriver<ChromeDriver> {
        let driver = try WebDriver(
            driver: ChromeDriver(
                browserObject: payload.options
            )
        )
        try await driver.start()

        if let url = payload.url {
            try await driver.navigateTo(url: url)
        }

        return driver
    }
}

/// `ChromeStarter` payload
public struct ChromeStarterPayload {
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
        urlString: String? = nil,
        headless: Bool? = nil,
        maximize: Bool? = nil,
        options: ChromeOptions? = nil
    ) throws {
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
