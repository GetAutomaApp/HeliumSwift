// PressMethodIntegrationTests.swift
// Copyright (c) 2026 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.

@testable import HeliumSwift
import Testing

@Suite("Press Method Integration Tests", .serialized)
internal class PressMethodIntegrationTests: DriverIntegrationTest {
    @Test
    public func `Press Chord To Active Window`() async throws {
        page = "0.html"
        try await driver.navigateTo(urlString: testPageURL.absoluteString)

        let elementId = "findElementByInnerText"

        // focus on the element so that this element becomes the active element
        let element = try await driver.findElement(.css(.id(elementId)))
        try await element.click()

        let textToSendToActiveWindow = "randomText"
        try await Helium.write(text: textToSendToActiveWindow, driver: driver)

        let elementValue = try await getElementValue(element)
        #expect(elementValue == textToSendToActiveWindow)

        _ = try await Helium.press([.CONTROL], "a", driver)
        _ = try await Helium.press([.BACKSPACE], "", driver)

        let afterHittingControlBackspaceElementValue = try await getElementValue(element)
        #expect(afterHittingControlBackspaceElementValue == "")
    }

    @Test
    public func `Press Chord To SwiftWebDriver Element`() async throws {
        page = "0.html"
        try await driver.navigateTo(urlString: testPageURL.absoluteString)

        let elementId = "findElementByInnerText"
        let element = try await driver.findElement(.css(.id(elementId)))

        let textToSendToElement = "randomText"
        try await Helium.write(text: textToSendToElement, element: element)

        let elementValue = try await getElementValue(element)
        #expect(elementValue == textToSendToElement)

        _ = try await Helium.press([.CONTROL], "a", element)
        _ = try await Helium.press([.BACKSPACE], "", element)

        let afterHittingControlBackspaceElementValue = try await getElementValue(element)
        #expect(afterHittingControlBackspaceElementValue == "")
    }

    deinit {}
}
