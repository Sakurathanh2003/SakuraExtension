//
//  File.swift
//  
//
//  Created by Duc apple  on 31/12/24.
//

import Foundation
import CoreImage
import UIKit

public extension CIImage {
    func rotate(radians: CGFloat?) -> CIImage {
        guard let radians = radians else {
            return self
        }
        
        var ciImage = self
        ciImage = ciImage.transformed(by: CGAffineTransform(rotationAngle: CGFloat(radians)))
        let newX = ciImage.extent.origin.x * -1
        let newY = ciImage.extent.origin.y * -1
        let transform = CGAffineTransform(translationX: newX , y: newY)
        ciImage = ciImage.transformed(by: transform)
        return ciImage
    }
    
    func flipHorizontally() -> CIImage {
        let transformScale = CGAffineTransform(scaleX: -1, y: 1)
        let transformTranslation = CGAffineTransform(translationX: self.extent.size.width, y: 0)
        var ciImageTransformed = self.transformed(by: transformScale)
        ciImageTransformed = ciImageTransformed.transformed(by: transformTranslation)
        return ciImageTransformed
    }
}

public extension CIImage {
    var image: UIImage { .init(ciImage: self) }
    
    func colorized(with color: UIColor) -> CIImage? {
        guard
            let (r,g,b,a) = color.rgba,
            let colorMatrix = CIFilter(name: "CIColorMatrix",
                parameters: ["inputImage":  self,
                             "inputRVector": CIVector(x: r, y: 0, z: 0, w: 0),
                             "inputGVector": CIVector(x: 0, y: g, z: 0, w: 0),
                             "inputBVector": CIVector(x: 0, y: 0, z: b, w: 0),
                             "inputAVector": CIVector(x: 0, y: 0, z: 0, w: a)])
        else { return nil }
        return colorMatrix.outputImage
    }
}
