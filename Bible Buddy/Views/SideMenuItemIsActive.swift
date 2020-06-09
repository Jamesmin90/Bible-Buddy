//
//  SideMenuItemIsActive.swift
//  Bible Buddy
//
//  Created by admin on 06.06.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import SwiftUI

struct SideMenuItemIsActive<Content: View>: View {
    
    @Binding var isActive: Bool
    
    var image: String
    var title: String
    var destinationView: Content
    
    init(image: String, title: String, destinationView: Content, isActive: Binding<Bool>) {
        self.image = image
        self.title = title
        self.destinationView = destinationView
        self._isActive = isActive
    }
    
    var body: some View {
        
        NavigationLink(destination: destinationView, isActive: self.$isActive) {
            
            HStack() {
                
                Image(image)
                    .renderingMode(.original)
                    .resizable()
                    .frame(width: 50, height: 50)
                
                Text(title)
                    .font(.system(size: 25))
                    .foregroundColor(.black)
                
            }.padding(10)
        }.isDetailLink(false)
    }
}
