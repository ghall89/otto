import Foundation
import Rainbow

import struct ArgumentParser.Argument
import struct ArgumentParser.CommandConfiguration
import protocol ArgumentParser.ParsableCommand

extension Otto {
    struct Get: ParsableCommand {
        static let configuration = CommandConfiguration(
            abstract: "Check the current value of a preference."
        )

        @Argument(help: "Preference domain")
        var domain: String

        @Argument(help: "Preference key")
        var key: String

        mutating func run() throws {
            let value = try readPreferenceValue(domain: domain, key: key)

            logger.info(value)
        }
    }
}
