// StartBrowsersIntegrationTests.swift
// Copyright (c) 2025 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.

import Testing

@testable import HeliumSwift

@Suite("Start Browsers Integration Tests", .serialized)
internal struct StartBrowsersIntegrationTests {
    /// Test start chrome driver instance
    @Test("Test `startChrome` method")
    public func startChromeMethod() async throws {
        let driver = try await Helium.startChrome()
        try await driver.stop()
    }
}
