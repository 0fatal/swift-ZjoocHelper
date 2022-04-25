//
//  MenuView.swift
//  ZjoocHelper
//
//  Created by Zachary ╮ on 2022/4/21.
//

import Foundation
import SwiftfulLoadingIndicators
import SwiftUI

struct MenuView: View {
    @ObservedObject var vm: MenuVM
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Spacer()
                    if vm.needLogin {
                        Button("relogin") {
                            Task {
                                if await doLogin() {
                                    vm.needLogin = false
                                }
                            }
                        }
                    }
                    Button(action: {
                        vm.refreshData()
                    }, label: {
                        Image(systemName: "arrow.clockwise")
                    })
                }
                Form {
                    Section {
                        PanelView(items: vm.homework, isFetching: vm.isFetchingHomework, headline: "作业")
                    }
                    Section {
                        PanelView(items: vm.test, isFetching: vm.isFetchingTest, headline: "测试")
                    }
                    Section {
                        PanelView(items: vm.exam, isFetching: vm.isFetchingExam, headline: "考试")
                    }
                }
                
            }.onAppear {
                vm.refreshData()
            }
        }
    }
}

struct PanelView: View {
    let items: [WorkingItem]?
    let isFetching: Bool
    let headline: String
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack { Text("\(headline)").font(Font.system(size: 26, weight: .bold))
                Text("\((items ?? []).count)个").font(Font.system(size: 20, weight: .bold)).foregroundColor(.orange)
                if isFetching && (items?.count ?? 0) > 0 {
                    Spacer()
                    LoadingIndicator(animation: .circleBars, size: .small)
                }
            }
            
            .padding(.all, 10).frame(maxWidth: .infinity, alignment: .leading)
            
            Form {
                if isFetching && (items?.count ?? 0) == 0 {
                    HStack(alignment: .center) {
                        Spacer()
                        VStack {
                            LoadingIndicator(animation: .fiveLines)
                            Text("加载中...")
                        }
                        Spacer()
                    }
                    
                } else {
                    ForEach(items!, id: \.self) { item in
                        WorkingItemView(item: item)
                    }
                }
            }.frame(minHeight: 100).background(.white.opacity(0.8)).cornerRadius(5)
        }
    }
}

struct WorkingItemView: View {
    var item: WorkingItem
    static var formatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss MM/dd"
        return formatter
    }
    
    var endTime: String {
        let time = item.endTime
        let sec = Int64(time.timeIntervalSinceNow)
        let min = (sec/60) % 60
        let hour = (sec/60/60) % 24
        let day = (sec/60/60/24)
        
        if day > 0 {
            return "还剩\(day)天\(hour)时\(min)分"
        }
        if hour > 0 {
            return "还剩\(hour)时\(min)分"
        }
        if min > 0 {
            return "还剩\(min)分"
        }
        return "还剩\(sec)秒"
    }
    
    var body: some View {
        HStack(alignment: .center) {
            Text("\(item.paperName)").frame(width: 200, height: 30, alignment: .leading).truncationMode(.tail).foregroundColor(.blue)
            Spacer()
            if item.scorePropor != nil {
                Text("[\(item.scorePropor!)] ")
                if item.allowCount != nil && item.testCount != nil {
                    Text("\(item.allowCount! - item.testCount!)次机会").foregroundColor(.indigo)
                }
                Spacer()
            }
            Text("[\(item.courseName)]")
            Spacer()
            Text("\(endTime)").foregroundColor(.orange)
        }.padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(vm: MenuVM())
    }
}
