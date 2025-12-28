import Foundation

import struct ArgumentParser.Argument
import struct ArgumentParser.CommandConfiguration
import protocol ArgumentParser.ParsableCommand

extension Otto {
    struct Export: ParsableCommand {
        static let configuration = CommandConfiguration(
            abstract: "Export current preferences to a text file."
        )

        @Argument(help: "Export path.")
        var path: String?

        mutating func run() throws {
            var exportContents = ""

            preferenceList.forEach { domain in
                let preferences = domain.preferences

                preferences.forEach { preference in
                    let value = try! readPreferenceValue(domain: domain.name, key: preference.name)

                    if !value.contains("does not exist") {
                        exportContents.append("\(domain.name) \(preference.name) \(value)\n")
                    }
                }
            }

            try stringToTextFile(exportContents, filename: "preferences", out: path)

            logger.success("Settings exported to \(path ?? "current directory").")
        }
    }
}
