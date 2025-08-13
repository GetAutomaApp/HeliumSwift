// ElementByTextFinder.swift
// Copyright (c) 2025 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.

import SwiftWebDriver

internal struct ElementByTextFinder<T: Driver> {
    private let driver: WebDriver<T>

    /// Initialize `ElementByTextFinder`
    /// - Parameter driver: `WebDriver<T>`, the driver the element you are looking for is possibly located
    public init(driver: WebDriver<T>) {
        self.driver = driver
    }

    /// Find an element with matching inner text
    /// - Parameters:
    ///   - text: `String`, the text you are looking for in an element you want to find
    ///   - matchType: `ElementByTextFinderMatchType`, how to match the passed in `text` and element inner text (exact,
    /// partial, etc)
    ///
    /// - Throws: An error when there is a problem finding the element from the driver
    /// - Returns: `Element`, the element with matching inner text
    public func findElementByText(_ text: String, matchType: ElementByTextFinderMatchType) async throws -> Element {
        return try await driver.findElement(.xpath(matchType.getXpath(text: text)))
    }

    /// Find elements with matching inner text
    /// - Parameters:
    ///   - text: `String`, the text you are looking for in elements you want to find
    ///   - matchType: `ElementByTextFinderMatchType`, how to match the passed in `text` and elements inner text (exact,
    /// partial, etc)
    ///
    /// - Throws: An error when there is a problem finding elements from the driver
    /// - Returns: `Elements`, the elements with matching inner text
    public func findElementsByText(_ text: String, matchType: ElementByTextFinderMatchType) async throws -> Elements {
        return try await driver.findElements(.xpath(matchType.getXpath(text: text)))
    }
}

/// What type of match the `ElementByTextFinder` should do when looking for an element/elements
public enum ElementByTextFinderMatchType {
    /// text and element should match exactly after trimming surrounding whitespace characters from element text (e.g.
    /// text="hello", elementText="hello")
    /// whitespace from element text)
    case exactMatch

    /// text should be in element text (e.g. text="hello", elementText="hello world")
    case partialMatch

    /// Get the xpath string for the current match type instance
    /// - Parameter text: `String`, the text to look for in an element/elements
    /// - Returns: `String`, the xpath as a string
    public func getXpath(text: String) -> String {
        let xpath: String
        switch self {
        case .exactMatch:
            xpath = "//*[normalize-space(text())='\(text)']"
        default:
            xpath = "//*[contains(normalize-space(text()), '\(text)')]"
        }
        return xpath
    }
}
