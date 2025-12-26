import ArgumentParser
import Foundation
import Rainbow

extension Otto {
    struct Reset: ParsableCommand {
        static let configuration = CommandConfiguration(
            abstract: "Reset preference to default"
        )

        @Argument(help: "Preference domain")
        var domain: String

        @Argument(help: "Preference key")
        var key: String

        mutating func run() throws {
            try reset(domain: domain, key: key)
        }

        private func reset(domain: String, key: String) throws {
            let shell = Shell()

            do {
                let prefs = try getPreferenceList()
                let (domainId, preferenceKey, _, resetWhenApplied) =
                    try getPreferenceValues(prefs: prefs, domain: domain, key: key)

                let cmd = "delete \(domainId) \(preferenceKey)"

                let _ = shell.defaults(cmd)

                logger.success("\(domain.bold.underline) \(key.bold.underline) reset to default")

                if resetWhenApplied {
                    restartDomain(domainId)
                }
            }
        }
    }
}
