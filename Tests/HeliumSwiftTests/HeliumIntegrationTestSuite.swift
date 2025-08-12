// HeliumIntegrationTestSuite.swift
// Copyright (c) 2025 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.

import Logging

internal protocol HeliumIntegrationTestBase {
    var logger: Logger { get }
}

internal class HeliumIntegrationTest: HeliumIntegrationTestBase {
    public let logger: Logger

    public init() {
        logger = Logger(label: "heliumswift.helium-integration-tests")
    }
}
