//
//  BibleContentOverview.swift
//  Bible Buddy
//
//  Created by admin on 15.06.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import SwiftUI

struct BibleBookTableOfContents: View {
    
    @ObservedObject var bible = Bible()
    
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
                TextMessage(textMessage: "Wählen Sie bitte ein Buch aus der Bibel, welches Sie lesen möchten.")
                
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
        .onAppear() { self.bible.getDataFromUrl(urlEndpoint: "books", type: Books.self) }
    }
}
