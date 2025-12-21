import Foundation

func getPreferenceList() throws -> [Domain] {
    var preferenceList: [Domain] = []

    let url = Bundle
        .module
        .url(
            forResource: "SettingsList",
            withExtension: "json"
        )!

    let contents = try Data(contentsOf: url)

    preferenceList = try JSONDecoder().decode([Domain].self, from: contents)

    return preferenceList
}

func getPreferenceValues(
    prefs: [Domain],
    domain: String?,
    key: String?
) throws -> (String, String, ValueType, Bool) {
    let domainId: String
    let preferenceKey: String
    let valueType: ValueType
    let resetWhenApplied: Bool

    if domain == nil || key == nil {
        throw OttoError.runtimeError("Missing required values.")
    }

    if let domainObject = prefs.first(where: { $0.name == domain }) {
        domainId = domainObject.domain
        resetWhenApplied = domainObject.reset_when_applied ?? false

        if let preferenceObject = domainObject.preferences.first(where: { $0.name == key }) {
            preferenceKey = preferenceObject.key
            valueType = preferenceObject.type
        } else {
            throw OttoError.runtimeError(
                "Preference key '\(key!)' not found in domain '\(domain!)'.")
        }

    } else {
        throw OttoError.runtimeError("Domain \(domain!) not found.")
    }

    return (domainId, preferenceKey, valueType, resetWhenApplied)
}

func restartDomain(_ domain: String) {
    let shell = Shell()

    let closeCmd = "osascript -e 'quit app id \"\(domain)\"'"
    let _ = shell.run(closeCmd)
}
