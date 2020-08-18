//
//  AppDelegate.swift
//  Sleeper
//
//  Created by user on 20.07.2020.
//  Copyright © 2020 vpoltave. All rights reserved.
//

import AVFoundation
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    private var appCoordinator: AppCoordinator!
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let audioSession = AVAudioSession.sharedInstance()
        
        /// Insane, that Apple does not mentioned, `.mixWithOthers`- option needed for background,
        /// sound won't start playing after incoming call in background mode
        try? audioSession.setCategory(.playAndRecord, options: [.defaultToSpeaker, .mixWithOthers])
        try? audioSession.setActive(true)
        
        window = UIWindow()
        window!.overrideUserInterfaceStyle = .dark
        window!.tintColor = UIColor.accent
        appCoordinator = AppCoordinator(window: window!)
        appCoordinator.makeRootAccordingToUser()
        
        return true
    }

}

