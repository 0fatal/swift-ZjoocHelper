//
//  MenuBarView.swift
//  ZjoocHelper
//
//  Created by Zachary ╮ on 2022/4/21.
//

import Combine
import SwiftUI

struct MenuBarView: View {
//    private var updateInterval: Double = 60 * 60
    
//    @State var timer = Timer.publish(every: 60, tolerance: 10, on: .main, in: .common).autoconnect()
    
    var body: some View {
        HStack(spacing: 4) {
            Image("favicon").resizable().aspectRatio(contentMode: .fit)

            Text("ZJOOC").font(.system(.body, design: .monospaced).bold())
        }
        .onAppear {
//            self.timer = Timer.publish(every: updateInterval, on: .main, in: .common).autoconnect()
            Task {
                await doLogin()
            }
        }
//        .onReceive(timer) {_ in
//
//        }.onChange(of: updateInterval) {interval in
//            self.timer = Timer.publish(every: interval, on: .main, in: .common).autoconnect()
//        }
    }
    
}
