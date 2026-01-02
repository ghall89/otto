import ArgumentParser
import Foundation
import Rainbow

extension Otto {
	struct Reset: ParsableCommand {
		static let configuration = CommandConfiguration(
			abstract: "Reset preference to default",
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
				let (domainID, preferenceKey, _, resetWhenApplied) =
					try fetchPreferenceMetadata(domain: domain, key: key)

				let cmd = DefaultsOptions(type: .delete, domain: domainID, preference: preferenceKey)

				_ = shell.defaults(try cmd.options)

				logger.success("\(domain.bold.underline) \(key.bold.underline) reset to default")

				if resetWhenApplied {
					restartDomain(domainID)
				}
			}
		}
	}
}
