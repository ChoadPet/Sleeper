//
//  AppDelegate.swift
//  Sleeper
//
//  Created by user on 20.07.2020.
//  Copyright © 2020 vpoltave. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    private var appCoordinator: AppCoordinator!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        appCoordinator = AppCoordinator(window: window!)
        appCoordinator.makeRootAccordingToUser()
        
        return true
    }

}

