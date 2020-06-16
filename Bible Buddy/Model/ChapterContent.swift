//
//  ChapterContent.swift
//  Bible Buddy
//
//  Created by admin on 16.06.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import Foundation

struct ChapterContent: Codable {
    let data: ChapterTestData
    let meta: ChapterTestMeta
}

struct ChapterTestData: Codable {
    let id: String
    let bibleId: String
    let number: String
    let bookId: String
    let content: String
    let reference: String
    let copyright: String
    let next: ChapterNext?
    let previous: ChapterPrevious?
}

struct ChapterNext: Codable {
    let id: String
    let bookId: String
    let number: String
}

struct ChapterPrevious: Codable {
    let id: String
    let bookId: String
    let number: String
}

struct ChapterTestMeta: Codable {
    let fums: String
    let fumsId: String
    let fumsJsInclude: String
    let fumsJs: String
    let fumsNoScript: String
}
