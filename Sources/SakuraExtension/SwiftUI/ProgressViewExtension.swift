//
//  File.swift
//  
//
//  Created by Duc apple  on 9/1/25.
//

import Foundation
import SwiftUI

public extension ProgressView {
    @ViewBuilder
    func circleprogressColor(_ color: Color) -> some View {
        if #available(iOS 16.0, *) {
            self.tint(color)
        } else {
            self.progressViewStyle(CircularProgressViewStyle(tint: color))
        }
    }
}
