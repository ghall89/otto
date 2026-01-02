import ArgumentParser

@main
struct Otto: AsyncParsableCommand {
	static let logger = Logger()
	static let preferenceList: [Domain] = getPreferenceList()

	static let configuration = CommandConfiguration(
		commandName: "otto",
		abstract: "A utility for managing hidden macOS preferences.",
		subcommands: [
			List.self,
			Get.self,
			Set.self,
			Reset.self,
			Export.self,
			Config.self,
		],
	)
}
