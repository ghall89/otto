func setCmd(domain: String?, key: String?, value: String?) throws {
    let shell = Shell()
    let prefs = try getPreferenceList()

    let (domainId, preferenceKey, valueType, resetWhenApplied) = try getPreferenceValues(
        prefs: prefs, domain: domain, key: key)

    let cmd = "write \(domainId) \"\(preferenceKey)\" \(valueType.rawValue) \"\(value!)\""

    let out = shell.defaults(cmd)

    print(out)

    if resetWhenApplied == true {
        restartDomain(domainId)
    }
}
