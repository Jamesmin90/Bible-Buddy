//
//  Chat.swift
//  Bible Buddy
//
//  Created by James on 07.06.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//


import SwiftUI

struct User_Chat : Identifiable, Hashable {
    
    var id : String
    var userName : String
    var pic : String
}

struct Msg : Identifiable {
    
    var id : String
    var msg : String
    var user : String
    var pic : String
}

struct Recent : Identifiable {
    
    var id : String
    var userName : String
    var pic : String
    var lastmsg : String
    var time : String
    var date : String
    var stamp : Date
}
