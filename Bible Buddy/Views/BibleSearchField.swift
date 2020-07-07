//
//  BibleSearchField.swift
//  Bible Buddy
//
//  Created by admin on 03.07.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import SwiftUI

struct BibleSearchField: View {
    
    @Binding var lookUp: String
    
    var body: some View {
        HStack {
            
            UserInputTextField(userInput: self.$lookUp, textFieldText: "Suche nach Text in der Bibel...").padding(.horizontal, 10)
            
            Spacer()
            
            NavigationLink(destination: BibleSearchResults(lookUp: self.lookUp)) {
                Image(systemName: "magnifyingglass.circle.fill").padding(.horizontal, 10).font(.system(size: 45)).foregroundColor(Color(#colorLiteral(red: 0.9198423028, green: 0.9198423028, blue: 0.9198423028, alpha: 1)))
            }.disabled(self.lookUp == "")
        }.padding(.bottom, 20)
    }
}
