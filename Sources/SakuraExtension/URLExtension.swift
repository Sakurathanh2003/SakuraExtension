//
//  File.swift
//  
//
//  Created by Duc apple  on 2/1/25.
//

import Foundation
import AVFoundation
import UIKit

public extension URL {
    var isVideo: Bool {
        let pathExtension = self.pathExtension
        return pathExtension == "mp4" || pathExtension == "mov"
    }
    
    func getThumbnailImage() -> UIImage? {        
        if !isVideo {
            return UIImage(contentsOfFile: self.path)
        }
        
        do {
            let asset = AVURLAsset(url: self, options: nil)
            let imgGenerator = AVAssetImageGenerator(asset: asset)
            imgGenerator.appliesPreferredTrackTransform = true
            let cgImage = try imgGenerator.copyCGImage(at: CMTimeMake(value: 1, timescale: 10), actualTime: nil)
            let thumbnail = UIImage(cgImage: cgImage)

            return thumbnail
        } catch {
            return nil
        }
    }
}
