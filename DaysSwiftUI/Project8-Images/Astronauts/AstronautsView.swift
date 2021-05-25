//
//  AstronautsView.swift
//  DaysSwiftUI
//
//  Created by Denis Yaremenko on 5/24/21.
//

import SwiftUI

struct AstronautsView: View {
    
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    var body: some View {

        NavigationView {
            List(missions) { mission in
                NavigationLink(destination:
                                MissionView(mission: mission,
                                            astronauts: self.astronauts)) {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()// the same as aspectRatio(contentMode: .fit)
                        .frame(width: 44, height: 44)

                    VStack(alignment: .leading) {
                        Text(mission.displayName)
                            .font(.headline)

                        Text(mission.formattedLaunchDate)
                    }
                }
            }
            .navigationBarTitle("Moonshot")
        }
    }
}

struct AstronautsView_Previews: PreviewProvider {
    static var previews: some View {
        AstronautsView()
    }
}
