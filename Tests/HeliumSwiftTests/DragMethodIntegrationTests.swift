// DragMethodIntegrationTests.swift
// Copyright (c) 2025 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.

import Testing

@testable import HeliumSwift

@Suite("Drag Method Integration Tests", .serialized)
internal class DragMethodIntegrationTests: DriverIntegrationTest {
    /// Test `Helium.drag()` method, a method to drag an element to another target element
    @Test("Drag Element To Another")
    public func dragElementToAnother() async throws {
        page = "dragBox.html"
        try await driver.navigateTo(urlString: testPageURL.absoluteString)

        let source = try await HeliumElement(driver: driver, elementInnerText: "SOURCE", matchType: .exactMatch)
        let target = try await driver.findElement(.css(.id("target")))
        try await Helium.drag(driver: driver, element: source, to: target)

        let targetText = try await driver.getProperty(element: target, propertyName: "innerText").value?.stringValue
        #expect(targetText == "DROPPED!", "Target text should be 'DROPPED!' after pointer drag")
    }

    deinit {}
}
