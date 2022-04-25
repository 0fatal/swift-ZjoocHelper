//
//  ZjoocVM.swift
//  ZjoocHelper
//
//  Created by Zachary ╮ on 2022/4/21.
//

import Foundation
import SwiftUI

class ZjoocVM: ObservableObject {
    static let shared = ZjoocVM()

    @Published var hostingView: NSHostingView<AnyView>?
}
