import SwiftUI

struct DomainView: View {
	var domain: Domain

	var body: some View {
		List {
			ForEach(domain.preferences, id: \.self) { pref in
				HStack {
					VStack(alignment: .leading) {
						Text(pref.name)
						Text(pref.desc)
							.font(.caption)
					}
					Spacer()
					Text(pref.type.rawValue)
				}
			}
		}
		.navigationTitle(domain.name)
		.toolbar {
			ToolbarItem(placement: .automatic) {
				Spacer()
			}
			ToolbarItem(placement: .automatic) {
				Button("Add", systemImage: "plus") {}
			}
		}
	}
}
