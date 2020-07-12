//
//  Note.swift
//  Bible Buddy
//
//  Created by Jannis Gutleben on 06.07.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Note: Codable, Identifiable {
    @DocumentID var id: String?
    var userID: String
    var chapterRef: String
    var noteText: String
    @ServerTimestamp var createdTime: Timestamp?
}
