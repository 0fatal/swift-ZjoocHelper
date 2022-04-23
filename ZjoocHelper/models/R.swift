//
//  R.swift
//  ZjoocHelper
//
//  Created by Zachary ╮ on 2022/4/23.
//

import Foundation

struct R<T:Decodable>: Decodable {
    let code: Int
    let msg: String
    let data: T?
}
