//
//  Model.swift
//  lesson_1_navigation
//
//  Created by Иван longrail on 06/03/2019.
//  Copyright © 2019 Иван longrail. All rights reserved.
//

import UIKit // Для установки цвета фона
import Foundation

var userName = "Ivan"
var password = "asdfgh1"
enum State {
    case correctData, incorrectUserName,  incorrectPassword
}

// MARK: - Authorizations result protocol

protocol AuthorizationsResult {
    var backgroundColor: UIColor { get }
    func getMessage() -> String
    func getState() -> State
}

class CorrectData: AuthorizationsResult {
    var backgroundColor = UIColor.cyan
    func getMessage() -> String {
        return "\(userName) authorized"
    }
    func getState() -> State {
        return .correctData
    }
}

class IncorrectUserName: AuthorizationsResult {
    var backgroundColor = UIColor.orange
    func getMessage() -> String {
        return "Entered user name is wrong. \nTip: ***\(userName.dropFirst(userName.count - 2))"
    }
    func getState() -> State {
        return .incorrectUserName
    }
}

class FoggotUserName: AuthorizationsResult {
    var backgroundColor = UIColor.cyan
    func getMessage() -> String {
        return "Tip: user name is ending like that ***\(userName.dropFirst(userName.count - 2))"
    }
    func getState() -> State {
        return .incorrectUserName
    }
}

class IncorrectPassword: AuthorizationsResult {
    var backgroundColor = UIColor.red
    func getMessage() -> String {
        return "Entered password is wrong"
    }
    func getState() -> State {
        return .incorrectPassword
    }
}

class FoggotPassword: AuthorizationsResult {
    var backgroundColor = UIColor.cyan
    func getMessage() -> String {
        return "One of the most popular password with \"1\" at the end"
    }
    func getState() -> State {
        return .incorrectPassword
    }
}


// MARK: - The Results Handlers Class
class ResultsHandlersData {
    
    private enum resultTypes {
        case correctResult
        case incorrectUserNameResult
        case incorrectPasswordResult
    }
    
    var ofAuthorization: AuthorizationsResult!
    
    //init with TextFields analysis
    init(userNameTF enteredUserName: String?, passwordTF enteredPassword: String?) {
        
        switch resultHandler(enteredUserName: enteredUserName, enteredPassword: enteredPassword) {
            
        case .correctResult:
            self.ofAuthorization = CorrectData()
        case .incorrectUserNameResult:
            self.ofAuthorization = IncorrectUserName()
        case .incorrectPasswordResult:
            self.ofAuthorization = IncorrectPassword()
        }
    }
    
    // init without TextFields analysis
    init(state: State) {
        switch state {
        case .correctData:
            self.ofAuthorization = CorrectData()
        case .incorrectUserName:
            self.ofAuthorization = FoggotUserName()
        case .incorrectPassword:
            self.ofAuthorization = FoggotPassword()
        }
    }

    private func resultHandler(enteredUserName: String?, enteredPassword: String?) -> resultTypes {
        if enteredUserName != userName {
            return .incorrectUserNameResult
        } else if enteredPassword != password {
            return .incorrectPasswordResult
        } else {
            return .correctResult
        }
    }
}

