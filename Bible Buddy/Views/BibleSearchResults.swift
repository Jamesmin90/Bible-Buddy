//
//  BibleSearchResults.swift
//  Bible Buddy
//
//  Created by TextMessage on 02.07.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import SwiftUI

struct BibleSearchResults: View {
    
    @ObservedObject var bible = Bible()
    
    var lookUp: String
    
    var body: some View {
        
        VStack {
            
            if(bible.error != "") {
                Spacer()
                ErrorText(errorText: bible.error)
                Spacer()
            }
                
            else if (bible.searchResult?.data == nil) {
                LoadingView()
            }
                
            else if (bible.searchResult?.data.verses.count == 0) {
                VStack {
                    Spacer()
                    ErrorText(errorText: "Es konnte leider kein Ergebnis für Ihre Eingabe gefunden werden.")
                    Spacer()
                }
            }
                
            else {
                TextMessage(textMessage: "Für Ihre Eingabe stehen folgende Suchergebnisse zur Auswahl:")
                
                ScrollView(.vertical, showsIndicators: false) {
                    ForEach(bible.searchResult!.data.verses, id: \.id) { result in
                        BibleSearchResultsItem(versesData: result)
                    }
                }
            }
        }
        .navigationBarTitle("Suchergebnisse")
        .padding(.horizontal)
        .background(Color("basicBackgroundColor")
        .edgesIgnoringSafeArea(.all))
        .onAppear() { self.bibleLookUp() }
    }
    
    func bibleLookUp() {
        var urlCombined = URLComponents(string: "https://api.scripture.api.bible/v1/bibles/542b32484b6e38c2-01/search")
        
        urlCombined?.queryItems = [
            URLQueryItem(name: "query", value: lookUp),
            URLQueryItem(name: "limit", value: "1000")
        ]
        
        self.bible.getDataFromUrl(url: urlCombined!, type: BibleSearchResult.self)
    }
}
