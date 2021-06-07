//
//  ImagePicker.swift
//  DaysSwiftUI
//
//  Created by Denis Yaremenko on 6/6/21.
//

import UIKit
import SwiftUI

/*
 What we’ve done so far is create an ImagePicker struct that knows how to create a UIImagePickerController, and now we just told ImagePicker that it should have a coordinator to handle communication from that UIImagePickerController
 */

struct ImagePicker: UIViewControllerRepresentable { // ImagePicker struct is a valid SwiftUI view, so this is SwiftUI View type
    
    @Binding var image: UIImage? // it can send changes back to a parent view.
    @Environment(\.presentationMode) var presentationMode

    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        /*
         Even though that class is inside a UIViewControllerRepresentable struct, SwiftUI won’t automatically use it for the view’s coordinator. Instead, we need to add a new method called makeCoordinator(), which SwiftUI will automatically call if we implement it. All this needs to do is create and configure an instance of our Coordinator class, then send it back.
         
         NSObject allows Objective-C to ask the object what functionality it supports at runtime, which means the image picker can say things like “hey, the user selected an image, what do you want to do?
         */
        
        var parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }

            parent.presentationMode.wrappedValue.dismiss()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        /* We don’t call makeCoordinator() ourselves; SwiftUI calls it automatically when an instance of ImagePicker is created
         SwiftUI automatically associated the coordinator it created with our ImagePicker struct, which means when it calls makeUIViewController() and updateUIViewController() it will automatically pass that coordinator object to us.
         */
        Coordinator(self) // it passes the ImagePicker struct into the coordinator, like this:
    }
    
    //  those methods are actually enough for Swift to figure out the view controller type so you can delete the typealias line
    //     typealias UIViewControllerType = UIImagePickerController
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        //  responsible for creating the initial view controller
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        // picker.delegate - This means any time something happens inside the image picker controller – i.e., when the user selects an image – it will report that action to our coordinator.
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        // is designed to let us update the view controller when some SwiftUI state changes.
        
    }
}
