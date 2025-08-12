// URLExtensions.swift
// Copyright (c) 2025 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.

import Foundation

/// Extend Foundation URL object with additional helper methods
internal extension URL {
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
    static func fromString(payload: URLFromStringPayload) throws -> URL {
        return try URLFromStringCreator(payload: payload).create()
    }
}

internal struct URLFromStringCreator {
    private let payload: URLFromStringPayload

    public init(payload: URLFromStringPayload) {
        self.payload = payload
    }

    public func create() throws -> URL {
        let url = try getURL()
        try validateURLScheme(url: url)
        return url
    }

    private func validateURLScheme(url: URL) throws {
        let scheme = try unwrapSchemeFrom(url: url)
        try validateSchemeIsHttpOrHttps(url: url, scheme: scheme)
    }

    private func validateSchemeIsHttpOrHttps(url: URL, scheme: String) throws {
        if payload.onlyHttpOrHttpsScheme == false {
            return
        }

        if ["http", "https"].contains(scheme) == false {
            throw HeliumError.invalidURL(
                url: url.absoluteString,
                reason: .invalidScheme(scheme: scheme, reason: "only http and https allowed")
            )
        }
    }

    private func unwrapSchemeFrom(url: URL) throws -> String {
        guard
            let scheme = url.scheme
        else {
            throw HeliumError.invalidURL(url: url.absoluteString, reason: .noScheme)
        }
        return scheme
    }

    private func getURL() throws -> URL {
        let urlString = getURLString()
        return try urlStringToURL(urlString)
    }

    private func getURLString() -> String {
        var urlStringFinal: String = payload.urlString

        if payload.asHttp, urlStringFinal.contains("://") == false {
            urlStringFinal = "http://" + urlStringFinal
        }
        return urlStringFinal
    }

    private func urlStringToURL(_ urlString: String) throws -> URL {
        guard
            let url = URL(string: urlString)
        else {
            throw HeliumError.invalidURL(url: urlString)
        }
        return url
    }
}

internal struct URLFromStringPayload {
    public let urlString: String
    public let asHttp: Bool
    public let onlyHttpOrHttpsScheme: Bool

    init(string urlString: String, asHttp: Bool = false, onlyHttpOrHttpsScheme: Bool = true) {
        self.urlString = urlString
        self.asHttp = asHttp
        self.onlyHttpOrHttpsScheme = onlyHttpOrHttpsScheme
    }
}
