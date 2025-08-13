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

        try await driver.execute("""
        let inputElement = document.getElementById("findElementByInnerText")
        inputElement.innerText = "\(elementInnerText)"
        """)

        try await Helium.click(element: .init(
            driver: driver,
            elementInnerText: elementInnerText,
            matchType: .exactMatch
        ))
    }

    @Test("Click on SwiftWebDriver Element")
    public func clickOnSwiftWebDriverElement() async throws {
        page = "0.html"
        try await driver.navigateTo(urlString: testPageURL.absoluteString)
        try await driver.findElement(.css(.id("findElementByInnerText"))).click()
    }

    deinit {}
}
