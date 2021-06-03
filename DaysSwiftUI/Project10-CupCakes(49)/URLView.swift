//
//  CupcakeCornerView.swift
//  DaysSwiftUI
//
//  Created by Denis Yaremenko on 5/27/21.
//

import SwiftUI

class CodableUser: ObservableObject, Codable {
    @Published var name = "Dennis Yaremenko"

    enum Keys: CodingKey {
        case name
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        name = try container.decode(String.self, forKey: .name)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try container.encode(name, forKey: .name)
    }
}

struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}

struct URLView: View {
    
    @State var results = [Result]()

    var body: some View {
        List(results, id: \.trackId) { item in
            VStack(alignment: .leading) {
                Text(item.trackName)
                    .font(.headline)
                
                Text(item.collectionName)
            }
        }
        .onAppear(perform: loadData)
    }
    
    func loadData() {
        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
            print("invalid URL")
            return
        }
        
        let request = URLRequest(url: url)
 
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data,
               let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                DispatchQueue.main.async {
                    self.results = decodedResponse.results
                }
                return
            }
            
            print("Error \(error?.localizedDescription ?? "unknown error")")
            
        }.resume()
    }
}

struct CupcakeCornerView_Previews: PreviewProvider {
    static var previews: some View {
        URLView()
    }
}
