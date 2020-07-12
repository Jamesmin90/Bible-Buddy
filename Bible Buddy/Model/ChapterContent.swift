//
//  ChapterContent.swift
//  Bible Buddy
//
//  Created by Clara Schönberger on 16.06.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import Foundation

struct ChapterContent: Codable {
    let data: ChapterContentData
    let meta: ChapterContentMeta
}

struct ChapterContentData: Codable {
    let id: String
    let bibleId: String
    let number: String
    let bookId: String
    let content: String
    let reference: String
    let copyright: String
    let next: ChapterPreviousNext?
    let previous: ChapterPreviousNext?
}

struct ChapterPreviousNext: Codable {
    let id: String
    let bookId: String
    let number: String
}

struct ChapterContentMeta: Codable {
    let fums: String
    let fumsId: String
    let fumsJsInclude: String
    let fumsJs: String
    let fumsNoScript: String
}
