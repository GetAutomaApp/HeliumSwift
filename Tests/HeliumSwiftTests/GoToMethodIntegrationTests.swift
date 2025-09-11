// GoToMethodIntegrationTests.swift
// Copyright (c) 2025 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.

import AutomaUtilities
import Testing

@testable import HeliumSwift

@Suite("`goTo Method Integration Tests", .serialized)
internal class GoToMethodIntegrationTests: HeliumIntegrationTest {
    /// Test `goTo` method success - valid urls
    @Test(
        "Test `goTo` method success cases",
        arguments: ["google.com", "http://youtube.com", "https://instagram.com"]
    )
    public func goToMethodValidURLs(url: String) async throws {
        let driver = try await Helium.startChrome(payload: .init(logger: logger))
        try await Helium.goTo(driver: driver, urlString: url)
    }

    /// Test `goTo` method failure cases - invalid urls - invalid schemes
    @Test(
        "Test `goTo` method failure cases - invalid urls - invalid schemes",
        arguments: [
            ("ssh", "invalid-scheme"),
            ("obsidian", "hyperlink-to-external-application"),
            ("randomscheme", "invalid-scheme")
        ]
    )
    public func goToMethodInvalidSchemeURLs(urlComponent: (String, String)) async throws {
        let driver = try await Helium.startChrome()
        let url = "\(urlComponent.0)://\(urlComponent.1)"

        await #expect(
            throws: AutomaGenericErrors.invalidURL(url: url, reason: .invalidScheme(
                scheme: urlComponent.0,
                reason: "only http and https allowed"
            )),
            "Invalid URL"
        ) {
            try await Helium.goTo(driver: driver, urlString: url)
        }
    }

    deinit {}
}
