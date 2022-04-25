//
//  ZjoocHelperApp.swift
//  ZjoocHelper
//
//  Created by Zachary ╮ on 2022/4/20.
//

import SwiftUI

@main
struct ZjoocHelperApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate

    var body: some Scene {
        WindowGroup {
            if false {}
        }

        Settings {
            SettingsView()
        }
    }
}
