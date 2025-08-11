// URLExtensions.swift
// Copyright (c) 2025 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.

import Foundation

/// Extend Foundation URL object with additional helper methods
public extension URL {
    /// Initialize a new `URL` object from a urlString with error handling
    /// - Parameter urlString: String to convert to a `URL`, expected to be in the correct format
    /// - Throws: `HeliumError.invalidURL` when the string cannot be converted to a `URL`
    /// - Returns:
    static func from(string urlString: String) throws -> URL {
        guard
            let url = URL(string: urlString)
        else {
            throw HeliumError.invalidURL(url: urlString)
        }
        return url
    }
}
