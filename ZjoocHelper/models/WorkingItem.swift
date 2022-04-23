//
//  WorkingItem.swift
//  ZjoocHelper
//
//  Created by Zachary ╮ on 2022/4/22.
//

import Foundation
import SwiftDate


struct WorkingItem: Hashable,Codable {
    var courseName:String
    var endTime: Date
    var paperName: String
    var courseId: String?
    var allowCount: Int?
    var scorePropor: String?
    var paperId: String?
    var testCount: Int?
    
    init(courseName:String, paperName: String, endTime:Date)  {
        self.courseName = courseName
        self.paperName = paperName
        self.endTime = endTime
    }
    
    enum CodingKeys:String, CodingKey {
        case courseName
        case endTime
        case paperName
        case courseId
        case allowCount
        case scorePropor
        case paperId
        case testCount
    }
    
    init(from decoder: Decoder)  {

            let container = try! decoder.container(keyedBy: CodingKeys.self)
            
        courseName = try! container.decode(String.self, forKey: .courseName)
        let _endTime = try! container.decode(String.self, forKey: .endTime)
       

        
        let date = _endTime.toDate()
        
        endTime = date!.date
        paperName = try! container.decode(String.self, forKey: .paperName)
        courseId = try? container.decode(String.self, forKey: .courseId)
        allowCount = try? container.decode(Int.self,forKey: .allowCount)
        scorePropor = try? container.decode(String.self,forKey: .scorePropor)
        paperId = try? container.decode(String.self, forKey: .paperId)
        testCount = try? container.decode(Int.self,forKey: .testCount)


        }

}
