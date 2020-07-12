//
//  BibleSearchResultsItem.swift
//  Bible Buddy
//
//  Created by Clara Schönberger on 03.07.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import SwiftUI

struct BibleSearchResultsItem: View {
    
    var versesData: BibleSearchResultVerses
    
    var body: some View {
        
        HStack {
            VStack {
                
                HStack {
                    Text("Referenz: ")
                    Text(versesData.reference)
                        .padding(10)
                        .font(.system(size:13))
                        .background(Color.white)
                        .cornerRadius(10)
                    Spacer()
                }
                
                HStack {
                    Text("Text:          ")
                    Text(versesData.text)
                        .padding(10)
                        .font(.system(size:13))
                        .background(Color.white)
                        .cornerRadius(10).lineLimit(5)
                    Spacer()
                }.padding(.top, 10)
                
                HStack {
                    NavigationLink(destination: BibleChapterContent(chapterId: versesData.chapterId)) {
                        Text("Kapitel lesen")
                            .padding(10)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .font(.system(size: 13, weight: .bold))
                            .foregroundColor(.black)
                            .background(Color(#colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)))
                            .cornerRadius(10)
                    }
                }.padding(.top, 20)
                
            }.padding()
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .font(.system(size: 13, weight: .bold))
        .foregroundColor(.black)
        .background(Color("basicForegroundColor"))
        .cornerRadius(5)
        .padding(10)
    }
}
