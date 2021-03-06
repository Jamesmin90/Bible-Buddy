//
//  BlogPost.swift
//  Bible Buddy
//
//  Created by Jannis Gutleben on 28.05.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct BlogPost: Codable, Identifiable {
    @DocumentID var id: String? 
    var title: String
    var body: String
    var userName: String
    var userID: String
    var category: String
    var imageURL: String
    @ServerTimestamp var createdTime: Timestamp?
}
