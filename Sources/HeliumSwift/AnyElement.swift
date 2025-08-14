// AnyElement.swift
// Copyright (c) 2025 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.

import SwiftWebDriver

/// Define a protocol that abstracts over all element types (HeliumElement, Element, etc), to support using different
/// element types for the same task
public protocol AnyElement {
    /// The underlying element
    var underlyingElement: Element { get }
}

extension Element: AnyElement {
    /// The underlying element, required property conform to `AnyElement`
    public var underlyingElement: Element { self }
}
