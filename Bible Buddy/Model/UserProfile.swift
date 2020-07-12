//
//  UserProfile.swift
//  Bible Buddy
//
//  Created by Jannis Gutleben on 02.06.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct UserProfile: Codable, Identifiable {
    @DocumentID var id: String?
    var vorName: String
    var surName: String
    var userName: String
    var pic: String
    var bookmark: String
}
