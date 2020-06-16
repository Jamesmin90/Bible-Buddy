//
//  BibleChaptersContentView.swift
//  Bible Buddy
//
//  Created by admin on 15.06.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import SwiftUI

struct BibleChaptersContentView: View {
    
    var chapters: Chapters
    
    var body: some View {
        
        VStack {
            
            if (chapters.data.count == 0) {
                
                        LoadingView()
                
                
            } else {
                
                TextMessage(textMessage: "Welches Kapitel möchten Sie lesen?")
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack {
                        
                        ForEach(chapters.data, id: \.id) { chapter in
                            
                            Text(chapter.reference)
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .frame(height: 40)
                                .font(.system(size: 13, weight: .bold))
                                .foregroundColor(.black)
                                .background(Color(#colorLiteral(red: 0.9198423028, green: 0.9198423028, blue: 0.9198423028, alpha: 1)))
                                .padding(10)
                                .padding(.horizontal, 10)
                        }
                    }
                }
            }
        }.navigationBarTitle("Kapitel")
            .padding(.horizontal)
            .background(Color("basicBackgroundColor")
                .edgesIgnoringSafeArea(.all))
    }
}
