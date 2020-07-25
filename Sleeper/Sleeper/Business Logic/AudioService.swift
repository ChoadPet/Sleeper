//
//  AudioService.swift
//  Sleeper
//
//  Created by user on 22.07.2020.
//  Copyright © 2020 vpoltave. All rights reserved.
//

import AVFoundation

protocol AudioServiceDelegate: class {
    func audioServiceStartPlaying(_ audioService: AudioService)
    func audioServiceStopPlaying(_ audioService: AudioService)
    func audioServiceStartRecording(_ audioService: AudioService)
}

final class AudioService {
    
    weak var delegate: AudioServiceDelegate?
    
    private let player: AVAudioPlayer?
    private var currentTimer: Timer?
    
    
    init(fileURL: URL) throws {
        try AVAudioSession.sharedInstance().setCategory(.playAndRecord, options: [.defaultToSpeaker])
        try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
        
        self.player = try AVAudioPlayer(contentsOf: fileURL)
        self.player?.numberOfLoops = -1
        self.player?.prepareToPlay()
    }
    
    func startPlay(for duration: TimeInterval) {
        print("Start playing for duration: \(duration)")
        player?.play()
        delegate?.audioServiceStartPlaying(self)
        
        invalidateTimer()
        startPlayingTimer(duration: duration)
    }
    
    func stopPlay() {
        print("Stop play")
        player?.stop()
        delegate?.audioServiceStopPlaying(self)
        
        invalidateTimer()
    }
    
    // MARK: Private API
    
    private func startPlayingTimer(duration: TimeInterval) {
        print("Starting Timer")
        currentTimer = Timer.scheduledTimer(withTimeInterval: duration, repeats: false) { _ in
            self.stopPlay()
        }
    }
    
    private func invalidateTimer() {
        print("Invalidation Timer")
        currentTimer?.invalidate()
    }
}
