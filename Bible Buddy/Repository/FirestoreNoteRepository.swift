//
//  FirestoreNoteRepository.swift
//  Bible Buddy
//
//  Created by jag on 06.07.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class FirestoreNoteRepository: BaseNoteRepository, NoteRepository, ObservableObject {
    
    func addNote(_ note: Note) {
        do {
            let _ = try db.collection("notes").addDocument(from: note)
        }
        catch {
            print("Error while storing note to firestore.")
        }
    }
    
    
    var db = Firestore.firestore()
    var userId: String
    var chapterRef = ""
    
    init(userId: String) {
        self.userId = userId
        super.init()
        loadData()
    }
    
    init(userId: String, chapterRef: String) {
        self.userId = userId
        self.chapterRef = chapterRef
        super.init()
        loadData()
    }
    
    private func loadData() {
        if (self.chapterRef == "") {
            db.collection("notes").whereField("userID", isEqualTo: self.userId).order(by: "createdTime").addSnapshotListener { (querySnapshot, error) in
                if let querySnapshot = querySnapshot {
                    self.notes = querySnapshot.documents.compactMap { document -> Note? in
                        try? document.data(as: Note.self)
                    }
                }
            }
        }
        else {
            print("ChapterRef: " + self.chapterRef + "!")
            db.collection("notes").whereField("userID", isEqualTo: self.userId).whereField("chapterRef", isEqualTo: self.chapterRef).order(by: "createdTime").addSnapshotListener { (querySnapshot, error) in
                if let querySnapshot = querySnapshot {
                    self.notes = querySnapshot.documents.compactMap { document -> Note? in
                        try? document.data(as: Note.self)
                    }
                }
            }
        }
    }
}
