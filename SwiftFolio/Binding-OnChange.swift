//
// Created by Smital on 06/06/21.
//

import SwiftUI

extension Binding {
    func onChange(_ handler: @escaping () -> Void) -> Binding<Value> {
        Binding(
                get: { self.wrappedValue },
                set: { newValue in
                    self.wrappedValue = newValue
                    handler()
                }
        )
    }
}
