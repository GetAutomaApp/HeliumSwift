// HeliumElement.swift
// Copyright (c) 2025 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.

import SwiftWebDriver

public struct HeliumElement<T: Driver> {
    public let element: Element
    private let driver: WebDriver<T>

    public init(driver: WebDriver<T>, elementInnerText: String, matchType: ElementByTextMatchType) async throws {
        self.driver = driver
        element = try await ElementByTextFinder(driver: driver).findElementByText(
            elementInnerText,
            matchType: matchType
        )
    }
}
