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
    
    @ObservedObject var bookmarkFirestore = BookmarkFirestore()
    
    @State var lookUp: String = ""
    
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
        .navigationBarItems(trailing: (self.bookmarkFirestore.bookmark != "") ? AnyView(self.goToBookmark) : AnyView(EmptyView()))
        .padding(.horizontal)
        .background(Color("basicBackgroundColor")
        .edgesIgnoringSafeArea(.all))
        .onAppear() {
            self.getBibleBooks()
            self.bookmarkFirestore.getBookmarkOfUser()
        }
    }
    
    var goToBookmark: some View {
        NavigationLink(destination: BibleChapterContent(chapterId: self.bookmarkFirestore.bookmark)) {
            Image("bookmark")
                .renderingMode(.original)
                .resizable()
                .frame(width: 20, height: 20)
                .padding(.horizontal, 20)
        }
    }
    
    func getBibleBooks() {
        let urlCombined = URLComponents(string: "https://api.scripture.api.bible/v1/bibles/542b32484b6e38c2-01/books")
        
        self.bible.getDataFromUrl(url: urlCombined!, type: Books.self)
    }
}
