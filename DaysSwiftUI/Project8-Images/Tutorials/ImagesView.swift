//
//  ImagesView.swift
//  DaysSwiftUI
//
//  Created by Denis Yaremenko on 5/24/21.
//

import SwiftUI

struct ImagesView: View {
    
    var body: some View {
        NavigationView {
            VStack {
                
                NavigationLink(destination: Text("Detail View")) {
                    Text("Hello World Link Here")
                }
                .foregroundColor(.blue)
                .font(.largeTitle)
                
                List(0..<100) { row in
                    NavigationLink(destination: Text("Detail \(row)")) {
                        Text("Row \(row)")
                    }
                }
                
                List { // working as tableview cells - create views only for visible content
                    ForEach(0..<100) {
                        CustomText("Salupa \($0)")
                            .font(.title)
                    }
                }
                
                
                Button("Decode JSON") {
                    let input = """
                   {
                       "name": "Taylor Swift",
                       "address": {
                           "street": "555, Taylor Swift Avenue",
                           "city": "Nashville"
                       }
                   }
                   """
                    // more code to come
                    
                    struct InnerUser: Codable {
                        var name: String
                        var address: InnerAddress
                    }
                    
                    struct InnerAddress: Codable {
                        var street: String
                        var city: String
                    }
                    
                    let data = Data(input.utf8)
                    let decoder = JSONDecoder()
                    
                    if let user = try? decoder.decode(InnerUser.self, from: data) {
                        print(user.address.street)
                    }
                    
                }
                
                GeometryReader { geo in
                    Image("example")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geo.size.width)
                        .ignoresSafeArea()
                }
                
                ScrollView(.vertical) {
                    VStack(spacing: 10) {
                        ForEach(0..<100) {
                            Text("Item \($0)")
                                .font(.title)
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .navigationBarTitle("Swift UI")
            //            .background(Color.orange)
            //            .foregroundColor(.blue)
        }
        
        
        /*
         Image("example")
         //If you want the image contents to be resized too, we need to use the resizable() modifier like this
         .resizable()
         .aspectRatio(contentMode: .fill)
         .frame(width: 300, height: 300)
         .clipped()
         */
    }
}

struct ImagesView_Previews: PreviewProvider {
    static var previews: some View {
        ImagesView()
    }
}
