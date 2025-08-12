// ElementWriter.swift
// Copyright (c) 2025 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.

import SwiftWebDriver

internal struct ElementWriter {
    private let text: String
    private let element: Element

    public init(text: String, element: Element) {
        self.text = text
        self.element = element
    }

    public func write() async throws {
        try await element.send(value: text)
    }
}
