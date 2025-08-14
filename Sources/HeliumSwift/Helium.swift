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

    /// Send text to a `HeliumElement` - use this method if you want to use one of Helium's special element initializers
    /// - Parameters:
    ///   - text: Text to send to element
    ///   - element: `HeliumElement`, find an element from the driver using one of Helium's special initializers
    ///
    /// - Throws: An error if there is a problem sending keys to the element
    public static func write<T: Driver>(text: String, element: HeliumElement<T>) async throws {
        try await write(text: text, element: element.element)
    }

    /// Send text to a SwiftWebDriver `Element`
    /// - Parameters:
    ///   - text: `String`, text to send to element
    ///   - element: `Element`, the element to send the keys to
    ///
    /// - Throws: An error if there is a problem sending keys to passed in element
    public static func write(text: String, element: Element) async throws {
        try await ElementWriter(text: text, element: element).write()
    }

    /// Send text to the active element in the current window of the passed in driver
    /// - Parameters:
    ///   - text: `String`, text to send to element
    ///   - driver: `WebDriver<T>`, the driver to send the keys to
    ///
    /// - Throws: An error if there is a problem sending keys to the currently active element
    public static func write<T: Driver>(text: String, driver: WebDriver<T>) async throws {
        try await write(text: text, element: driver.getActiveElement())
    }

    /// Opens the specified URL in the passed in web driver window
    /// - Parameters:
    ///   - driver: `WebDriver<T>`, The driver you want the current window to navigate to the passed in URL
    ///   - urlString: `String`, The URL you want to navigate to you wan
    ///
    /// - Throws: `Helium.invalidURL` when URL format is invalid or an error when driver navigation failed
    public static func goTo<T>(driver: WebDriver<T>, urlString: String) async throws {
        let url = try URL.fromString(payload: .init(string: urlString, asHttp: true))
        try await driver.navigateTo(url: url)
    }

    /// Click on a `Element`
    /// - Parameter element: `Element`, the element to click on
    /// - Throws: An error if there is a problem clicking on the element
    public static func click(element: Element) async throws {
        try await ElementClicker(element: element).click()
    }

    /// Click on a `HeliumElement` - use this method if you want to use one of Helium's special element initializers
    /// - Parameter element: `HeliumElement`, find element from the driver using one of Helium's special initializers
    /// - Throws: An error if there is a problem clicking on the element
    public static func click<T: Driver>(element: HeliumElement<T>) async throws {
        try await click(element: element.element)
    }

    /// Double click on a `Element`
    /// initializers
    /// - Parameter element: `Element`, the element to click on
    /// - Throws: An error if there is a problem clicking on the element
    public static func doubleClick(element: Element) async throws {
        try await element.doubleClick()
    }

    /// Double click on a `HeliumElement` - use this method if you want to use one of Helium's special element
    /// initializers
    /// - Parameter element: `HeliumElement`, find element from the driver using one of Helium's special initializers
    /// - Throws: An error if there is a problem clicking on the element
    public static func doubleClick<T: Driver>(element: HeliumElement<T>) async throws {
        try await doubleClick(element: element.element)
    }
}
