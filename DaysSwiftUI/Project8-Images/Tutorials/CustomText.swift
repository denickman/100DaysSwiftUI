//
//  CustomText.swift
//  DaysSwiftUI
//
//  Created by Denis Yaremenko on 5/24/21.
//

import SwiftUI

struct CustomText: View {
    
    var text: String
    
    init(_ text: String) {
        print("Creating a new CustomText")
        self.text = text
    }
    
    var body: some View {
        Text(text)
    }
}

struct CustomText_Previews: PreviewProvider {
    static var previews: some View {
        CustomText("Preview Custom Text")
    }
}
