//
//  FirestoreUserProfileRepository.swift
//  Bible Buddy
//
//  Created by jag on 02.06.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class FirestoreUserProfileRepository: BaseUserProfileRepository, UserProfileRepository, ObservableObject {
    
    var db = Firestore.firestore()
    var userId: String
    
    func addUserProfile(_ profile: UserProfile) {
        //
    }
    
    func updateUserProfile(_ profile: UserProfile) {
        //
    }
    
    func removeUserProfile(_ profile: UserProfile) {
        //
    }
    
    func getUserProfileById() {
        if(userId != "") {
            //            db.collection("users").document(userId).getDocument { (document, error) in
            //                let result = Result {
            //                    try document?.data(as: UserProfile.self)
            //                }
            //                switch result {
            //                case .success(let p):
            //                    if let p = p {
            //                        self.currentUserProfile = p
            //                    }
            //
            //                case .failure(let error):
            //                    print(error)
            //
            //                }
            //            }
            
            
            db.collection("users").document(userId)
                .addSnapshotListener { documentSnapshot, error in
                    guard let document = documentSnapshot else {
                        print("Error fetching document: \(error!)")
                        return
                    }
                    guard let data = document.data() else {
                        print("Document data was empty.")
                        return
                    }
                    print("Current data: \(data)")
                    let result = Result {
                        try document.data(as: UserProfile.self)
                    }
                    switch result {
                    case .success(let p):
                        if let p = p {
                            self.currentUserProfile = p
                        }
                        
                    case .failure(let error):
                        print(error)
                        
                    }
            }
        }
        
    }
    
    
    init(userId: String) {
        self.userId = userId
        super.init()
        getUserProfileById()
        
    }
    
    func loadData() {
        //
    }
}
