//
//  UDView.swift
//  DaysSwiftUI
//
//  Created by Denis Yaremenko on 5/21/21.
//

import SwiftUI

struct UDView: View {
    @State private var tapCount =
        UserDefaults.standard.integer(forKey: "Tap")
    
    var body: some View {
        Button("Tap Count") {
            self.tapCount += 1
            UserDefaults.standard.setValue(self.tapCount, forKey: "Tap")
        }
    }
}

struct UDView_Previews: PreviewProvider {
    static var previews: some View {
        UDView()
    }
}
