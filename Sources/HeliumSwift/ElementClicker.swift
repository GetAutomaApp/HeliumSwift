// ElementClicker.swift
// Copyright (c) 2025 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.

import SwiftWebDriver

internal struct ElementClicker {
    private let element: Element

    /// Initialize `ElementClicker`
    /// - Parameter element: `Element`, the SwiftWebDriver element you want to click on
    public init(element: Element) {
        self.element = element
    }

    /// Click on the element
    /// - Throws: An error if there is a problem clicking on the element
    public func click() async throws {
        try await element.click()
    }
}
