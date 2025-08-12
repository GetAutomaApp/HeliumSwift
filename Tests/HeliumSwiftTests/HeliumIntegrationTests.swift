// HeliumIntegrationTests.swift
// Copyright (c) 2025 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.

import Testing

@testable import HeliumSwift

@Suite("HeliumIntegrationTests")
internal class HeliumIntegrationTests: HeliumIntegrationTest {
    /// Test start chrome driver instance
    @Test("Create Chrome")
    public func startChrome() async throws {
        let driver = try await Helium.startChrome(payload: .init(
            logger: logger,
            urlString: "https://google.com",
            headless: true,
            maximize: true,
            options: .init(args: [Args(.disableGPU)])
        ))
        try await driver.stop()
    }
}
