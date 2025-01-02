//
//  SakuraVideoPlayerLayer.swift
//
//
//  Created by Duc apple  on 2/1/25.
//

import Foundation
import SwiftUI
import AVFoundation

public struct SakuraVideoPlayerLayer {
    var player: AVPlayer
    var videoGravity: AVLayerVideoGravity
    
    public init(player: AVPlayer, videoGravity: AVLayerVideoGravity) {
        self.player = player
        self.videoGravity = videoGravity
    }
    
    public class PlayerViewController: UIViewController {
        var playerLayer: AVPlayerLayer!
        var player: AVPlayer
        var videoGravity: AVLayerVideoGravity
        
        init(player: AVPlayer, videoGravity: AVLayerVideoGravity) {
            self.player = player
            self.videoGravity = videoGravity
            super.init(nibName: nil, bundle: nil)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        public override func viewDidLoad() {
            super.viewDidLoad()
            
            // Setup AVPlayerLayer
            playerLayer = AVPlayerLayer()
            playerLayer.player = player
            playerLayer.frame = view.bounds
            playerLayer.videoGravity = videoGravity
            view.layer.addSublayer(playerLayer)
        }
        
        public override func viewWillLayoutSubviews() {
            super.viewWillLayoutSubviews()
            playerLayer.frame = view.bounds
        }
        
        public override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            playerLayer.frame = view.bounds
        }
    }
}

extension SakuraVideoPlayerLayer: UIViewControllerRepresentable {
    public func makeUIViewController(context: Context) -> PlayerViewController {
        return PlayerViewController(player: player, videoGravity: videoGravity)
    }
    
    public func updateUIViewController(_ uiViewController: PlayerViewController, context: Context) {
        uiViewController.playerLayer.player = player
    }
}
