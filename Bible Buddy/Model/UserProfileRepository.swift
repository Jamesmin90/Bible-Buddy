//
//  UserProfileRepository.swift
//  Bible Buddy
//
//  Created by jag on 02.06.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import Foundation

class BaseUserProfileRepository {
    @Published var currentUserProfile = UserProfile(id: "", name: "", surName: "", userName: "", profilePictureID: "", profilePictureURL: "")
}

protocol UserProfileRepository: BaseUserProfileRepository {
    func addUserProfile(_ profile: UserProfile)
  func removeUserProfile(_ profile: UserProfile)
  func updateUserProfile(_ profile: UserProfile)
}
