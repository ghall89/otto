func readCmd(domain: String?, key: String?) throws {
    let shell = Shell()

    do {
        let prefs = try getPreferenceList()

        let (domainId, preferenceKey) = try getPreferenceValues(
            prefs: prefs, domain: domain, key: key)

        let cmd = "read \(domainId) \(preferenceKey)"

        let out = shell.run(cmd)
        print(out)
    } catch {
        throw error
    }
}
