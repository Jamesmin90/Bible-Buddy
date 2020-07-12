//
//  UserProfileVM.swift
//  Bible Buddy
//
//  Created by Jannis Gutleben on 02.06.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import Foundation
import Combine
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class UserProfileVM: ObservableObject {

    @Published var profile: UserProfile = UserProfile(id: "", vorName: "", surName: "", userName: "", pic: "", bookmark: "")
    @Published var profilepicture: Data = Data()
    
    var repository: FirestoreUserProfileRepository
    //private var urlimage: URLImage = URLImage("")
    private var cancellables = Set<AnyCancellable>()
    
    
    init(userID: String) {
        self.repository = FirestoreUserProfileRepository(userId: userID)
        //getUserProfileById(userId: userID)
        
        repository.$currentUserProfile.sink { value in
            print("UserVM updated for \(value.userName)")
            self.profile = value
        }.store(in: &cancellables)
        
        $profile
            .sink { profile in
                print("Loading profile picture from URL: \(profile.pic)")
                URLImage(urlString: profile.pic).$data
                    .sink { data in
                        print("Profile picture data loaded.")
                        self.profilepicture = data
                }.store(in: &self.cancellables)
        }.store(in: &cancellables)
        

            
        
    }
    
}
