func applyPreference(domain: String, key: String, value: String) throws {
	let shell = Shell()

	let (domainID, preferenceKey, valueType, resetWhenApplied) =
		try fetchPreferenceMetadata(domain: domain, key: key)

	let checkedValue = try verifyValue(value, valueType: valueType)

	let cmd = DefaultsOptions(
		type: .write,
		domain: domainID,
		preference: preferenceKey,
		value: checkedValue,
		valueType: valueType,
	)

	_ = shell.defaults(try cmd.options)

	print(
		"\(domain.bold.underline) \(key.bold.underline) set to \(value.bold.underline)"
			.green)

	if resetWhenApplied == true {
		print("You will need to log out and back in for your changes to take effect.")
	}
}

private func verifyValue(_ value: String, valueType: ValueType) throws -> String {
	let BOOL_VALUES = ["yes", "no", "true", "false"]

	switch valueType {
		case .bool:
			if !BOOL_VALUES.contains(value) {
				throw OttoError.invalidValue("bool")
			}
		case .int:
			if Int(value) == nil {
				throw OttoError.invalidValue("integer")
			}
		case .float:
			if Float(value) == nil {
				throw OttoError.invalidValue("float")
			}
		case .string:
			return "\"\(value)\""
		default:
			throw OttoError.invalidInput
	}

	return value
}
