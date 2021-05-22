//
//  ArchiveObjectView.swift
//  DaysSwiftUI
//
//  Created by Denis Yaremenko on 5/21/21.
//

import SwiftUI

struct ArchUser: Codable {
    var firstName: String
    var lastName: String
}

struct ArchiveObjectView: View {
    
    @State private var user = ArchUser(firstName: "Den", lastName: "Remen")
    
    var body: some View {
        Button("Save User") {
            let encoder = JSONEncoder()
            
            if let data = try? encoder.encode(self.user) {
                UserDefaults.standard.setValue(data, forKey: "User")
            }
        }
    }
}

struct ArchiveObjectView_Previews: PreviewProvider {
    static var previews: some View {
        ArchiveObjectView()
    }
}
