//
//  SideMenuView.swift
//  Bible Buddy
//
//  Created by admin on 15.05.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import SwiftUI

struct SideMenuView: View {
    
    @EnvironmentObject var session: SessionStore
    
    @Binding var isActive: Bool
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            SideMenuItem(image: "bible", title: "Bibel", destinationView: BibleBookTableOfContents())
            SideMenuItem(image: "blog", title: "Blog", destinationView: BlogView())
            SideMenuItem(image: "event", title: "Events", destinationView: EventsView())
            
            if (session.session != nil) {
                SideMenuItem(image: "chat", title: "Chat", destinationView: Chat().environmentObject(MainObservable()))
                SideMenuItem(image: "notes", title: "Notizen", destinationView: TestView())
                SideMenuItemIsActive(image: "profile", title: "Profil", destinationView: ProfilePageView(), isActive: self.$isActive)
            }
            
            Spacer()
            
        }
        .padding(20)
        .frame(minWidth: 150)
        .background(Color.white.edgesIgnoringSafeArea(.bottom))
    }
}
