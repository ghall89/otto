struct DefaultsOptions {
	var type: CommandType
	var domain: String
	var preference: String?
	var value: String?
	var valueType: ValueType?

	var options: String {
		get throws {
			switch type {
				case .read:
					guard let preference, let valueType else {
						throw OttoError.invalidInput
					}

					return "read \(domain) \(preference) \(valueType)"
				case .write:
					guard let preference,
					      let valueType,
					      let value
					else {
						throw OttoError.invalidInput
					}

					return "write \(domain) \(preference) \(valueType) \(value)"
				case .delete:
					guard let preference else {
						throw OttoError.invalidInput
					}

					return "delete \(domain) \(preference)"
			}
		}
	}
}

enum CommandType: String {
	case read
	case write
	case delete
}
