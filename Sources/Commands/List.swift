import Foundation
import Rainbow

func listCmd(domain: String?) throws {
    let prefs = try getPreferenceList()

    if domain != nil {
        if let domain = prefs.first(where: { $0.name == domain }) {
            domain.preferences.forEach { pref in
                print("\(pref.name.underline) <\(pref.type)> - \(pref.desc)".blue)
            }
        } else {
            print("No preferences found...")
        }
    } else {
        prefs.forEach { domain in
            print(domain.name.bold.green)

            domain.preferences.forEach { pref in
                print("  \(pref.name.underline) <\(pref.type)> - \(pref.desc)".blue)
            }
        }
    }

    exit(EXIT_SUCCESS)
}
