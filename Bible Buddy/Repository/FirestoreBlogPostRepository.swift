//
//  File.swift
//  Bible Buddy
//
//  Created by jag on 28.05.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class FirestoreBlogPostRepository: BaseBlogPostRepository, BlogPostRepository, ObservableObject {
    func addBlogPost(_ blogpost: BlogPost) {
        do {
            let _ = try db.collection("blogposts").addDocument(from: blogpost)
        }
        catch {
            print("Error while storing post to firestore.")	
        }
    }
    
    func removeBlogPost(_ blogpost: BlogPost) {
        //
    }
    
    func updateBlogPost(_ blogpost: BlogPost) {
        //
    }
    
  var db = Firestore.firestore()
  
  override init() {
    super.init()
    loadData()
  }
  
  private func loadData() {
    db.collection("blogposts").order(by: "createdTime").addSnapshotListener { (querySnapshot, error) in
      if let querySnapshot = querySnapshot {
        self.blogposts = querySnapshot.documents.compactMap { document -> BlogPost? in
          try? document.data(as: BlogPost.self)
        }
      }
    }
  }
}
