//
//  File.swift
//  
//
//  Created by Duc apple  on 2/1/25.
//

import Foundation

public extension CGSize {
    func scale(_ number: CGFloat) -> CGSize {
        return .init(width: width * number, height: height * number)
    }
}
