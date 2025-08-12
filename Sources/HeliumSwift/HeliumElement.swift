// HeliumElement.swift
// Copyright (c) 2025 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.

import SwiftWebDriver

/// HeliumElement, providing useful initialization methods for finding an element
public struct HeliumElement<T: Driver> {
    /// Element found from initialization method - access this property when you want access the found `Element`
    public let element: Element
    private let driver: WebDriver<T>

    /// Initialize `HeliumElement` by finding an element by text, specifying the match type
    /// - Parameters:
    ///   - driver: `WebDriver<T>`, the driver to look for the element with matching inner text
    ///   - elementInnerText: `String`, the matching text you are looking for in an element
    ///   - matchType: `ElementByTextMatchType`, what type of match to do when looking for an element with matching
    /// inner text (exact, partial, etc)
    ///
    /// - Throws: An error if there was a problem finding the element from the driver
    public init(driver: WebDriver<T>, elementInnerText: String, matchType: ElementByTextMatchType) async throws {
        self.driver = driver
        element = try await ElementByTextFinder(driver: driver).findElementByText(
            elementInnerText,
            matchType: matchType
        )
    }
}
