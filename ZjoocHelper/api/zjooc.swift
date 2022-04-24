//
//  zjooc.swift
//  ZjoocHelper
//
//  Created by Zachary ╮ on 2022/4/22.
//

import Foundation
import Alamofire
import Alamofire

let baseUrl = "https://zjxxc.zacharywin.top"

func doLogin() async-> Bool{
    guard let username:String = UserDefaults.standard.string(forKey: "username"),
          let password: String = UserDefaults.standard.string(forKey: "password")
    else {return false}
    
    let url = "\(baseUrl)/user/login"
    let data = ["username":username,"password": password]
    
    
    
    guard let resp = try? await AF.request(url,method: .post,parameters:data,encoder:JSONParameterEncoder.default).serializingDecodable(R<AnyDecodable>.self).value else {
        return false
    }
    
    print(resp)
    
    
    if resp.code == 0{ return true}
    return false

}

func getHomework() async throws-> [WorkingItem]? {
    return try await getWorkingItem(path: "/course/homework")
}

func getTest() async throws-> [WorkingItem]? {
    return try await getWorkingItem(path: "/course/test")
}

func getExam() async throws-> [WorkingItem]? {
    return try await getWorkingItem(path: "/course/exam")
}

func getWorkingItem(path:String) async throws  -> [WorkingItem]? {
    let url = "\(baseUrl)\(path)"
    print(url)
    let resp = try! await AF.request(url,method: .get).serializingDecodable(R<[WorkingItem]>.self).value
    print(resp)
    if(resp.code == -1 && resp.msg == "login required") {
        throw "login required"
    }

    return resp.data
}

