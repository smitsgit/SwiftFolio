//
// Created by Smital on 07/06/21.
//

import SwiftUI


struct ProjectHeaderView: View {
    @ObservedObject var project: Project
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
               Text(project.projectTitle)
               ProgressView(value: project.completionAmount)
                       .accentColor(Color(project.projectColor))
            }.padding(.bottom, 10)

            Spacer()

            NavigationLink(destination: EditProjectView(project: project)) {
                Image(systemName: "square.and.pencil").imageScale(.large)
            }
        }

    }
}
