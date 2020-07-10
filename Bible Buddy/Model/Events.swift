//
//  Data.swift
//  Bible Buddy
//
//  Created by James on 27.05.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import SwiftUI

struct EventsPost: Codable, Identifiable{
    let id = UUID()
    var name: String
    var location: String
    var date: String
    var imageURL: String
    var description: String
    var signup: String
    var latitude: Double
    var longitude: Double
    
}





