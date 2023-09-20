//
//  SoundManager.swift
//  myDanceJourney
//
//  Created by Rohan Kumar on 8/4/23.
//

import Foundation
import AVKit

final class SoundManager: ObservableObject {
    private var player: AVPlayer?
    
    func initializeSound(atURL urlString: String) {
        guard let url = URL(string: urlString) else { print("=====\nFailed to reach song url: \(urlString)\n====="); return }
        self.player = AVPlayer(url: url)
        self.player?.play()
        self.player?.pause()
    }
    
    func playSound() {
        print("HERE")
        self.player?.play()
    }
    
    func pauseSound() {
        self.player?.pause()
    }
    
    func stopSound() {
        self.player = nil
    }
    
    
}
