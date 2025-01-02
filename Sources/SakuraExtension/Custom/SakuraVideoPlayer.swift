//
//  File.swift
//  
//
//  Created by Duc apple  on 2/1/25.
//

import AVFoundation
import UIKit
import MediaPlayer

@objc public protocol SakuraVideoPlayerDelegate: AnyObject {
    @objc optional func videoPlayerBeganInterruptAudioSession(_ player: SakuraVideoPlayer)
    @objc optional func videoPlayerUpdatePlayingState(_ player: SakuraVideoPlayer, isPlaying: Bool)
    @objc optional func videoPlayerDidPlaying(_ player: SakuraVideoPlayer, _ progress: Double)
    @objc optional func videoPlayerReadyToPlay(_ player: SakuraVideoPlayer)
    @objc optional func videoPlayerFailToLoad(_ player: SakuraVideoPlayer)
    @objc optional func videoPlayerPlayToEnd(_ player: SakuraVideoPlayer)
    @objc optional func videoPlayerAudioRouteChanged(_ player: SakuraVideoPlayer, isPlaying: Bool)
}

public class SakuraVideoPlayer: AVPlayer {
    public weak var delegate: SakuraVideoPlayerDelegate?
    public var loopEnable: Bool = false
    public var pauseWhenEnterBackground: Bool = false
    private var timerObserver: Any?
    public var isFailed: Bool = false

    deinit {
        self.removeObserves()
    }
    
    // MARK: - Observer
    func removeObserves() {
        self.removeObserver(self, forKeyPath: "rate")
        if let playerItem = self.currentItem {
            playerItem.removeObserver(self, forKeyPath: #keyPath(AVPlayerItem.status))
        }
    }

    open override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == #keyPath(AVPlayerItem.status) {
            let status = self.currentItem?.status
            if status == .readyToPlay {
                self.delegate?.videoPlayerReadyToPlay?(self)
            }

            if status == .failed {
                self.delegate?.videoPlayerFailToLoad?(self)
                self.replaceCurrentItem(with: nil)
            }
        }

        if keyPath == #keyPath(AVPlayer.rate) {
            self.delegate?.videoPlayerUpdatePlayingState?(self, isPlaying: isPlaying)
        }
    }

    // MARK: - Notifications
    private func registerNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(audioSessionIterruptionNotification(_:)), name: AVAudioSession.interruptionNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(applicationWillResignActiveNotification(_:)), name: UIApplication.willResignActiveNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(audioRouteChangeListener), name: AVAudioSession.routeChangeNotification, object: nil)
    }

    @objc private func audioRouteChangeListener(_ notification: Notification) {
        self.delegate?.videoPlayerAudioRouteChanged?(self, isPlaying: isPlaying)
    }

    @objc func playerItemDidPlayToEnd(_ notification: Notification) {
        if self.loopEnable {
            self.seek(to: .zero)
            self.play()
        }

        self.delegate?.videoPlayerPlayToEnd?(self)
    }

    @objc func applicationWillResignActiveNotification(_ notification: Notification) {
        if self.pauseWhenEnterBackground {
            self.pause()
        }
    }

    @objc private func audioSessionIterruptionNotification(_ notification: Notification) {
        guard let typeValue = notification.userInfo?[AVAudioSessionInterruptionTypeKey] as? UInt,
           let type = AVAudioSession.InterruptionType(rawValue: typeValue) else {
               return
        }

        if type == .began {
            delegate?.videoPlayerBeganInterruptAudioSession?(self)
        }
    }

    // MARK: - Audio session
    private func activeAudioSession() {
        try? AVAudioSession.sharedInstance().setCategory(.playAndRecord, options: .defaultToSpeaker)
        try? AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
        try? AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
    }
    
    // MARK: - Seek
    func seekTo(_ time: TimeInterval) {
        let cmtime = CMTime.init(seconds: time, preferredTimescale: 1)
        self.seek(to: cmtime, toleranceBefore: .zero, toleranceAfter: .zero)
    }
    
    func seekTo(_ time: CMTime) {
        self.seek(to: time, toleranceBefore: .zero, toleranceAfter: .zero)
    }
    
    // MARK: - Public
    public override func play() {
        activeAudioSession()
        super.play()
    }
    
    public override func pause() {
        super.pause()
        self.delegate?.videoPlayerUpdatePlayingState?(self, isPlaying: false)
    }
    
    func config() {
        initPlayer()
        registerNotifications()
    }
    
    private func initPlayer() {
        self.addObserver(self, forKeyPath: "rate", options: [.initial, .old, .new], context: nil)
    }
    
    func setRate(rate: Float) {
        self.rate = rate
    }
   
    @discardableResult
    public func replacePlayerItem(_ item: AVPlayerItem?) -> Bool {
        if let oldItem = self.currentItem {
            if let newItem = item, comparePlayerItem(lhs: oldItem, rhs: newItem) {
                return false
            }

            oldItem.removeObserver(self, forKeyPath: #keyPath(AVPlayerItem.status))
            NotificationCenter.default.removeObserver(self, name: .AVPlayerItemDidPlayToEndTime, object: oldItem)
        }

        self.replaceCurrentItem(with: item)
        if item != nil {
            item?.addObserver(self, forKeyPath: #keyPath(AVPlayerItem.status), options: [.new], context: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidPlayToEnd(_:)), name: .AVPlayerItemDidPlayToEndTime, object: item!)
        }

        return true
    }

    func addPlayerObserver() {
        let interval = CMTime(value: 1, timescale: CMTimeScale(NSEC_PER_SEC))
        timerObserver = self.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main, using: { [weak self] time in
            guard let self = self else { return }
            
            guard let item = self.currentItem else { return }
            let progress = time.seconds / item.duration.seconds
            if progress.isNaN || progress.isInfinite {
                return
            }
            
            self.delegate?.videoPlayerDidPlaying?(self, progress)
        })
    }
    
    func removePlayerObserver() {
        if let timerObserver = timerObserver {
            self.removeTimeObserver(timerObserver)
        }
    }
    
    private func comparePlayerItem(lhs: AVPlayerItem, rhs: AVPlayerItem) -> Bool {
        guard let lhsAsset = lhs.asset as? AVURLAsset,
              let rhsAsset = rhs.asset as? AVURLAsset else {
            return false
        }

        return lhsAsset.url == rhsAsset.url
    }
}

// MARK: - Get
public extension SakuraVideoPlayer {
    var isPlaying: Bool {
        return self.rate != 0
    }
}
