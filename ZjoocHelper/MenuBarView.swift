//
//  MenuBarView.swift
//  ZjoocHelper
//
//  Created by Zachary ╮ on 2022/4/21.
//

import Combine
import SwiftUI

struct MenuBarView: View {
    private var updateInterval: Double = 60 * 6
    
    @State var timer = Timer.publish(every: 60, tolerance: 10, on: .main, in: .common).autoconnect()
    
    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: "circle")
            Text("let").font(.system(.body, design: .monospaced).bold())
        }
        .onAppear {
            self.timer = Timer.publish(every: updateInterval, on: .main, in: .common).autoconnect()
        }
        .onReceive(timer) {_ in
//            Task {
//                await gameRecordVM.updateGameRecord()
//            }
        }.onChange(of: updateInterval) {interval in
            self.timer = Timer.publish(every: interval, on: .main, in: .common).autoconnect()
        }
    }
    
}
