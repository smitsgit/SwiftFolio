//
// Created by Smital on 05/06/21.
//

import Foundation

extension Item {
    var itemTitle: String {
        title ?? ""
    }

    var itemDetail: String {
        detail ?? ""
    }

    var itemCreationDate: Date {
        creationDate ?? Date()
    }

}