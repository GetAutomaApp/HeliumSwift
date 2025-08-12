// HeliumIntegrationTests.swift
// Copyright (c) 2025 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.

import Testing

@testable import HeliumSwift

@Suite("`Helium` Integration Tests")
internal struct HeliumIntegrationTests {
    /// Test start chrome driver instance
    @Test("Test `startChrome` method")
    public func startChromeMethod() async throws {
        let driver = try await Helium.startChrome()
        try await driver.stop()
    }

    /// Test `goTo` method success - valid urls
    @Test(
        "Test `goTo` method success cases",
        arguments: ["https://google.com", "https://youtube.com", "https://instagram.com"]
    )
    public func goToMethodValidURLs(url: String) async throws {
        let driver = try await Helium.startChrome()
        try await Helium.goTo(driver: driver, urlString: url)
    }

    /// Test `goTo` method failure cases - invalid urls - no schemes
    @Test(
        "Test `goTo` method failure cases - invalid urls - no schemes",
        arguments: ["anotherInvalidURL", "invalidURL", "httpsinvalid-url"]
    )
    public func goToMethodInvalidURLs(url: String) async throws {
        let driver = try await Helium.startChrome()
        await #expect(throws: HeliumError.invalidURL(url: url, reason: .noScheme), "Invalid URL") {
            try await Helium.goTo(driver: driver, urlString: url)
        }
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
            throws: HeliumError.invalidURL(url: url, reason: .invalidScheme(
                scheme: urlComponent.0,
                reason: "only http and https allowed"
            )),
            "Invalid URL"
        ) {
            try await Helium.goTo(driver: driver, urlString: url)
        }
    }
}
