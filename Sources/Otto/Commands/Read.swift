func readCmd(domain: String?, key: String?) throws {
    let shell = Shell()

    do {
        let prefs = try getPreferenceList()

        let (domainId, preferenceKey, valueType, _) = try getPreferenceValues(
            prefs: prefs, domain: domain, key: key)

        let cmd = "read \(domainId) \(preferenceKey)"

        let out = shell.defaults(cmd)

        switch valueType {
        case .bool:
            if out.contains("0") {
                print("false")
            } else if out.contains("1") {
                print("true")
            } else {
                print(out)
            }
        default:
            print(out)
        }

    } catch {
        throw error
    }
}
