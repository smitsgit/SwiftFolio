//
//  ContentView.swift
//  SwiftFolio
//
//  Created by Smital on 05/06/21.
//
//

import SwiftUI
import CoreData

struct ContentView: View {
    @SceneStorage("selectedView") var selectedView: String?
    var body: some View {
        TabView(selection: $selectedView) {
            AddView().tabItem {
                Text("Add")
            }.tag(AddView.tag)
            ProjectsView(showClosedProjects: false)
                    .tag(ProjectsView.openTag)
                    .tabItem {
                        Image(systemName: "list.bullet")
                        Text("Open")
                    }


            ProjectsView(showClosedProjects: true)
                    .tag(ProjectsView.closedTag)
                    .tabItem {
                        Image(systemName: "checkmark")
                        Text("Closed")
                    }
        }
    }
}

struct AddView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Project.entity(), sortDescriptors: []) var projects: FetchedResults<Project>
    static let tag: String? = "Home"
    var body: some View {
        NavigationView {
            VStack {
                Button("Tap me") {
                    for i in 1...5 {
                        let project = Project(context: self.moc)
                        project.title = "Project \(i)"
                        project.items = []
                        project.creationDate = Date()
                        project.closed = Bool.random()

                        for j in 1...10 {
                            let item = Item(context: self.moc)
                            item.title = "Item \(j)"
                            item.creationDate = Date()
                            item.completed = Bool.random()
                            item.project = project
                            item.priority = Int16.random(in: 1...3)
                        }
                    }
                    try? self.moc.save()
                }

                Button("Delete me") {
                    for project in self.projects {
                        self.moc.delete(project)
                    }

                    try? self.moc.save()
                }
            }.navigationBarTitle("Add me")

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
