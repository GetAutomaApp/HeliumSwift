// StartBrowsersIntegrationTests.swift
// Copyright (c) 2026 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.

@testable import HeliumSwift
import Testing

@Suite("Start Browsers Integration Tests", .serialized)
internal struct StartBrowsersIntegrationTests {
    /// Test start chrome driver instance
    @Test
    public func `startChrome method`() async throws {
        let driver = try await Helium.startChrome()
        try await driver.stop()
    }

    /// Test start chrome driver instance
    @Test
    public func `startFirefox method`() async throws {
        let driver = try await Helium.startFirefox(
            payload: .init(driverURLString: "http://localhost:4445")
        )
        try await driver.stop()
    }
}
