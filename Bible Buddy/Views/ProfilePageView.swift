//
//  ProfilePageView.swift
//  Bible Buddy
//
//  Created by Clara Schönberger on 29.05.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import SwiftUI

struct ProfilePageView: View {
    
    @State var creation = false

    
    var body: some View {
        
        VStack {
            
            TextMessage(textMessage: "Was möchten Sie gerne in Ihrem Profil machen?")
            
            ProfileMenuItem(image: "password", profileItemTitle: "Passwort ändern", destinationView: UpdateEmailPasswordView(continueText: "Geben Sie bitte Ihr neues Passwort ein", buttonText: "Passwort ändern"))
            
            ProfileMenuItem(image: "mail", profileItemTitle: "Email-Adresse ändern", destinationView: UpdateEmailPasswordView(continueText: "Geben Sie bitte Ihre neue Email ein", buttonText: "Email-Adresse ändern"))
            
            ProfileMenuItem(image: "trash", profileItemTitle: "Profil löschen", destinationView: DeleteProfileView())
            
            Spacer()
            
        }
        .padding(.horizontal)
        .background(Color("basicBackgroundColor")
        .edgesIgnoringSafeArea(.all))
        .navigationBarTitle("Profil", displayMode: .inline)
    }
}
