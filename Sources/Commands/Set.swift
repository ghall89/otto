import ArgumentParser
import Foundation
import Rainbow

extension Otto {
    struct Set: ParsableCommand {
        static let configuration = CommandConfiguration(
            abstract: "Set a new value for a preference."
        )

        @Argument(help: "Preference domain")
        var domain: String

        @Argument(help: "Preference key")
        var key: String

        @Argument(help: "Preference value")
        var value: String

        mutating func run() throws {
            try applyPreference(domain: domain, key: key, value: value)
        }

    }
}
