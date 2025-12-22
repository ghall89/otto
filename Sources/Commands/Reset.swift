import Foundation
import Rainbow

func resetCmd(domain: String, key: String) throws {
    let shell = Shell()

    do {
        let prefs = try getPreferenceList()
        let (domainId, preferenceKey, _, resetWhenApplied) =
            try getPreferenceValues(prefs: prefs, domain: domain, key: key)

        let cmd = "delete \(domainId) \(preferenceKey)"

        let _ = shell.defaults(cmd)

        print("\(domain.bold.underline) \(key.bold.underline) reset to default".green)

        if resetWhenApplied {
            restartDomain(domainId)
        }

    } catch {
        print(error)
        exit(EXIT_FAILURE)
    }

    exit(EXIT_SUCCESS)
}
