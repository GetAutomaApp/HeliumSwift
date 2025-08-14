// ClickMethodIntegrationTests.swift
// Copyright (c) 2025 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.

import Testing

@testable import HeliumSwift

@Suite("Click Method Integration Tests", .serialized)
internal class ClickMethodIntegrationTests: DriverIntegrationTest {
    @Test("Click on HeliumElement")
    public func clickOnHeliumElement() async throws {
        page = "0.html"
        try await driver.navigateTo(urlString: testPageURL.absoluteString)

        let elementInnerText = "textInnerText"

        let button = try await driver.findElement(.css(.id("button")))
        try await driver.setProperty(element: button, propertyName: "innerText", newValue: elementInnerText)

        try await Helium.click(element: .init(
            driver: driver,
            elementInnerText: elementInnerText,
            matchType: .exactMatch
        ))

        let test = try await button.text()
        #expect(test == "clicked!")
    }

    @Test("Click on SwiftWebDriver Element")
    public func clickOnSwiftWebDriverElement() async throws {
        page = "0.html"
        try await driver.navigateTo(urlString: testPageURL.absoluteString)

        let button = try await driver.findElement(.css(.id("button")))
        try await button.click()

        let test = try await button.text()
        #expect(test == "clicked!")
    }

    deinit {}
}
