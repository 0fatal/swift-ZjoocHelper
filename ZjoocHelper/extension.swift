//
//  extension.swift
//  ZjoocHelper
//
//  Created by Zachary ╮ on 2022/4/22.
//


import SwiftUI

// Adapted from https://gist.github.com/marcprux/afd2f80baa5b6d60865182a828e83586

public struct AnyDecodable : Decodable{
  
  let value :Any
  
  public init<T>(_ value :T?) {
    self.value = value ?? ()
  }
  
  public init(from decoder :Decoder) throws {
    let container = try decoder.singleValueContainer()
    
    if let string = try? container.decode(String.self) {
      self.init(string)
    } else if let int = try? container.decode(Int.self) {
      self.init(int)
    } else {
      self.init(())
    }
    // handle all the different types including bool, array, dictionary, double etc
  }
}
