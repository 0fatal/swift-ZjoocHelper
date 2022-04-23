//
//  AppDelegate.swift
//  ZjoocHelper
//
//  Created by Zachary ╮ on 2022/4/20.
//

import AppKit
import Foundation
import SwiftUI

final class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_: Notification) {
        
        
        // Close main APP window on initial launch
        NSApp.setActivationPolicy(.accessory)
        if let window = NSApplication.shared.windows.first {
            window.close()
        }
        
        setupStatusItem()
        setupMenus()
    }
    
    private var statusItem:NSStatusItem!
    
    private lazy var contentView: NSView? = {
        return (statusItem.value(forKey:"window") as? NSWindow)?.contentView
    }()
    
    private func setupStatusItem() {
        statusItem = NSStatusBar.system.statusItem(withLength: 100)
        let hostingView = NSHostingView(rootView: MenuBarView())
        
        // 自适应view大小
        hostingView.translatesAutoresizingMaskIntoConstraints = false
        
        guard let contentView = contentView else {return}
        contentView.addSubview(hostingView)
        
        NSLayoutConstraint.activate([
            hostingView.topAnchor.constraint(equalTo: contentView.topAnchor),
            hostingView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            hostingView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            hostingView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
        ])
    }
    
    private func setupMenus() {
        let menu = NSMenu()
        let menuItem = NSMenuItem()
        
        ZjoocVM.shared.hostingView = NSHostingView(rootView: AnyView(MenuView()))
        ZjoocVM.shared.hostingView?.frame = NSRect(x: 0, y: 0, width: 500, height: 600)
        
        menuItem.view = ZjoocVM.shared.hostingView
        
        
        menu.addItem(menuItem)
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: String(localized: "Preferences"), action: #selector(openSettingsView),
                                keyEquivalent: ","))
        //        menu.addItem(NSMenuItem(title: String(localized: "Quit"), action: #selector(NSApplication.terminate(_:)),
        //                                 keyEquivalent: "q"))
        statusItem.menu = menu
    }
    
    @objc private func openSettingsView() {
        NSApp.sendAction(Selector(("showPreferencesWindow:")), to: nil, from: nil)
        NSApp.setActivationPolicy(.regular)
        NSApp.activate(ignoringOtherApps: true)
        NSApp.windows.first?.makeKeyAndOrderFront(self)
    }
    
}
