//
//  BibleChaptersContentView.swift
//  Bible Buddy
//
//  Created by admin on 15.06.20.
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
                        BibleBookAndChapterNavigationLink(destinationView: BibleChapterContent(chapterData: chapter), text: chapter.reference)
                    }
                }
            }
        }
        .navigationBarTitle("Kapitel")
        .padding(.horizontal)
        .background(Color("basicBackgroundColor")
        .edgesIgnoringSafeArea(.all))
        .onAppear() { self.bible.getDataFromUrl(urlEndpoint: "books/\(self.bookId)/chapters", type: ChaptersList.self) }
    }
}
