//
//  SideMenuView.swift
//  Bible Buddy
//
//  Created by admin on 15.05.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import SwiftUI

struct SideMenuView: View {
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            SideMenuItem(image: "bible", title: "Bibel")
            SideMenuItem(image: "blog", title: "Blog")
            SideMenuItem(image: "event", title: "Events")
            
            Spacer()
            
        }.padding(20)
         .frame(minWidth: 150)
         .background(Color.white.edgesIgnoringSafeArea(.bottom))
         
         
    }
}

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView()
    }
}
