// URLExtensions.swift
// Copyright (c) 2025 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.

import Foundation

/// Extend Foundation URL object with additional helper methods
public extension URL {
    /// Initialize a new `URL` object from a urlString with error handling
    /// - Parameters:
    ///   - urlString: String to convert to a `URL`, expected to be in the correct format
    ///   - asHttp: `Bool` = false - Set the scheme to 'http' if no scheme is provided in `urlString`
    ///   - onlyHttpOrHttpsScheme: `Bool` = true - If true, an error will be thrown if `urlString` scheme is not "http"
    /// or "https"
    ///
    /// - Throws: `HeliumError.invalidURL` when the string cannot be converted to a `URL` or when scheme isn't 'http' or
    /// 'https' and `onlyHttpOrHttpsScheme` is true
    /// - Returns: `urlString` as `URL`
    static func from(string urlString: String, asHttp: Bool = false,
                     onlyHttpOrHttpsScheme: Bool = true) throws -> URL
    {
        var urlStringFinal: String = urlString

        if asHttp && urlString.contains("://") == false {
            urlStringFinal = "http://" + urlStringFinal
        }

        guard
            let url = URL(string: urlStringFinal)
        else {
            throw HeliumError.invalidURL(url: urlStringFinal)
        }

        guard
            let scheme = url.scheme
        else {
            throw HeliumError.invalidURL(url: urlString, reason: .noScheme)
        }

        if onlyHttpOrHttpsScheme == false {
            return url
        }
        if ["http", "https"].contains(scheme) == false {
            throw HeliumError.invalidURL(
                url: urlString,
                reason: .invalidScheme(scheme: scheme, reason: "only http and https allowed")
            )
        }
        return url
    }
}
