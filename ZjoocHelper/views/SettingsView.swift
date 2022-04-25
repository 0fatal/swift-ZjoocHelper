//
//  SettingsView.swift
//  ZjoocHelper
//
//  Created by Zachary ╮ on 2022/4/22.
//

import Foundation
import LaunchAtLogin
import SwiftUI

struct AccountSettingsView: View {
    @AppStorage("username") private var username: String = ""
    @AppStorage("password") private var password: String = ""

    var body: some View {
        VStack(spacing: 16) {
            Form {
                TextField("用户名:", text: $username).textFieldStyle(.roundedBorder).frame(width: 200)
                TextField("密码:", text: $password).textFieldStyle(.roundedBorder).frame(width: 200)
            }
        }
    }
}

struct SettingsView: View {
    var body: some View {
        TabView {
            AccountSettingsView().tabItem {
                Label("Account", systemImage: "at")
            }
        }.frame(width: 560, height: 320)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
