import ArgumentParser

@main
struct Otto: ParsableCommand {
    static let logger = Logger()

    static let configuration = CommandConfiguration(
        commandName: "otto",
        abstract: "A utility for managing hidden macOS preferences.",
        subcommands: [
            List.self,
            Get.self,
            Set.self,
            Reset.self,
        ]
    )
}
