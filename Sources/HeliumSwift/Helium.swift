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

    /// Send text to a `AnyElement`
    /// - Parameters:
    ///   - text: Text to send to element
    ///   - element: `E`, find an element from the driver
    ///
    /// - Throws: An error if there is a problem sending keys to the element
    public static func write<E: AnyElement>(text: String, element: E) async throws {
        try await ElementWriter(text: text, element: element.underlyingElement).write()
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

    /// Click on a `AnyElement`
    /// - Parameter element: `E`, the element to click on
    /// - Throws: An error if there is a problem clicking on the element
    public static func click<E: AnyElement>(element: E) async throws {
        try await ElementClicker(element: element.underlyingElement).click()
    }

    /// Double click on a `AnyElement`
    /// initializers
    /// - Parameter element: `E`, the element to click on
    /// - Throws: An error if there is a problem clicking on the element
    public static func doubleClick<E: AnyElement>(element: E) async throws {
        try await element.underlyingElement.doubleClick()
    }

    /// Drag and drop an element to another element
    /// - Parameters:
    ///   - driver: `D`, The driver you want to use to perform drag and drop implementation
    ///   - element: `E1`, the source element you want to drag
    ///   - targetElement: `E2`, the target element you want to drag the source element to
    ///
    /// - Throws: An error if there is a problem dragging the source element to the target element
    public static func drag<E1: AnyElement, E2: AnyElement, D: Driver>(
        driver: D,
        element: E1,
        to targetElement: E2
    ) async throws {
        try await driver.dragAndDrop(from: element.underlyingElement, to: targetElement.underlyingElement)
    }
}
