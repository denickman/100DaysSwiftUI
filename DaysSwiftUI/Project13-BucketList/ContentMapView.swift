//
//  ContentMapView.swift
//  DaysSwiftUI
//
//  Created by Denis Yaremenko on 6/8/21.
//

import SwiftUI
import LocalAuthentication
import MapKit

struct ContentMapView: View {
    
    //    @State private var isUnlocked = false
    
    @State private var centerCoordinate = CLLocationCoordinate2D()
    @State private var locations = [MKPointAnnotation]()
    
    @State private var selectedPlace: MKPointAnnotation?
    @State private var showingPlaceDetails = false
    @State private var showingEditScreen = false

    var body: some View {
        ZStack {
            MapView(centerCoordinate: $centerCoordinate,
                    selectedPlace: $selectedPlace,
                    showingPlaceDetails: $showingPlaceDetails,
                    annotations: locations)
                .edgesIgnoringSafeArea(.all)
            Circle()
                .fill(Color.blue)
                .opacity(0.3)
                .frame(width: 32, height: 32)
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        // create a new location
                        let newLocation = MKPointAnnotation()
                        newLocation.title = "Example Location"
                        
                        newLocation.coordinate = self.centerCoordinate
                        self.locations.append(newLocation)
                        // поскольку здесь свойство меняется тоже оно тригерит перерисовку body
                        
                        self.selectedPlace = newLocation
                        self.showingPlaceDetails.toggle()
                    }) {
                        Image(systemName: "plus")
                    }
                    .padding()
                    .background(Color.black.opacity(0.75))
                    .foregroundColor(.white)
                    .font(.title)
                    .clipShape(Circle())
                    .padding(.trailing)
                }
            }
        }
        
        .alert(isPresented: $showingPlaceDetails) {
            Alert(title: Text(selectedPlace?.title ?? "Example location"),
                  message: Text(selectedPlace?.subtitle ?? "Missing place information"),
                  primaryButton: .default(Text("Ok")),
                  secondaryButton: .default(Text("Edit")) {
                    // edit this place
                    self.showingEditScreen.toggle()
                  })
        }
        .sheet(isPresented: $showingEditScreen) {
            if self.selectedPlace != nil {
                EditView(placemark: self.selectedPlace!)
            }
        }
    }
}

struct ContentMapView_Previews: PreviewProvider {
    static var previews: some View {
        ContentMapView()
    }
}

/*
 
 private func authenticate() {
 let context = LAContext()
 var error: NSError?
 
 // check whether biometric authentication is possible
 if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
 // it's possible, so go ahead and use it
 let reason = "We need to unlock your data."
 
 context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
 // authentication has now completed
 DispatchQueue.main.async {
 if success {
 // authenticated successfully
 } else {
 // there was a problem
 }
 }
 }
 } else {
 // no biometrics
 }
 }
 
 //        VStack {
 //            if self.isUnlocked {
 //                Text("Unlocked")
 //            } else {
 //                Text("Locked")
 //            }
 //        }
 //        .onAppear(perform: authenticate)
 
 */
