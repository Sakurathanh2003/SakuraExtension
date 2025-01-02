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
        let time = CMTime(seconds: newTime, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        self.seek(to: time)
    }
    
    func forwardVideo(by seconds: Double) {
        let currentTime = self.currentTime()
        let newTime = min(currentTime.seconds + seconds, duration.seconds)
        let time = CMTime(seconds: newTime, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        self.seek(to: time)
    }
}
