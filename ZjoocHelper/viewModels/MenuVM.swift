//
//  MenuVM.swift
//  ZjoocHelper
//
//  Created by Zachary ╮ on 2022/4/24.
//

import Foundation

// use async/await in Main thread?: https://gist.github.com/jakob/22c9725caac5125c1273ece93cc2e1e7
class MenuVM: ObservableObject {
    @Published var _homework: [WorkingItem] = []
    @Published var _test: [WorkingItem] = []
    @Published var _exam: [WorkingItem] = []
    
    @Published var _isFetchingHomework = false
    @Published var _isFetchingTest = false
    @Published var _isFetchingExam = false
    
    var isFetchingHomework: Bool {
        set {
            DispatchQueue.main.async {
                self._isFetchingHomework = newValue
            }
        }
        get {
            _isFetchingHomework
        }
    }
    
    var isFetchingExam: Bool {
        set {
            DispatchQueue.main.async {
                self._isFetchingExam = newValue
            }
        }
        get {
            _isFetchingExam
        }
    }
    
    var isFetchingTest: Bool {
        set {
            DispatchQueue.main.async {
                self._isFetchingTest = newValue
            }
        }
        get {
            _isFetchingTest
        }
    }
    
    var homework: [WorkingItem]? {
        set {
            DispatchQueue.main.async {
                if newValue != nil {
                    self._homework.removeAll()
                    self._homework.append(contentsOf: newValue!)
                } else {
                    self._homework.removeAll()
                }
            }
        }
        get {
            _homework
        }
    }

    var test: [WorkingItem]? {
        set {
            DispatchQueue.main.async {
                if newValue != nil {
                    self._test.removeAll()
                    self._test.append(contentsOf: newValue!)
                } else {
                    self._test.removeAll()
                }
            }
        }
        get {
            _test
        }
    }

    var exam: [WorkingItem]? {
        set {
            DispatchQueue.main.async {
                if newValue != nil {
                    self._exam.removeAll()
                    self._exam.append(contentsOf: newValue!)
                } else {
                    self._exam.removeAll()
                }
            }
        }
        get {
            _exam
        }
    }

    @Published var _needLogin: Bool = false
    
    static let shared = MenuVM()
    
    var needLogin: Bool {
        get {
            _needLogin
        }
        set {
            DispatchQueue.main.async {
                self._needLogin = newValue
            }
        }
    }
    
    func tryLogin() async -> Bool {
        var count = 0
        while count < 3 {
            if await doLogin() {
                return true
            }
            count += 1
        }
        return false
    }
    
    func doWithLogin(action: () async throws -> Void) async throws {
        do {
            try await action()
        } catch {
            needLogin = true
            if await tryLogin() {
                needLogin = false
                try! await action()
            }
        }
    }
    
    func refreshData() {
        Task {
            do {
                isFetchingHomework = true
                try await doWithLogin {
                    let _homework = try await getHomework()
                    
                    self.homework = _homework
                }
            } catch {}
            isFetchingHomework = false
        }
        Task {
            do {
                isFetchingTest = true
                try await doWithLogin {
                    isFetchingTest = true
                    let _test = try await getTest()
                    
                    self.test = _test
                }
            } catch {}
            isFetchingTest = false
        }
        Task {
            do {
                isFetchingExam = true
                try await doWithLogin {
                    isFetchingExam = true
                    let _exam = try await getExam()
                    
                    self.exam = _exam
                }
            } catch {}
            isFetchingExam = false
        }
    }
}
