//
//  HomeView.swift
//  Bible Buddy
//
//  Created by admin on 16.05.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import SwiftUI

struct HomeViewLoggedOut: View {
    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0.4620226622, green: 0.8382837176, blue: 1, alpha: 0.22)).edgesIgnoringSafeArea(.all)
            VStack {
                WelcomeTextView()
                Spacer()
                Carousel()
                Spacer()
                HStack {
                    SignInUpNavigationLink(destinationView: SignInUpView(continueText: "Sign up to continue", buttonText: "Sign up"), buttonText: "Register")
                    Spacer()
                    SignInUpNavigationLink(destinationView: SignInUpView(continueText: "Sign in to continue", buttonText: "Sign in"), buttonText: "Login")
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewLoggedOut()
    }
}
