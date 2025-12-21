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
) throws -> (String, String) {
    let domainId: String
    let preferenceKey: String

    if domain == nil || key == nil {
        throw OttoError.runtimeError("Missing required values.")
    }

    if let domainObject = prefs.first(where: { $0.name == domain }) {
        domainId = domainObject.domain

        if let preferenceObject = domainObject.preferences.first(where: { $0.name == key }) {
            preferenceKey = preferenceObject.key
        } else {
            throw OttoError.runtimeError(
                "Preference key '\(key!)' not found in domain '\(domain!)'.")
        }

    } else {
        throw OttoError.runtimeError("Domain \(domain!) not found.")
    }

    return (domainId, preferenceKey)
}
