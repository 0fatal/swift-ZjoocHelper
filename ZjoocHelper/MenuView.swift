//
//  MenuView.swift
//  ZjoocHelper
//
//  Created by Zachary ╮ on 2022/4/21.
//

import Foundation
import SwiftUI

struct MenuView: View {
    // 当前进行中的测试数/全部测试数
    // 未完成的测试举例
    // [课程名]测试名称 - 截止时间
    
    var body: some View {
        VStack(spacing: 8) {
            PanelView(unhandleCount: 12, totalCount: 100, items: [WorkingItem(courseName: "操作系统", endTime: Date.now, workingName: "进程调度作业"),WorkingItem(courseName: "操作系统", endTime: Date.now, workingName: "进程调度作业"),WorkingItem(courseName: "操作系统", endTime: Date.now, workingName: "进程调度作业"),WorkingItem(courseName: "操作系统", endTime: Date.now, workingName: "进程调度作业"),WorkingItem(courseName: "操作系统", endTime: Date.now, workingName: "进程调度作业")])
        }
    }
}

struct PanelView: View {
    let unhandleCount: Int
    let totalCount: Int
    let items: [WorkingItem]
    var body: some View {
        VStack {
            ForEach(items,id: \.self) {item in
                WorkingItemView(item: item)
            }
        }
    }
}

struct WorkingItemView: View{
    let item: WorkingItem
    static var formatter: DateFormatter {
        let formatter  = DateFormatter()
        formatter.dateFormat = "HH:mm:ss MM/dd"
        return formatter
    }
    
    var endTime: String {
        WorkingItemView.formatter.string(from: item.endTime)
    }
    
    
    var body: some View {
        HStack {
            Text("[\(item.courseName)]\(item.workingName)")
            Text("\(endTime)")
        }
    }
}
