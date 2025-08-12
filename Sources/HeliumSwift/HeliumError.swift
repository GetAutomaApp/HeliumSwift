// HeliumError.swift
// Copyright (c) 2025 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.

internal enum HeliumError: Error {
    case invalidURL(url: String)
    case unknown(message: String)
}
