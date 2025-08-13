// HeliumElements.swift
// Copyright (c) 2025 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.

import SwiftWebDriver

/// HeliumElements, providing useful initialization methods to get Elements (e.g. `[Element]`)
public typealias HeliumElements<T: Driver> = Elements

/// HeliumElements extensions, with useful static initialization methods to get Elements (e.g. `[Element]`)
public extension HeliumElements {
    /// Find Elements with specific `innerText`, using `matchType` to configure what elements to match
    /// - Parameters:
    ///   - driver: `WebDriver<T>`, the driver to find the elements from
    ///   - elementsInnerText: `String`, the text the elements you want to find should match
    ///   - matchType: `ElementByTextMatchType`, the matching method (e.g. exact match, partial match, etc)
    ///
    /// - Throws: An error if there is a problem finding elements
    /// - Returns: `Elements`, the matched elements
    static func from<T: Driver>(
        driver: WebDriver<T>,
        elementsInnerText: String,
        matchType: ElementByTextFinderMatchType
    ) async throws -> Elements {
        return try await ElementByTextFinder(driver: driver).findElementsByText(
            elementsInnerText,
            matchType: matchType
        )
    }
}
