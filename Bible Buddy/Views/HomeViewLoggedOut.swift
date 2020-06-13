//
//  HomeView.swift
//  Bible Buddy
//
//  Created by admin on 16.05.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import SwiftUI


struct HomeView: View {
    
    @EnvironmentObject var session: SessionStore
    
    @Binding var isActive: Bool

    var body: some View {
        
        ZStack {
            
            Color("basicBackgroundColor").edgesIgnoringSafeArea(.all)
            
            VStack {
                
                WelcomeTextView()
                /*NavigationLink(destination: Home().environmentObject(MainObservable())) {
                    Text("ChatRoom")
                }*/
                Spacer()
                Carousel()
                Spacer()
                
                if (session.session == nil) {
                    HStack {
                        SignInUpNavigationLink(destinationView: SignInUpView(continueText: "Registrieren Sie sich bitte", buttonText: "Registrieren"), buttonText: "Registrieren")
                        
                        Spacer()
                        
                        SignInUpNavigationLinkIsActive(destinationView: SignInUpView(continueText: "Melden Sie sich bitte an", buttonText: "Anmelden"), buttonText: "Anmelden", isActive: self.$isActive)
                    }
                } else {
                    ManageUserButton(handleButton: {self.session.signOut()}, buttonText: "Abmelden").padding(.horizontal)
                }
            }
        }
    }
}


