//
//  BibleChaptersContentView.swift
//  Bible Buddy
//
//  Created by Clara Schönberger on 15.06.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import SwiftUI

struct BibleChapterTableOfContents: View {
    
    @ObservedObject var bible = Bible()
    
    var bookId: String
    
    var body: some View {
        
        VStack {
            
            if(bible.error != "") {
                Spacer()
                ErrorText(errorText: bible.error)
                Spacer()
            }
                
            else if (bible.chapters.data.count == 0) {
                LoadingView()
            }
                
            else {
                TextMessage(textMessage: "Welches Kapitel möchten Sie lesen?")
                
                ScrollView(.vertical, showsIndicators: false) {
                    ForEach(bible.chapters.data, id: \.id) { chapter in
                        BibleBookAndChapterNavigationLink(destinationView: BibleChapterContent(chapterId: chapter.id), text: chapter.reference)
                    }
                }
            }
        }
        .navigationBarTitle("Kapitel")
        .padding(.horizontal)
        .background(Color("basicBackgroundColor")
        .edgesIgnoringSafeArea(.all))
        .onAppear() { self.getBibleChapters() }
    }
    
    func getBibleChapters() {
        let urlCombined = URLComponents(string: "https://api.scripture.api.bible/v1/bibles/542b32484b6e38c2-01/books/\(self.bookId)/chapters")
        
        self.bible.getDataFromUrl(url: urlCombined!, type: ChaptersList.self)
    }
}
