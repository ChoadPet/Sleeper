//
//  AudioRecordingService.swift
//  Sleeper
//
//  Created by user on 25.07.2020.
//  Copyright © 2020 vpoltave. All rights reserved.
//

import AVFoundation

protocol AudioRecordingServiceDelegate: class {
    func audioServiceStartRecording(_ audioService: AudioRecordingService)
    func audioServiceStopRecording(_ audioService: AudioRecordingService)
    func audioServiceFinishRecording(_ audioService: AudioRecordingService)
}

final class AudioRecordingService: NSObject {
    
    weak var delegate: AudioRecordingServiceDelegate?
    
    private let recordingSession: AVAudioSession
    private let recorder: AVAudioRecorder?
    
    private static let recordingSettings: [String: Any] = [
        AVFormatIDKey: kAudioFormatMPEG4AAC,
        AVSampleRateKey: 32000,
        AVNumberOfChannelsKey: 1
    ]
    
    
    init(fileURL: URL) throws {
        recordingSession = AVAudioSession.sharedInstance()
        
        try recordingSession.setCategory(.playAndRecord, options: [.defaultToSpeaker, .mixWithOthers])
        try recordingSession.setActive(true)
        
        recorder = try AVAudioRecorder(url: fileURL, settings: AudioRecordingService.recordingSettings)
        super.init()
        
        recorder?.delegate = self
        recorder?.prepareToRecord()
        
        registrateInterruptionNotification()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func record(duration: TimeInterval) {
        recorder?.record(forDuration: duration)
        delegate?.audioServiceStartRecording(self)
    }
    
    func stopRecording() {
        print("Stop recording")
        recorder?.stop()
        delegate?.audioServiceStopRecording(self)
    }
    
    // MARK: Handling interruption
    
    private func registrateInterruptionNotification() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleInterruption),
                                               name: AVAudioSession.interruptionNotification,
                                               object: nil)
    }
    
    @objc private func handleInterruption(notification: Notification) {
         print("handleInterruption")
        guard (recorder?.isRecording ?? false),
            let userInfo = notification.userInfo,
            let typeValue = userInfo[AVAudioSessionInterruptionTypeKey] as? UInt,
            let type = AVAudioSession.InterruptionType(rawValue: typeValue) else {
                return
        }
        switch type {
        case .began:
            break
        case .ended:
            guard let optionsValue = userInfo[AVAudioSessionInterruptionOptionKey] as? UInt else { return }
            let options = AVAudioSession.InterruptionOptions(rawValue: optionsValue)
            if options.contains(.shouldResume) {
                print("shouldResume")
            } else {
                print("should not resume")
            }
        default: break
        }
    }
    
}

extension AudioRecordingService: AVAudioRecorderDelegate {
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        print("Finish recording")
        delegate?.audioServiceFinishRecording(self)
    }
    
}
