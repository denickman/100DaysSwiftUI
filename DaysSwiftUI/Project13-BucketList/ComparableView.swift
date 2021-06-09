//
//  ComparableView.swift
//  DaysSwiftUI
//
//  Created by Denis Yaremenko on 6/8/21.
//

import SwiftUI

struct ComparableUser: Identifiable, Comparable {
    let id = UUID()
    let firstName: String
    let lastName: String
    
    static func < (lhs: ComparableUser, rhs: ComparableUser) -> Bool {
        lhs.lastName < rhs.lastName
    }
}

struct ComparableView: View {
    
    var loadingState = LoadingState.loading
    
    let users = [
        ComparableUser(firstName: "Petro", lastName: "Sagaydach"),
        ComparableUser(firstName: "Kristine", lastName: "Orbakayte"),
        ComparableUser(firstName: "Valentino", lastName: "Velasqest"),
    ].sorted()
    
    var body: some View {
        //        List(values, id: \.self) {
        //            Text(String($0))
        //        }
        
        Group {
            switch loadingState {
            // Using this approach our ContentView doesn’t spiral out of control as more and more code gets added to the views, and in fact has no idea what loading, success, or failure even look like.
            case .loading: LoadingView()
            case .success: SuccessView()
            case .failed: FailedView()
            }
            
            Text("Hello World")
                .onTapGesture {
                    let str = "Test Message"
                    let url = self.getDocumentsDirectory().appendingPathComponent("message.txt")
                    
                    do {
                        try str.write(to: url, atomically: true, encoding: .utf8)
                        let input = try String(contentsOf: url)
                        print(input)
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            
            List(users) { user in
                Text("\(user.lastName) \(user.firstName)")
            }
            
        }
    }
    
    private func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        // just send back the first one, which ought to be the only one
        return paths[0]
    }
}

struct ComparableView_Previews: PreviewProvider {
    static var previews: some View {
        ComparableView()
    }
}
