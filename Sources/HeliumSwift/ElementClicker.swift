// ElementClicker.swift
// Copyright (c) 2025 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.

import SwiftWebDriver

internal struct ElementClicker {
    private let element: Element

    public init(element: Element) {
        self.element = element
    }

    public func click() async throws {
        try await element.click()
    }
}
