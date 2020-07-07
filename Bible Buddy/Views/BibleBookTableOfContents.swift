//
//  BibleContentOverview.swift
//  Bible Buddy
//
//  Created by admin on 15.06.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct BibleBookTableOfContents: View {
    
    @ObservedObject var bible = Bible()
    
    @State var lookUp: String = ""
    
    @State var bookmark: String = ""
    
    var body: some View {
        
        VStack {
            
            if(bible.error != "") {
                Spacer()
                ErrorText(errorText: bible.error)
                Spacer()
            }
                
            else if (bible.books.data.count == 0) {
                LoadingView()
            }
                
            else {
                if (self.bookmark != "") {
                    BibleBookAndChapterNavigationLink(destinationView: BibleChapterContent(chapterId: self.bookmark), text: "Lesezeichen öffnen")
                }
                
                TextMessage(textMessage: "Wählen Sie bitte ein Buch aus der Bibel, welches Sie lesen möchten.")
                
                BibleSearchField(lookUp: self.$lookUp)

                Spacer()
                
                ScrollView(.vertical, showsIndicators: false) {
                    ForEach(bible.books.data, id: \.id) { book in
                        BibleBookAndChapterNavigationLink(destinationView: BibleChapterTableOfContents(bookId: book.id), text: book.nameLong)
                    }
                }
            }
        }
        .navigationBarTitle("Bücher")
        .padding(.horizontal)
        .background(Color("basicBackgroundColor")
        .edgesIgnoringSafeArea(.all))
        .onAppear() { self.getBibleBooks()
            self.updateRecents()
        }
    }
    
    func getBibleBooks() {
        let urlCombined = URLComponents(string: "https://api.scripture.api.bible/v1/bibles/542b32484b6e38c2-01/books")
        
        self.bible.getDataFromUrl(url: urlCombined!, type: Books.self)
    }
    
func updateRecents(){

    let db = Firestore.firestore()

    guard let uid = Auth.auth().currentUser?.uid else {
        print("User not found")
        return
    }

    db.collection("users").document(uid).getDocument{ (document, error) in

        if error == nil {

            if document?.exists != nil && document!.exists {

                let documentData = document?.data()

                guard let bookmark = documentData?["bookmark"] else {
                    return
                }
                self.bookmark = bookmark as! String
            }
        }
        else {
            print("Error getDocument")
        }
    }
}
}
