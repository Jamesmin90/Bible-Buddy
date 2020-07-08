//
//  BookmarkFirestore.swift
//  Bible Buddy
//
//  Created by admin on 07.07.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore

class BookmarkFirestore: ObservableObject {
    
    @Published var error: String = ""
    @Published var bookmark: String = ""
    
    var errorMessage: String = "Es ist leider etwas schief gelaufen. Bitte versuchen Sie es später noch einmal."
    
    func getBookmarkOfUser(){
        
        let db = Firestore.firestore()
        
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        db.collection("users").document(uid).getDocument{ (document, error) in
            
            let result = Result {
                try document?.data(as: UserProfile.self)
            }
            
            switch result {
            case .success(let user):
                if let user = user {
                    self.bookmark = user.bookmark
                } else {
                    print("Document does not exist")
                }
            case .failure(let error):
                print("Error decoding user: \(error)")
            }
        }
    }
    
    func updateBookMarkOfUser(bookmark: String) {
        
        let db = Firestore.firestore()
        
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        db.collection("users").document(uid).setData(["bookmark" : bookmark], merge: true) { err in
            if err != nil {
                self.error = self.errorMessage
            }
        }
    }
}
