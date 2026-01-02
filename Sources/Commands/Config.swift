import ArgumentParser

extension Otto {
	struct Config: AsyncParsableCommand {
		static let configuration = CommandConfiguration(
			abstract: "Launch a GUI to configure available preferences.",
		)

		mutating func run() async {
			logger.info("Launching GUI...\nWORK IN PROGRESS!!")

			await App().run()
		}
	}
}
