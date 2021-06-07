//
// Created by Smital on 05/06/21.
//

import Foundation

extension Project {
    var projectTitle: String {
        title ?? "New Project"
    }

    var projectDetail: String {
        detail ?? ""
    }

    var projectColor: String {
        color ?? ["Light Blue", "Midnight", "Pink"].randomElement()!
    }


    var projectItems: [Item] {
        let itemsArray = items?.allObjects as? [Item] ?? []
        return itemsArray.sorted { first, second in
            if first.completed == false {
                if second.completed == true {
                    return true
                }
            } else if first.completed == true {
                if second.completed == false {
                    return false
                }
            }

            if first.priority > second.priority {
                return true
            } else if first.priority < second.priority {
                return false
            }

            return first.itemCreationDate < second.itemCreationDate
        }
    }

    var completionAmount: Double {
        let originalItems = items?.allObjects as? [Item] ?? []
        guard originalItems.isEmpty == false else { return 0 }

        let completedItems = originalItems.filter(\.completed)
        return Double(completedItems.count) / Double(originalItems.count)
    }
}