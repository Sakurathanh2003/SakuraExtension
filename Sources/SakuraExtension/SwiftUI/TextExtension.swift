//
//  File.swift
//  
//
//  Created by Vũ Thị Thanh on 23/12/24.
//

import Foundation
import SwiftUI

@available(iOS 13.0, *)
public extension Text {
    func foreColor(_ color: Color) -> Text {
        if #available(iOS 17.0, *) {
            self.foregroundStyle(color)
        } else {
            self.foregroundColor(color)
        }
    }
    
    func autoResize(numberLines: Int) -> some View {
        self.scaledToFit()
            .minimumScaleFactor(0.5)
            .lineLimit(numberLines)
    }
    
    func textGradientColor(colors: [Color]) -> some View {
        if #available(iOS 17.0, *) {
            return self.foregroundStyle(
                LinearGradient(colors: colors, startPoint: .leading, endPoint: .trailing)
            )
        } else {
            return self.overlay(
                    LinearGradient(colors: colors, startPoint: .leading, endPoint: .trailing)
                        .mask(self)
            )
        }
    }
}
