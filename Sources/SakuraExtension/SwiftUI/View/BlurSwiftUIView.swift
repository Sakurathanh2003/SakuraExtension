//
//  File.swift
//  
//
//  Created by Duc apple  on 24/12/24.
//

import Foundation
import SwiftUI

struct BlurSwiftUIView: UIViewRepresentable {
    var effect: UIBlurEffect
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: effect)
        view.backgroundColor = .clear
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        
    }
}
