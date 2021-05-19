//
//  View+Ext.swift
//  WeSplit
//
//  Created by Denis Yaremenko on 5/16/21.
//

import SwiftUI

extension View {
    
    func watermark(with text: String) -> some View {
        self.modifier(Watermark(text: text))
    }
    
    func titleStyle() -> some View {
        self.modifier(Title())
    }
    
    func largeBlue() -> some View {
        self.modifier(LargeBlueText())
    }
}
