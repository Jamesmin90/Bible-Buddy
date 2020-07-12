//
//  BibleBooks.swift
//  Bible Buddy
//
//  Created by Clara Schönberger on 15.06.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import Foundation

struct Books: Codable {
    let data: [BooksData]
}

struct BooksData: Codable {
    let id: String
    let bibleId: String
    let abbreviation: String
    let name: String
    let nameLong: String
    let chapters: [ChapterData]?
}
