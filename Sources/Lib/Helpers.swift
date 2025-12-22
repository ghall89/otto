import Foundation
import Rainbow

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
        print("Missing required values.".red)
        exit(EXIT_FAILURE)
    }

    if let domainObject = prefs.first(where: { $0.name == domain }) {
        domainId = domainObject.domain
        resetWhenApplied = domainObject.reset_when_applied ?? false

        if let preferenceObject = domainObject.preferences.first(where: { $0.name == key }) {
            preferenceKey = preferenceObject.key
            valueType = preferenceObject.type
        } else {
            print(
                "Preference key \(key!.bold.underline) not found in domain \(domain!.bold.underline)."
                    .red
            )

            exit(EXIT_FAILURE)
        }

    } else {
        print("Domain \(domain!.bold.underline) not found.".red)
        exit(EXIT_FAILURE)
    }

    return (domainId, preferenceKey, valueType, resetWhenApplied)
}

func restartDomain(_ domain: String) {
    let shell = Shell()

    let closeCmd = "osascript -e 'quit app id \"\(domain)\"'"
    let _ = shell.run(closeCmd)
}
