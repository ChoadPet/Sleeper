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
    func audioServiceFinishRecording(_ audioService: AudioRecordingService)
}

final class AudioRecordingService: NSObject {
    
    weak var delegate: AudioRecordingServiceDelegate?
    
    private let recorder: AVAudioRecorder?
    
    private static let recordingSettings: [String: Any] = [
        AVFormatIDKey: kAudioFormatMPEG4AAC,
        AVSampleRateKey: 32000,
        AVNumberOfChannelsKey: 1
    ]
    
    
    init(fileURL: URL) throws {
        recorder = try AVAudioRecorder(url: fileURL, settings: AudioRecordingService.recordingSettings)
        super.init()
        
        recorder?.delegate = self
        recorder?.prepareToRecord()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func record(duration: TimeInterval) {
        let isSuccessfully = recorder?.record(forDuration: duration)
        if (isSuccessfully ?? false) {
            delegate?.audioServiceStartRecording(self)
        } else {
            delegate?.audioServiceFinishRecording(self)
        }
    }
    
}

extension AudioRecordingService: AVAudioRecorderDelegate {
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        delegate?.audioServiceFinishRecording(self)
    }
    
}
