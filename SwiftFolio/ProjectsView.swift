//
// Created by Smital on 05/06/21.
//

import SwiftUI

struct ProjectsView: View {
    @Environment(\.managedObjectContext) var moc
    static let openTag: String? = "Open"
    static let closedTag: String? = "Closed"
    let showClosedProjects: Bool
    let projects: FetchRequest<Project>

    init(showClosedProjects: Bool) {
        self.showClosedProjects = showClosedProjects
        projects = FetchRequest<Project>(entity: Project.entity(), sortDescriptors: [
            NSSortDescriptor(keyPath: \Project.creationDate, ascending: false)
        ], predicate: NSPredicate(format: "closed = %d", showClosedProjects))
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(projects.wrappedValue, id: \.self) { project in
                    Section(header: Text(project.projectTitle)) {
                        ForEach(project.projectItems, id:\.self) { item in
                            ItemRowView(item: item)
                        }
                    }
                }
            }.navigationBarTitle(showClosedProjects ? "Closed Projects" : "Open Projects")
        }
    }
}

struct ItemRowView: View {
    @ObservedObject var item: Item

    var body: some View {
        NavigationLink(destination: EditItemView(item: item)) {
            Text(item.itemTitle)
        }
    }
}