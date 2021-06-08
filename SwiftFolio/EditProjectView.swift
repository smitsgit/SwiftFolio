//
// Created by Smital on 05/06/21.
//

import SwiftUI


struct EditProjectView: View {
    let project: Project
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @State private var showingDeleteConfirm = false

    @State private var title: String
    @State private var detail: String
    @State private var color: String

    let colorColumns = [GridItem(.adaptive(minimum: 44))]

    init(project: Project) {
        self.project = project
        _title = State(wrappedValue: project.projectTitle)
        _detail = State(wrappedValue: project.projectDetail)
        _color = State(wrappedValue: project.projectColor)
    }

    var body: some View {

        Form {
            Section(header: Text("Basic Settings")) {
                TextField("Project Name", text: $title.onChange(update))
                TextField("Description of this project", text: $detail.onChange(update))
            }

            Section(header: Text("Custom Project Color")) {
                LazyVGrid(columns: colorColumns) {
                    ForEach(Project.colors, id: \.self) { element in
                        ZStack {
                            Color(element)
                                    .aspectRatio(1, contentMode: .fit)
                                    .cornerRadius(6)

                            if element == color {
                                Image(systemName: "checkerboard.rectangle")
                                        .foregroundColor(Color.white)
                                        .font(.largeTitle)
                            }
                        }.onTapGesture {
                            color = element
                            update()
                        }
                    }
                }.padding(.vertical)
            }

            Section(footer: Text("Closing a project moves it from the Open to Closed tab; deleting it removes the project completely.")) {
                Button(project.closed ? "Reopen this project" : "Close this project") {
                    project.closed.toggle()
                    update()
                }

                Button("Delete this project") {
                    showingDeleteConfirm.toggle()
                }.accentColor(.red)
            }

        }.navigationTitle("Edit Project")
                .onDisappear {
                    try? moc.save()
                }
                .alert(isPresented: $showingDeleteConfirm) {
                    Alert(title: Text("Delete project?"), message: Text("Are you sure you want to delete this project? You will also delete all the items it contains."), primaryButton: .default(Text("Delete"), action: delete), secondaryButton: .cancel())
                }


    }

    func update() {
        // project.items?.objectWillChange.send()
        project.title = title
        project.detail = detail
        project.color = color
    }

    func delete() {
        moc.delete(project)
        presentationMode.wrappedValue.dismiss()
    }
}

