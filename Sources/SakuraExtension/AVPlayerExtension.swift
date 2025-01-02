//
//  File.swift
//  
//
//  Created by Duc apple  on 2/1/25.
//

import Foundation
import AVFoundation

public extension AVPlayer {
    var duration: CMTime {
        return self.currentItem?.duration ?? .zero
    }
    
    func seek(percent: CGFloat) {
        let second = CGFloat(percent * self.duration.seconds)
        let time = CMTime(seconds: second, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        self.seek(to: time)
    }
    
    func rewindVideo(by seconds: Float64) {
        let currentTime = self.currentTime()
        var newTime = CMTimeGetSeconds(currentTime) - seconds
        if newTime <= 0 {
            newTime = 0
        }
        
        self.seek(to: CMTime(value: CMTimeValue(newTime * 1000), timescale: 1000))
        
    }
    
    func forwardVideo(by seconds: Float64) {
        if let duration = self.currentItem?.duration {
            let currentTime = self.currentTime()
            var newTime = CMTimeGetSeconds(currentTime) + seconds
            if newTime >= CMTimeGetSeconds(duration) {
                newTime = CMTimeGetSeconds(duration)
            }
            
            self.seek(to: CMTime(value: CMTimeValue(newTime * 1000), timescale: 1000))
        }
    }
}
