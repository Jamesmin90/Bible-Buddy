//
//  SideMenuItem.swift
//  Bible Buddy
//
//  Created by admin on 15.05.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import SwiftUI

struct SideMenuItem: View {
    
    var image: String
    var title: String
    
    var body: some View {
        
        NavigationLink(destination: EventsView()) {
            
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

struct SideMenuItem_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuItem(image: "bible", title: "Bibel")
    }
}
