//
//  HomeView.swift
//  Bible Buddy
//
//  Created by admin on 16.05.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0.4620226622, green: 0.8382837176, blue: 1, alpha: 0.22)).edgesIgnoringSafeArea(.all)
            VStack {
                WelcomeTextView()
                    .padding(.top, 60)
                Spacer()
                Carousel()
                Spacer()
                HStack {
                    LogInButton(buttonText: "Register")
                        .padding()
                    Spacer()
                    LogInButton(buttonText: "Login")
                        .padding()
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
