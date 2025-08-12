// WriteMethodIntegrationTests.swift
// Copyright (c) 2025 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.

import Testing

@testable import HeliumSwift

@Suite("Write Method Integration Tests")
internal class WriteMethodIntegrationTests: DriverIntegrationTest {
    @Test("Write To HeliumElement")
    public func writeToHeliumElement() async throws {
        page = "0.html"
        try await driver.navigateTo(urlString: testPageURL.absoluteString)

        let elementInnerText = "textInnerText"
        let elementId = "findElementByInnerText"

        try await driver.execute("""
        let inputElement = document.getElementById("\(elementId)")
        inputElement.innerText = "\(elementInnerText)"
        """)

        let textToSendToElement = "bob"
        try await Helium.write(
            text: textToSendToElement,
            element: .init(driver: driver, elementInnerText: elementInnerText, matchType: .exactMatch)
        )

        let elementValue = try await getElementValue(selectorString: "getElementById('\(elementId)')")

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

        let elementValue = try await getElementValue(selectorString: "getElementById('\(elementId)')")

        #expect(elementValue == textToSendToActiveWindow)
    }

    private func getElementValue(selectorString: String) async throws -> String {
        guard
            let elementValue = try await driver.execute("return document.\(selectorString).value").value?
            .stringValue
        else {
            let errorMessage = "Element value could not be converted to a string"
            #expect(Bool(false), .init(rawValue: errorMessage))
            throw HeliumError.unknown(message: errorMessage)
        }
        return elementValue
    }
}
