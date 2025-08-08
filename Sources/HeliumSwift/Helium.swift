import Foundation
import SwiftWebDriver

public struct Helium {
    static public func startChrome(payload: ChromeStarterPayload)
        async throws -> WebDriver<ChromeDriver>
    {
        return try await ChromeStarter(payload: payload).startChrome()
    }
}

internal struct ChromeStarter {
    let payload: ChromeStarterPayload

    public func startChrome() async throws -> WebDriver<ChromeDriver> {
        let driver = try WebDriver(
            driver: ChromeDriver(
                browserObject: payload.options
            )
        )
        try await driver.start()
        try await driver.navigateTo(url: payload.url)

        return driver
    }
}

public struct ChromeStarterPayload {
    public let url: URL
    public let options: ChromeOptions

    init(
        urlString: String,
        headless: Bool,
        maximize: Bool,
        options: ChromeOptions
    ) throws {
        self.url = try URL.from(string: urlString)
        var optionsCreator = ChromeOptionsCreator(
            headless: headless, maximize: maximize, options: options
        )
        self.options = optionsCreator.createChromeOptions()
    }

    private struct ChromeOptionsCreator {
        private let headless: Bool
        private let maximize: Bool
        private let options: ChromeOptions
        private var chromeOptionArguments: [Args] = []

        public init(headless: Bool, maximize: Bool, options: ChromeOptions) {
            self.headless = headless
            self.maximize = maximize
            self.options = options
        }

        public mutating func createChromeOptions()
            -> ChromeOptions
        {
            if headless {
                addArgument(Args(.headless))
            }
            if maximize {
                addArgument(Args(.startMaximized))
            }

            if let additionalArguments = options.args {
                addArguments(additionalArguments)
            }

            removeAllDuplicateArguments()

            return .init(args: chromeOptionArguments)
        }

        private mutating func addArgument(_ arg: Args) {
            chromeOptionArguments.append(arg)
        }

        private mutating func addArguments(_ args: [Args]) {
            chromeOptionArguments.insert(contentsOf: args, at: 1)
        }

        private mutating func removeAllDuplicateArguments() {
            chromeOptionArguments = Array(Set(chromeOptionArguments))
        }
    }
}

extension URL {
    public static func from(string urlString: String) throws -> URL {
        guard
            let url = URL(string: urlString)
        else {
            throw HeliumError.invalidURL(url: urlString)
        }
        return url
    }
}
