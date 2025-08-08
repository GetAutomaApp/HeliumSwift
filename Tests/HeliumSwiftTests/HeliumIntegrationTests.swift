import Testing

@testable import HeliumSwift

@Suite("HeliumIntegrationTests")
internal struct HeliumIntegrationTests {
    @Test("Create Chrome ")
    func startChrome() async throws {
        let driver = try await Helium.startChrome(
            payload: .init(
                urlString: "https://google.com",
                headless: true,
                maximize: true,
                options: .init(args: [Args(.disableGPU)]))
        )
        try await driver.stop()
    }
}
