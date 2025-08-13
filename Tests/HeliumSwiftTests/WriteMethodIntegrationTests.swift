// WriteMethodIntegrationTests.swift
// Copyright (c) 2025 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.

import Testing

@testable import HeliumSwift

@Suite("Write Method Integration Tests", .serialized)
internal class WriteMethodIntegrationTests: DriverIntegrationTest {
    @Test("Write To HeliumElement")
    public func writeToHeliumElement() async throws {
        page = "0.html"
        try await driver.navigateTo(urlString: testPageURL.absoluteString)

        let elementInnerText = "textInnerText"
        let elementId = "findElementByInnerText"

        let element = try await driver.findElement(.css(.id(elementId)))

        try await driver.setProperty(element: element, propertyName: "innerText", newValue: elementInnerText)

        let textToSendToElement = "bob"

        try await Helium.write(
            text: textToSendToElement,
            element: .init(driver: driver, elementInnerText: elementInnerText, matchType: .exactMatch)
        )

        let elementValue = try await getElementValue(driver.findElement(.css(.id(elementId))))

        #expect(elementValue == textToSendToElement)
    }

    @Test("Write To Active Window")
    public func writeToActiveWindow() async throws {
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
    }

    @Test("Write To SwiftWebDriver Element")
    public func writeToSwiftWebDriverElement() async throws {
        page = "0.html"
        try await driver.navigateTo(urlString: testPageURL.absoluteString)

        let elementId = "findElementByInnerText"
        let element = try await driver.findElement(.css(.id(elementId)))

        let textToSendToElement = "randomText"
        try await Helium.write(text: textToSendToElement, element: element)

        let elementValue = try await getElementValue(element)

        #expect(elementValue == textToSendToElement)
    }

    private func getElementValue(_ element: Element) async throws -> String {
        guard
            let elementValue = try await driver.getProperty(element: element, propertyName: "value").value?.stringValue
        else {
            let errorMessage = "Element value could not be converted to a string"
            #expect(Bool(false), .init(rawValue: errorMessage))
            throw HeliumError.unknown(message: errorMessage)
        }

        return elementValue
    }

    deinit {}
}
