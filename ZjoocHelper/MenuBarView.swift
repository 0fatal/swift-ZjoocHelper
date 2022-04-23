//
//  MenuBarView.swift
//  ZjoocHelper
//
//  Created by Zachary ╮ on 2022/4/21.
//

import Combine
import SwiftUI

struct MenuBarView: View {
    private var updateInterval: Double = 60 * 60
    
    @State var timer = Timer.publish(every: 60, tolerance: 10, on: .main, in: .common).autoconnect()
    
    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: "circle")
            Text("zjooc").font(.system(.body, design: .monospaced).bold())
        }
        .onAppear {
            self.timer = Timer.publish(every: updateInterval, on: .main, in: .common).autoconnect()
            Task {
                print(await doLogin())
                let res = await getHomework()
                print(res)
            }
        }
        .onReceive(timer) {_ in
            Task {
                let res = await getHomework()
                print(res)
            }
        }.onChange(of: updateInterval) {interval in
            self.timer = Timer.publish(every: interval, on: .main, in: .common).autoconnect()
        }
    }
    
}
