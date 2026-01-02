import Foundation

struct Shell {
	private let zsh = "/bin/zsh"

	/// run the 'defaults' CLI tool
	func defaults(_ opts: String) -> String {
		run("/usr/bin/defaults \(opts)")
	}

	/// run the 'osascript' CLI tool
	func osascript(_ script: String) {
		_ = run("osascript -e '\(script)'")
	}

	private func run(_ cmd: String) -> String {
		let task = Process()
		let pipe = Pipe()

		task.standardOutput = pipe
		task.standardError = pipe
		task.arguments = ["-c", cmd]
		task.launchPath = zsh
		task.standardInput = nil
		task.launch()
		task.waitUntilExit()

		guard task.terminationStatus == 0 else {
			throw ShellError.commandFailed(cmd, task.terminationStatus)
		}

		let data = pipe.fileHandleForReading.readDataToEndOfFile()

		return String(data: data, encoding: .utf8)!
	}
}
