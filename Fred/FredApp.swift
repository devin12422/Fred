//
//  FredApp.swift
//  Fred
//
//  Created by Devin Kramer (student LM) on 2/27/23.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth
class FredDelegate :NSObject, UIApplicationDelegate{
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
@main
struct FredApp: App {
    @UIApplicationDelegateAdaptor(FredDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
