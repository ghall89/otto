import ArgumentParser
import Foundation
import Rainbow

extension Otto {
	struct List: ParsableCommand {
		static let configuration = CommandConfiguration(
			abstract: "List all available preferences.",
		)

		@Argument(help: "Preference domain")
		var domain: String?

		mutating func run() {
			list(domain: domain)
		}

		private func list(domain: String?) {
			if domain != nil {
				if let domain = Otto.preferenceList.first(where: { $0.name == domain }) {
					var message = ""

					for pref in domain.preferences {
						message.append(
							formatPreferenceInfo(pref),
						)
					}

					logger.info(message)
				} else {
					logger.info("No preferences found...")
				}
			} else {
				var message = ""

				for (domainIndex, domain) in Otto.preferenceList.enumerated() {
					message.append("\(domain.name.bold)\n")

					for (prefIndex, pref) in domain.preferences.enumerated() {
						message.append(
							formatPreferenceInfo(pref),
						)

						if prefIndex == (domain.preferences.count - 1),
						   domainIndex != (Otto.preferenceList.count - 1)
						{
							message.append("\n")
						}
					}
				}

				logger.info(message)
			}
		}

		private func formatPreferenceInfo(_ pref: Preference) -> String {
			"- \(pref.name.underline) <\(pref.type)> - \(pref.desc)\n"
		}
	}
}
