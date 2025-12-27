import ArgumentParser
import Foundation
import Rainbow

extension Otto {
    struct List: ParsableCommand {
        static let configuration = CommandConfiguration(
            abstract: "List all available preferences."
        )

        @Argument(help: "Preference domain")
        var domain: String?

        mutating func run() throws {
            try list(domain: domain)
        }

        private func list(domain: String?) throws {

            if domain != nil {
                if let domain = Otto.preferenceList.first(where: { $0.name == domain }) {
                    var message = ""

                    domain.preferences.forEach { pref in
                        message.append(
                            formatPreferenceInfo(pref)
                        )
                    }

                    logger.info(message)
                } else {
                    logger.info("No preferences found...")
                }
            } else {
                var message = ""

                Otto.preferenceList.enumerated().forEach { domainIndex, domain in
                    message.append("\(domain.name.bold)\n")

                    domain.preferences.enumerated().forEach { prefIndex, pref in
                        message.append(
                            formatPreferenceInfo(pref)
                        )

                        if prefIndex == (domain.preferences.count - 1)
                            && domainIndex != (Otto.preferenceList.count - 1)
                        {
                            message.append("\n")
                        }
                    }

                }

                logger.info(message)
            }
        }

        private func formatPreferenceInfo(_ pref: Preference) -> String {
            return "- \(pref.name.underline) <\(pref.type)> - \(pref.desc)\n"
        }
    }
}
