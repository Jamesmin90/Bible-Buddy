//
//  BibleSearchResult.swift
//  Bible Buddy
//
//  Created by Clara Schönberger on 02.07.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import Foundation

struct BibleSearchResult: Codable {
      let query: String?
      let data: BibleSearchResultData
      let meta: BibleSearchResultMeta
    }
    
struct BibleSearchResultData: Codable {
    let query: String
    var limit = 0
    var offset = 0
    var total = 0
    let verses: [BibleSearchResultVerses]
    let passages: [BibleSearchResultPassage]?
}

struct BibleSearchResultVerses: Codable {
    let id: String
    let orgId: String
    let bibleId: String
    let bookId: String
    let chapterId: String
    let text: String
    let reference: String
}

struct BibleSearchResultPassage: Codable {
    let id: String
    let bibleId: String
    let orgId: String
    let content: String
    let reference: String
    let copyright: String
}

struct BibleSearchResultMeta: Codable {
    let fums: String
    let fumsId: String
    let fumsJsInclude: String
    let fumsJs: String
    let fumsNoScript: String
}
