//
//  SakuraVideoPlayerLayer.swift
//
//
//  Created by Duc apple  on 2/1/25.
//

import Foundation
import SwiftUI
import AVFoundation

struct SakuraVideoPlayerLayer: UIViewControllerRepresentable {
    var player: AVPlayer
    var videoGravity: AVLayerVideoGravity
    
    class PlayerViewController: UIViewController {
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
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            // Setup AVPlayerLayer
            playerLayer = AVPlayerLayer()
            playerLayer.player = player
            playerLayer.frame = view.bounds
            playerLayer.videoGravity = videoGravity
            view.layer.addSublayer(playerLayer)
        }
        
        override func viewWillLayoutSubviews() {
            super.viewWillLayoutSubviews()
            playerLayer.frame = view.bounds
        }
        
        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            playerLayer.frame = view.bounds
        }
    }
    
    func makeUIViewController(context: Context) -> PlayerViewController {
        return PlayerViewController(player: player, videoGravity: videoGravity)
    }
    
    func updateUIViewController(_ uiViewController: PlayerViewController, context: Context) {
        // Update the player layer when needed
        uiViewController.playerLayer.player = player
    }
}
