// HeliumElements.swift
// Copyright (c) 2025 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.

import SwiftWebDriver

typealias HeliumElements<T: Driver> = Elements

public extension HeliumElements {
    static func from<T: Driver>(
        driver: WebDriver<T>,
        elementsInnerText: String,
        matchType: ElementByTextMatchType
    ) async throws -> Elements {
        return try await ElementByTextFinder(driver: driver).findElementsByText(
            elementsInnerText,
            matchType: matchType
        )
    }
}
