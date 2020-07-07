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
            BasicTextField(text: text)
        }
    }
}
