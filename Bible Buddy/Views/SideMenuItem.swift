//
//  SideMenuItem.swift
//  Bible Buddy
//
//  Created by Clara Schönberger on 15.05.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import SwiftUI

struct SideMenuItem<Content: View>: View {
    
    var image: String
    var title: String
    var destinationView: Content
    
    init(image: String, title: String, destinationView: Content) {
        self.image = image
        self.title = title
        self.destinationView = destinationView
    }
    
    var body: some View {
        
        NavigationLink(destination: destinationView) {
            
            HStack() {
                
                Image(image)
                    .renderingMode(.original)
                    .resizable()
                    .frame(width: 50, height: 50)
                
                Text(title)
                    .font(.system(size: 25))
                    .foregroundColor(.black)
                
            }.padding(10)
        }
    }
}
