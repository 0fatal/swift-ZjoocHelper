//
//  MenuView.swift
//  ZjoocHelper
//
//  Created by Zachary ╮ on 2022/4/21.
//

import Foundation
import SwiftUI
import SwiftfulLoadingIndicators

struct MenuView: View {
    // 当前进行中的测试数/全部测试数
    // 未完成的测试举例
    // [课程名]测试名称 - 截止时间
    
    @State var homework: [WorkingItem]?
    @State var test: [WorkingItem]?
    @State var exam: [WorkingItem]?
    @State var needLogin: Bool = false
    
    init() {
    }
    
    func tryLogin() async -> Bool{
        var count = 0
        while count < 3 {
            if await doLogin() {
                return true
            }
            count += 1
        }
        return false
    }
    
    func doWithLogin(action: () async throws-> Void)async -> Void {
        do {
            try await action()
        } catch {
            needLogin = true
            if await tryLogin() {
                needLogin = false
                try? await action()
            }
        }
    }
    
    func refreshData() {
        Task {
            await doWithLogin{
                homework = try await getHomework()
            }
        }
        Task {
            await doWithLogin{
                test = try await getTest()
            }
            
        }
        Task {
            await doWithLogin{
                exam = try await getExam()
            }
        }
    }
    
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading,spacing: 8) {
                HStack{
                    Spacer()
                    if needLogin {
                        Button("relogin") {
                            Task {
                                if await doLogin() {
                                    needLogin = false
                                }
                            }
                        }
                    }
                    Button(action:{
                        refreshData()
                    },label:{
                            Image(systemName: "arrow.clockwise")
                    })

                    
                }
                Form {
                    Section {
                        PanelView(items: homework,headline: "作业" )
                    }
                    Section {
                        PanelView(items: test, headline: "测试")
                    }
                    Section {
                        PanelView(items: exam,headline: "考试")
                    }
                }
                
            }.onAppear {
                refreshData()
            }
        }
    }
}


struct PanelView: View {
    
    let items: [WorkingItem]?
    let headline: String
    var body: some View {
        
        VStack(alignment: .leading) {
            HStack{Text("\(headline)").font(Font.system(size: 26, weight: .bold))
                Text("\((items ?? []).count)个").font(Font.system(size: 20, weight: .bold)).foregroundColor(.orange)
            }
            
                .padding(.all, 10).frame(maxWidth: .infinity,alignment: .leading)
            
            
            
            Form {
            
                    if items == nil {
                        HStack(alignment: .center ) {
                            Spacer()
                            VStack() {
                                LoadingIndicator(animation: .fiveLines)
                                Text("加载中...")
                            }
                            Spacer()
                        }
                        
                    }else {
                        ForEach(items!,id: \.self) {item in
                            WorkingItemView(item: item)
                        }
              
                        
                    }
                }.frame(minHeight:100).background(.white.opacity(0.8)).cornerRadius(5)
                

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
        let time = item.endTime
//        let now = Date.now
//        let day = time.day - now.day
//        let min = time.minute - now.minute
//        let hour = time.hour - now.hour
        var sec = Int64(time.timeIntervalSinceNow)
        var min = (sec/60) % 60
        var hour = (sec/60/60) % ( 24)
        var day = (sec/60/60/24)
 
        
        if day > 0 {
           
            return "还剩\(day)天\(hour)时\(min)分"
        }
        if hour > 0 {
            min /=  60 * 60
            hour /=  60
            return "还剩\(hour)时\(min)分"
        }
        if min > 0 {
            min /= 60
            return "还剩\(min)分"
        }
        return "还剩\(sec)秒"
    }
    
    
    var body: some View {
        HStack(alignment: .center) {
            Text("\(item.paperName)").frame(width:200,height: 30,alignment: .leading).truncationMode(.tail).foregroundColor(.blue)
            Spacer()
            if item.scorePropor != nil{
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
        
        MenuView()
        
    }
}
