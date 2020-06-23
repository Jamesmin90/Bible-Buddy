//
//  ChapterData.swift
//  Bible Buddy
//
//  Created by admin on 21.06.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import Foundation

struct ChapterData: Codable {
    let id: String
    let bibleId: String
    let number: String
    let bookId: String
    let reference: String
}
