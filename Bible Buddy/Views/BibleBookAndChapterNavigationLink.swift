//
//  BibleBookAndChapterNavigationLink.swift
//  Bible Buddy
//
//  Created by admin on 21.06.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import SwiftUI

struct BibleBookAndChapterNavigationLink<Content: View>: View {
    
    var destinationView: Content
    
    var text: String
    
    init(destinationView: Content, text: String) {
        self.destinationView = destinationView
        self.text = text
    }
    
    var body: some View {
        
        NavigationLink(destination: destinationView) {
            Text(text)
                .frame(minWidth: 0, maxWidth: .infinity)
                .frame(height: 40)
                .font(.system(size: 13, weight: .bold))
                .foregroundColor(.black)
                .background(Color(#colorLiteral(red: 0.9198423028, green: 0.9198423028, blue: 0.9198423028, alpha: 1)))
                .cornerRadius(5)
                .padding(10)
        }
    }
}
