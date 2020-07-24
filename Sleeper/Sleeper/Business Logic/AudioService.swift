//
//  AudioService.swift
//  Sleeper
//
//  Created by user on 22.07.2020.
//  Copyright © 2020 vpoltave. All rights reserved.
//

import AVFoundation

final class AudioService {
    
    var isPlaying: Bool {
        return player?.isPlaying ?? false
    }
    
    private let player: AVAudioPlayer?
    
    
    init(fileURL: URL) throws {
        self.player = try AVAudioPlayer(contentsOf: fileURL)
        self.player?.numberOfLoops = -1
        self.player?.prepareToPlay()
    }
    
    func startPlay() {
        player?.play()
    }
    
    func stopPlay() {
        player?.stop()
    }
}
