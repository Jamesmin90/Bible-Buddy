//
//  BibleBooks.swift
//  Bible Buddy
//
//  Created by admin on 15.06.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import Foundation

struct Books: Codable {
    let data: [DataTest]
}

struct DataTest: Codable {
    let id: String
    let bibleId: String
    let abbreviation: String
    let name: String
    let nameLong: String
    let chapters: [Chapter]?
}

struct Chapter: Codable {
    let id: String
    let bibleId: String
    let number: String
    let bookId: String
    let reference: String
}
