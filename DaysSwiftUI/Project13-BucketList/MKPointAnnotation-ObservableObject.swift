//
//  MKPointAnnotation-ObservableObject.swift
//  DaysSwiftUI
//
//  Created by Denis Yaremenko on 6/9/21.
//

import MapKit

extension MKPointAnnotation: ObservableObject {
    //  I haven’t marked those computed properties as @Published? This is OK here because we won’t actually be reading the properties as they are being changed, so there’s no need to keep refreshing the view as the user types
    
    public var wrappedTitle: String {
        get {
            self.title ?? "Unknown title"
        }
        
        set {
            title = newValue
        }
    }
    
    public var wrappedSubtitle: String {
        get {
            self.subtitle ?? "Unknown value"
        }
        
        set {
            subtitle = newValue
        }
    }
}
