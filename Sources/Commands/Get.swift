import ArgumentParser
import Foundation
import Rainbow

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
            try get(domain: domain, key: key)
        }

        private func get(domain: String, key: String) throws {
            let shell = Shell()

            do {
                let (domainId, preferenceKey, valueType, _) = try fetchPreferenceMetadata(
                    domain: domain, key: key)

                let cmd = "read \(domainId) \(preferenceKey)"

                let out = shell.defaults(cmd)

                switch valueType {
                case .bool:
                    if out.contains("0") {
                        logger.info("false")
                    } else if out.contains("1") {
                        logger.info("true".bold.green)
                    } else {
                        logger.info(out)
                    }
                default:
                    logger.info(out.bold.blue)
                }

            } catch {
                throw OttoError.runtimeError(error.localizedDescription)
            }
        }
    }
}
