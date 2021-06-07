//
//  ImagesView.swift
//  DaysSwiftUI
//
//  Created by Denis Yaremenko on 6/6/21.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct PickeredImageView: View {
 
    @State private var image: Image?
    @State private var inputImage: UIImage? // from image picker
    @State private var showingImagePicker = false
    
    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
            
            Button("Select Image") {
                self.showingImagePicker = true
            }
        }
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(image: self.$inputImage)
        }
    }
    
    private func loadImage() {
        //        image = Image("cupcakes")
        
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
        
        let beginImage = CIImage(image: inputImage)
        
        let context = CIContext()
        
        //        let currentFilter = CIFilter.pixellate()
        //        currentFilter.inputImage = beginImage
        //        currentFilter.scale = 10
        
        //        let currentFilter = CIFilter.sepiaTone()
        //        currentFilter.inputImage = beginImage
        //        currentFilter.intensity = 1
        
        //        let currentFilter = CIFilter.crystallize()
        //        currentFilter.inputImage = beginImage
        //        currentFilter.radius = 200
        
        //        let currentFilter = CIFilter.crystallize()
        //        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        //        currentFilter.radius = 200
        
        guard let currentFilter = CIFilter(name: "CITwirlDistortion") else { return }
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        currentFilter.setValue(2000, forKey: kCIInputRadiusKey)
        currentFilter.setValue(CIVector(x: inputImage.size.width / 2, y: inputImage.size.height / 2), forKey: kCIInputCenterKey)
        
        // get a CIImage from our filter or exit if that fails
        guard let outputImage = currentFilter.outputImage else { return }
        
        // attempt to get a CGImage from our CIImage
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            // convert that to a UIImage
            let uiImage = UIImage(cgImage: cgimg)
            
            // and convert that to a SwiftUI image
            image = Image(uiImage: uiImage)
        }
    }
}

struct Images2View_Previews: PreviewProvider {
    static var previews: some View {
        PickeredImageView()
    }
}
