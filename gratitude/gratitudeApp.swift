//
//  gratitudeApp.swift
//  gratitude
//
//  Created by Pedro Henrique Cordeiro Soares on 28/09/21.
//

import SwiftUI

@main
struct gratitudeApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some Scene {
        WindowGroup { NavigationView { HomeView() } .accentColor(.black).preferredColorScheme(.light) }
        .onChange(of: scenePhase) { phase in
            NotificationService.instance.requestAuthorization()
        }
    }
}
