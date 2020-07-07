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
    
    var errorMessage: String = "Es ist leider etwas schief gelaufen. Bitte versuchen Sie es später noch einmal.FIRESTORE"
    
    func getBookmarkOfUser(){
        
        let db = Firestore.firestore()
        
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        db.collection("users").document(uid).getDocument{ (document, error) in
            
            if error != nil {
                self.error = self.errorMessage
            }
            else {
                
                if document?.exists != nil && document!.exists {
                    
                    let documentData = document?.data()
                    
                    guard let bookmark = documentData?["bookmark"] else {
                        return
                    }
                    
                    self.bookmark = bookmark as! String
                    
                }
                else {
                    self.error = self.errorMessage
                }
            }
        }
    }
    
    func updateBookMarkOfUser(bookmark: String) {
        
        let db = Firestore.firestore()
        
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        db.collection("users").document(uid).setData(["bookmark" : bookmark], merge: true)
    }
}
