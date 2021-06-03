//
//  URLView2.swift
//  DaysSwiftUI
//
//  Created by Denis Yaremenko on 6/3/21.
//

import SwiftUI

struct URLView2: View {
    
    @State var username = ""
    @State var email = ""
    
    var disabledForm: Bool {
        username.count < 5 || email.count < 5
    }
    
    var body: some View {
        Form {
            Section {
                TextField("Username", text: $username)
                TextField("Email", text: $email)
            }
            
            Section {
                Button("Create account") {
                    print("Creating account...")
                }
            }
            
            .disabled(disabledForm)
        }
    }
}

struct URLView2_Previews: PreviewProvider {
    static var previews: some View {
        URLView2()
    }
}
