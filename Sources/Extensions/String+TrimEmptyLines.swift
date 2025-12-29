extension String {
	func trimmingEmptyLines() -> String {
		components(separatedBy: .newlines)
			.filter { !$0.trimmingCharacters(in: .whitespaces).isEmpty }
			.joined(separator: "\n")
	}
}
