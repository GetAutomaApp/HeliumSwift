// HeliumError.swift
// Copyright (c) 2025 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.

internal enum HeliumError: Error, Equatable {
    case invalidURL(url: String, reason: InvalidURLReason? = nil)
    case unknown(message: String)
}

internal enum InvalidURLReason: Equatable {
    case noScheme
    case invalidScheme(scheme: String, reason: String)
}
