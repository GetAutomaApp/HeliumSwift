// ElementByTextFinder.swift
// Copyright (c) 2025 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.

import SwiftWebDriver

internal struct ElementByTextFinder<T: Driver> {
    private let driver: WebDriver<T>

    public init(driver: WebDriver<T>) {
        self.driver = driver
    }

    public func findElementByText(_ text: String, matchType: ElementByTextMatchType) async throws -> Element {
        return try await driver.findElement(.xpath(matchType.getXpath(text: text)))
    }

    public func findElementsByText(_ text: String, matchType: ElementByTextMatchType) async throws -> Elements {
        return try await driver.findElements(.xpath(matchType.getXpath(text: text)))
    }
}

public enum ElementByTextMatchType {
    case exactMatch
    case partialMatch

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
