// Helium.swift
// Copyright (c) 2025 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.

import Foundation
import SwiftWebDriver

/// Main object that simplifies the use of Selenium
public enum Helium {
    /// Create a new Chrome browser instance with minimal lines of code, specify some common option
    /// - Parameter payload: `ChromeStarterPayload`, a payload to easily configure driver options
    /// - Throws: An error if there is a problem instantiating/starting the driver, or when navigating to a URL if
    /// provided in the options
    /// - Returns: `WebDriver<ChromeDriver>`
    public static func startChrome(payload: ChromeStarterPayload? = nil)
        async throws -> WebDriver<ChromeDriver>
    {
        return try await ChromeStarter(payload: payload).startChrome()
    }

    /// Opens the specified URL in the passed in web driver window
    /// - Parameters:
    ///   - driver: `WebDriver<T>`, The driver you want the current window to navigate to the passed in URL
    ///   - url: `String`, The URL you want to navigate to you wan
    ///
    /// - Throws: `Helium.invalidURL` when URL format is invalid or an error when driver navigation failed
    public static func goTo<T>(driver: WebDriver<T>, url: String) async throws {
        let url = try URL.from(string: url)
        try await driver.navigateTo(url: url)
    }
}
