// DoubleClickMethodIntegrationTests.swift
// Copyright (c) 2025 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.

import Testing

@testable import HeliumSwift

@Suite("Double Click Method Integration Tests", .serialized)
internal class DoubleClickMethodIntegrationTests: DriverIntegrationTest {
    @Test("Double Click on HeliumElement")
    public func doubleClickOnHeliumElement() async throws {
        page = "0.html"
        try await driver.navigateTo(urlString: testPageURL.absoluteString)

        let elementInnerText = "textInnerText"

        let button = try await driver.findElement(.css(.id("doubleclick")))
        try await driver.setProperty(element: button, propertyName: "innerText", newValue: elementInnerText)

        let heliumElement: HeliumElement = try await .init(
            driver: driver,
            elementInnerText: elementInnerText,
            matchType: .exactMatch
        )

        try await Helium.doubleClick(element: heliumElement)

        let test = try await button.text()
        #expect(test == "\(elementInnerText)ii")
    }

    @Test("Double Click on SwiftWebDriver Element")
    public func doubleClickOnSwiftWebDriverElement() async throws {
        page = "0.html"
        try await driver.navigateTo(urlString: testPageURL.absoluteString)
        let button = try await driver.findElement(.css(.id("doubleclick")))
        try await button.doubleClick()

        let test = try await button.text()
        #expect(test == "ii")
    }

    deinit {}
}
