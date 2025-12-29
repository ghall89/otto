func readPreferenceValue(domain: String, key: String) throws -> String {
	let shell = Shell()

	do {
		let (domainID, preferenceKey, valueType, _) = try fetchPreferenceMetadata(
			domain: domain,
			key: key,
		)

		let cmd = "read \(domainID) \(preferenceKey) \(valueType)"

		let out = shell.defaults(cmd).trimmingCharacters(in: .whitespacesAndNewlines)

		switch valueType {
			case .bool:
				if let num = Int(out) {
					return num == 0 ? "false" : "true"
				} else {
					return out
				}
			default:
				return out
		}
	} catch {
		throw OttoError.runtimeError(error.localizedDescription)
	}
}
