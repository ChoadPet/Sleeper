//
//  AudioService.swift
//  Sleeper
//
//  Created by user on 22.07.2020.
//  Copyright © 2020 vpoltave. All rights reserved.
//

import AVFoundation

protocol AudioPlayingServiceDelegate: class {
    func audioServiceStartPlaying(_ audioService: AudioPlayingService)
    func audioServiceStopPlaying(_ audioService: AudioPlayingService)
    func audioServicePausePlaying(_ audioService: AudioPlayingService)
}

final class AudioPlayingService {
    
    weak var delegate: AudioPlayingServiceDelegate?
    
    private let session: AVAudioSession
    private let player: AVAudioPlayer?
    
    private var currentTimer: Timer?
    
    
    init(fileURL: URL) throws {
        session = AVAudioSession.sharedInstance()
        
        /// Insane, that Apple does not mentioned, `.mixWithOthers`- option needed for background,
        /// sound won't start playing after incoming call in background mode
        try session.setCategory(.playAndRecord, options: [.defaultToSpeaker, .mixWithOthers])
        try session.setActive(true)
        
        player = try AVAudioPlayer(contentsOf: fileURL)
        player?.numberOfLoops = -1
        player?.prepareToPlay()
        
        registrateInterruptionNotification()
    }
    
    /// When `shouldStartTimer == false`, `duration` parameter is ignoring
    func play(for duration: TimeInterval, shouldStartTimer: Bool = true) {
        player?.play()
        delegate?.audioServiceStartPlaying(self)
        
        if shouldStartTimer {
            invalidateTimer()
            startPlayingTimer(duration: duration)
        }
    }
    
    func stop() {
        player?.stop()
        player?.currentTime = 0
        delegate?.audioServiceStopPlaying(self)
        
        invalidateTimer()
    }
    
    func pause() {
        player?.pause()
        delegate?.audioServicePausePlaying(self)
    }
    
    // MARK: Private API
    
    private func startPlayingTimer(duration: TimeInterval) {
        currentTimer = Timer.scheduledTimer(withTimeInterval: duration, repeats: false) { _ in
            self.stop()
        }
    }
    
    private func invalidateTimer() {
        currentTimer?.invalidate()
    }
    
    // MARK: Handling interruption
    
    private func registrateInterruptionNotification() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleInterruption),
                                               name: AVAudioSession.interruptionNotification,
                                               object: nil)
    }
    
    @objc private func handleInterruption(notification: Notification) {
        guard let userInfo = notification.userInfo,
            let typeValue = userInfo[AVAudioSessionInterruptionTypeKey] as? UInt,
            let type = AVAudioSession.InterruptionType(rawValue: typeValue) else {
                return
        }
        switch type {
        case .began:
            pause()
        case .ended:
            guard let optionsValue = userInfo[AVAudioSessionInterruptionOptionKey] as? UInt else { return }
            let options = AVAudioSession.InterruptionOptions(rawValue: optionsValue)
            if options.contains(.shouldResume) {
                play(for: .infinity, shouldStartTimer: false)
            } else {
                stop()
            }
        default: break
        }
    }
    
}
