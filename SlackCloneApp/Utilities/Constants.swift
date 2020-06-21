//
//  Constants.swift
//  SlackCloneApp
//
//  Created by Burak Tunc on 19.06.2020.
//  Copyright © 2020 Burak Tunç. All rights reserved.
//

import Foundation


// type alias is simply renaming the type (closure type)
typealias CompletionHandler = (_ Success: Bool) -> ()


// MARK: URL Constants
let BASE_URL = "https://swiftchatappsocket.herokuapp.com/v1/"
let REGISTER_URL = "\(BASE_URL)account/register"
let LOGIN_URL = "\(BASE_URL)account/login"
let CREATE_USER_URL = "\(BASE_URL)user/add"

// MARK: Segues

let TO_LOGIN = "toLogin"
let TO_CREATE_ACCOUNT = "toCreateAccount"
let UNWIND_TO_CHANNEL = "unwindToChannel"
let TO_AVATAR_PICKER = "toAvatarPicker"


// MARK: UserDefaults
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"


// MARK: Headers
let REQUEST_HEADER = [
    "Content-Type": "application/json; charset=utf-8"
]



