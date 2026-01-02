import SwiftUI

struct ConfigView: View {
	private let domains = getPreferenceList()

	@State
	private var newDomainSheet = false

	var body: some View {
		NavigationStack {
			List {
				ForEach(domains, id: \.domain) { domain in
					NavigationLink(destination: {
						DomainView(domain: domain)
					}) {
						HStack {
							Text(domain.name)
							Spacer()
							Text(domain.domain)
								.font(.caption)
						}
					}
				}
				.listStyle(.inset)
			}
			.toolbar(removing: .title)
			.toolbar {
				ToolbarItem(placement: .automatic) {
					Spacer()
				}
				ToolbarItem(placement: .automatic) {
					Button("Add", systemImage: "plus") {
						newDomainSheet.toggle()
					}
				}
			}
		}
		.frame(minWidth: 400, minHeight: 500)
		.sheet(isPresented: $newDomainSheet) {
			NewDomainView()
		}
	}
}
