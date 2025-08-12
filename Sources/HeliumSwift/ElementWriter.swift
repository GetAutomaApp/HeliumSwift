// ElementWriter.swift
// Copyright (c) 2025 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.

import SwiftWebDriver

/// Send text/write to a specific element
internal struct ElementWriter {
    private let text: String
    private let element: Element

    /// Initialize `ElementWriter`
    /// - Parameters:
    ///   - text: `String`, the text to write to the element
    ///   - element: `Element`, the element to write the text to
    ///
    public init(text: String, element: Element) {
        self.text = text
        self.element = element
    }

    /// Write text string to element
    public func write() async throws {
        try await element.send(value: text)
    }
}
