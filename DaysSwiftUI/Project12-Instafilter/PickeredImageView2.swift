//
//  PickeredImageView2.swift
//  DaysSwiftUI
//
//  Created by Denis Yaremenko on 6/7/21.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct PickeredImageView2: View {
    
    /*
     it has support for only a small amount of logic inside SwiftUI layouts – we can use if someCondition, but we can’t use if let, for, while, switch, and so on.
     */
    
    @State private var image: Image?
    @State private var inputImage: UIImage?
    @State private var processedImage: UIImage?
    
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    @State private var filterIntensity = 0.5
    
    @State private var showingImagePicker = false
    @State private var showingFilterSheet = false

    let context = CIContext()
    
    var body: some View {
        
        /*
         Custom bindings that rely on filterIntensity of our view need to be created inside the body property of the view, because Swift doesn’t allow one property to reference another
         */
        
        let intensity = Binding<Double>(
            get: {
                self.filterIntensity
            },
            
            set: {
                self.filterIntensity = $0
                self.applyProcessing()
            }
        )
  
        return NavigationView {
            // Now that there is some logic inside the body property (added intensity binding), you must place return before the NavigationView
            VStack {
                ZStack {
                    Rectangle()
                        .fill(Color.secondary)
                    // display the image
                    if image != nil {
                        image?
                            .resizable()
                            .scaledToFit()
                    } else {
                        Text("Tap to select a picture")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                }
                .onTapGesture {
                    // select the image
                    showingImagePicker.toggle()
                }
                
                HStack {
                    Text("Intensity")
//                    Slider(value: self.$filterIntensity) // before
                    Slider(value: intensity) // after we do not use $ because it is already binding
                }
                .padding(.vertical)
                
                HStack {
                    Button("Change filter") {
                        // change filter
                        showingFilterSheet.toggle()
                    }
                    
                    Spacer()
                    
                    Button("Save") {
                        guard let processedImage = self.processedImage else { return }
                        let imageSaver = ImageSaver()

                        imageSaver.successHandler = {
                            print("Success!")
                        }

                        imageSaver.errorHandler = {
                            print("Oops: \($0.localizedDescription)")
                        }

                        imageSaver.writeToPhotoAlbum(image: processedImage) 
                    }
                }
            }
            .padding([.horizontal, .bottom])
            .navigationBarTitle("Instafilter")
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                ImagePicker(image: self.$inputImage)
            }
            .actionSheet(isPresented: $showingFilterSheet, content: {
                
                ActionSheet(title: Text("Select a filter"), buttons: [
                    .default(Text("Crystallize")) { self.setFilter(CIFilter.crystallize()) },
                    .default(Text("Edges")) { self.setFilter(CIFilter.edges()) },
                    .default(Text("Gaussian Blur")) { self.setFilter(CIFilter.gaussianBlur()) },
                    .default(Text("Pixellate")) { self.setFilter(CIFilter.pixellate()) },
                    .default(Text("Sepia Tone")) { self.setFilter(CIFilter.sepiaTone()) },
                    .default(Text("Unsharp Mask")) { self.setFilter(CIFilter.unsharpMask()) },
                    .default(Text("Vignette")) { self.setFilter(CIFilter.vignette()) },
                    .cancel()
                ])
            })
        }
    }
    
    //MARK: - Private
    private func loadImage() {
        guard let inputImage = inputImage else { return }

           let beginImage = CIImage(image: inputImage)
           currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
           applyProcessing()
    }
    
    private func applyProcessing() {
//        currentFilter.intensity = Float(filterIntensity) // does not work since we upgrade to protocol value
        
//        currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
        
        let inputKeys = currentFilter.inputKeys
        if inputKeys.contains(kCIInputIntensityKey) { currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey) }
        if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(filterIntensity * 200, forKey: kCIInputRadiusKey) }
        if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(filterIntensity * 10, forKey: kCIInputScaleKey) }
        
        guard let outputImage = currentFilter.outputImage else { return }
        
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
            processedImage = uiImage
        }
    }
    
    private func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
    }
    
}

struct PickeredImageView2_Previews: PreviewProvider {
    static var previews: some View {
        PickeredImageView2()
    }
}
