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
    
    func rewindVideo(by seconds: Double) {
        let currentTime = self.currentTime()
        let newTime = max(currentTime.seconds - seconds, 0.0)
        self.seek(to: CMTime(value: CMTimeValue(newTime), timescale: 1000))
    }
    
    func forwardVideo(by seconds: Double) {
        if let duration = self.currentItem?.duration {
            let currentTime = self.currentTime().seconds
            var newTime = min(currentTime + seconds, duration.seconds)
            
            self.seek(to: CMTime(seconds: newTime, preferredTimescale: 10000))
        }
    }
}
