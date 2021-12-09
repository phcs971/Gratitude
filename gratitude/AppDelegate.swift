//
//  AppDelegate.swift
//  gratitude
//
//  Created by Pedro Henrique Cordeiro Soares on 29/09/21.
//

import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return .portrait
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print("Start")
        GratitudeRepository.instance.read()
        return true
    }
}
