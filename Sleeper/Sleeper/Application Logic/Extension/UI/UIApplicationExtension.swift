//
//  UIApplicationExtension.swift
//  Sleeper
//
//  Created by user on 17.08.2020.
//  Copyright © 2020 vpoltave. All rights reserved.
//

import UIKit

extension UIApplication {
    
    // https://stackoverflow.com/a/57899013/6057764
    class func topViewController() -> UIViewController? {
        guard let window = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first, let rootViewController = window.rootViewController else {
            return nil
        }
        var top: UIViewController? = rootViewController
        while true {
            if let presented = top?.presentedViewController {
                top = presented
            } else if let nav = top as? UINavigationController {
                top = nav.visibleViewController
            } else if let tab = top as? UITabBarController {
                top = tab.selectedViewController
            } else {
                break
            }
        }
        return top
    }
}
