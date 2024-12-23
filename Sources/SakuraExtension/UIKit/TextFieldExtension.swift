//
//  
//
//  Created by Vũ Thị Thanh on 23/12/24.
//

import Foundation
import SwiftUI

@available(iOS 13.0, *)
public extension TextField {
    func placeHolder(content: String, font: Font, color: Color) -> some View {
        self
            .background(
                HStack {
                    Text(content)
                        .font(font)
                        .textColor(color)
                        .autoResize(numberLines: 1)
                    
                    Spacer()
                }
            )
    }
}
