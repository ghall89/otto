func fetchPreferenceMetadata(

    domain: String,
    key: String
) throws -> (String, String, ValueType, Bool) {
    let domainObject = try findDomain(domain, in: Otto.preferenceList)
    let preferenceObject = try findPreference(key, in: domainObject)

    return (
        domainObject.domain,
        preferenceObject.key,
        preferenceObject.type,
        domainObject.reset_when_applied ?? false
    )
}

func findDomain(_ name: String, in prefs: [Domain]) throws -> Domain {
    guard let domain = prefs.first(where: { $0.name == name }) else {
        throw OttoError.runtimeError("Domain \(name.bold.underline) not found.")
    }

    return domain
}

func findPreference(_ key: String, in domain: Domain) throws -> Preference {
    guard let pref = domain.preferences.first(where: { $0.name == key }) else {
        throw OttoError.runtimeError("Preference key \(key) not found in \(domain.name).")
    }

    return pref
}
