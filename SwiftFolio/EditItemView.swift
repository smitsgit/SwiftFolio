//
// Created by Smital on 05/06/21.
//

import SwiftUI


struct EditItemView: View {
    let item: Item
    @Environment(\.managedObjectContext) var moc

    @State private var title: String
    @State private var detail: String
    @State private var priority: Int
    @State private var completed: Bool

    init(item: Item) {
        self.item = item
        _title = State(wrappedValue: item.itemTitle)
        _detail = State(wrappedValue: item.itemDetail)
        _priority = State(wrappedValue: Int(item.priority))
        _completed = State(wrappedValue: item.completed)
    }

    var body: some View {

        Form {
            Section(header: Text("Basic settings")) {
                TextField("Item name", text: $title)
                TextField("Description", text: $detail)
            }

            Section(header: Text("Priority")) {
                Picker("Priority", selection: $priority) {
                    Text("Low").tag(1)
                    Text("Medium").tag(2)
                    Text("High").tag(3)
                }.pickerStyle(SegmentedPickerStyle())
            }

            Section {
                Toggle("Mark Completed", isOn: $completed)
            }
        }.navigationTitle("Edit Item").onDisappear(perform: update)

    }

    func update() {
        item.project?.objectWillChange.send()
        item.title = title
        item.detail = detail
        item.priority = Int16(priority)
        item.completed = completed
    }
}

