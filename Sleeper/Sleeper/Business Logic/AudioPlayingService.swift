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
    
    private let player: AVAudioPlayer?
    
    private var currentTimer: Timer?
    
    
    init(fileURL: URL) throws {
        player = try AVAudioPlayer(contentsOf: fileURL)
        player?.numberOfLoops = -1
        player?.prepareToPlay()
        
        registrateInterruptionNotification()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    /// When `shouldStartTimer == false`, `duration` parameter is ignoring
    func play(for duration: TimeInterval, shouldStartTimer: Bool = true) {
        player?.play()
        delegate?.audioServiceStartPlaying(self)
        
        /// Don't like this property as well :(
        /// Needed only when session is interrupted
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
        guard (player?.isPlaying ?? false),
            let userInfo = notification.userInfo,
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
