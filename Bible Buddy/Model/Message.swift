//
//  Message.swift
//  Bible Buddy
//
//  Created by admin on 17.05.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import SwiftUI

struct Message: Identifiable {
    var id: String
    var sender: String
    var msg: String
    @State var image: Data
}
