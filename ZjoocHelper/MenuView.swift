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
    
    @State var homework: [WorkingItem] = []
    @State var test: [WorkingItem] = []
    @State var exam: [WorkingItem] = []
    
    init() {}
    
    var body: some View {
        ScrollView{
            VStack(spacing: 8) {
                Form {
                    PanelView(items: homework,headline: "作业" )
                    
                }
                Form {
                    PanelView(items: test, headline: "测试")
                    
                }
                Form {
                    PanelView(items: exam,headline: "考试")
                }
            }.onAppear {
                Task {
                    getHomework().
                    homework = (await getHomework()) ?? []
                    test = (await getTest()) ?? []
                    exam = (await getExam()) ?? []
                }
            }
        }
    }
}

struct PanelView: View {

    let items: [WorkingItem]
    let headline: String
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(headline) \(items.count)").font(Font.system(size: 26, weight: .bold)).padding(.all, 10).frame(maxWidth: .infinity,alignment: .leading)
      
            ForEach(items,id: \.self) {item in
                WorkingItemView(item: item)
                Divider()
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
        HStack() {
            Text("\(item.paperName)").frame(width:200,height: 30,alignment: .leading).truncationMode(.tail).foregroundColor(.blue)
            Spacer()
            Text("[\(item.courseName)]")
            Text("\(endTime)")
        }.padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
    }
}
