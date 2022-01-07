//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Алексей Полетаев on 12.10.2021.
//

import SwiftUI

@main
struct WeatherAppApp: App {
    
    @Environment(\.scenePhase) var scenePhase
    
    init() {
        print("📟 AppSUIApp application is starting up. App initialiser.")
        
        Configurator.shared.register()
    }
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                ContentView()
            }
        }
        .onChange(of: scenePhase) { newScenePhase in
          switch newScenePhase {
          case .active:
            print("📟 App is active")
          case .inactive:
            print("📟 App is inactive")
          case .background:
            print("📟 App is in background")
          @unknown default:
            print("📟 Oh - interesting: I received an unexpected new value.")
          }
        }
    }
}
