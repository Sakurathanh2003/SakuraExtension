//
//  File.swift
//  
//
//  Created by Duc apple  on 24/12/24.
//

import Foundation
import SwiftUI

public struct BlurSwiftUIView: UIViewRepresentable {
    var effect: UIBlurEffect
    
    public func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: effect)
        view.backgroundColor = .clear
        return view
    }
    
    public func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        
    }
}
