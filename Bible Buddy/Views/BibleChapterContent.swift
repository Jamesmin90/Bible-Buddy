//
//  Bible.swift
//  ChristeninMuenchen
//
//  Created by admin on 12.05.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct BibleChapterContent: View {
    
    @ObservedObject var bible = Bible()
    
    var chapterId: String
    
    var body: some View {
        VStack {
            
            if(bible.error != "") {
                Spacer()
                ErrorText(errorText: bible.error)
                Spacer()
            }
                
            else if (bible.chapterContent?.data.content == nil || bible.chapterContent?.data.content == "") {
                LoadingView()
            }
                
            else {
                Button(action: {
                    self.update(bookmark: (self.bible.chapterContent?.data.id)!)
                }) {
                    Text("Lesezeichen hier setzen")
                }
                
                HTMLStringView(htmlContent: (bible.chapterContent?.data.content)!)
                
                HStack {
                    
                    if (self.bible.chapterContent?.data.previous?.id != nil && self.bible.chapterContent?.data.previous?.id != "") {
                        Button(action: {
                            self.getChapterContent(chapterId: (self.bible.chapterContent?.data.previous!.id)!)
                        }) {
                            BasicTextField(text: "vorheriges Kapitel")
                        }
                    }
                    
                    Spacer()
                    
                    if (self.bible.chapterContent?.data.next?.id != nil && self.bible.chapterContent?.data.next?.id != "") {
                        Button(action: {
                            self.getChapterContent(chapterId: (self.bible.chapterContent?.data.next!.id)!)
                        }) {
                            BasicTextField(text: "nächstes Kapitel")
                        }
                    }
                }.padding(.top, 5)
            }
        }
        .navigationBarTitle(self.bible.chapterContent?.data.reference ?? "")
        .padding(.horizontal)
        .background(Color("basicBackgroundColor")
        .edgesIgnoringSafeArea(.all))
        .onAppear() { self.getChapterContent(chapterId: self.chapterId) }
        .navigationBarItems(trailing: bible.chapterContent?.data.content != nil ? AnyView(self.readButton) : AnyView(EmptyView())
        )
    }
    
    func getChapterContent(chapterId: String) {
        
        let urlCombined = URLComponents(string: "https://api.scripture.api.bible/v1/bibles/542b32484b6e38c2-01/chapters/\(chapterId)")
        
        self.bible.getDataFromUrl(url: urlCombined!, type: ChapterContent.self)
    }
    
    var readButton: some View {
        NavigationLink(
            destination: SpeechTestView(synthVM: SpeechSynthVM(text: (bible.chapterContent?.data.content)!))) {
            Image(systemName: "speaker.2")
        }
    }
    
    func update(bookmark: String) {
        
        let db = Firestore.firestore()
        
        guard let uid = Auth.auth().currentUser?.uid else {
            print("User not found")
            return
        }
        
        db.collection("users").document(uid).setData(["bookmark" : bookmark], merge: true)
    }
}
