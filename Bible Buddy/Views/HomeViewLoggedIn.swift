//
//  HomeView.swift
//  Bible Buddy
//
//  Created by admin on 16.05.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import SwiftUI

struct HomeViewLoggedIn: View {
    @EnvironmentObject var session: SessionStore
    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0.4620226622, green: 0.8382837176, blue: 1, alpha: 0.22)).edgesIgnoringSafeArea(.all)
            VStack {
                WelcomeTextView()
                NavigationLink(destination: Chat().environmentObject(MainObservable())) {
                    Text("ChatRoom")
                }

                Spacer()
                Carousel()
                Spacer()
                HStack {
                    Button(action: session.signOut) {
                        Text("Logout")
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .frame(height: 50)
                            .foregroundColor(.black)
                            .font(.system(size: 13, weight: .bold))
                            .background(Color(#colorLiteral(red: 0.9198423028, green: 0.9198423028, blue: 0.9198423028, alpha: 1)))
                            .cornerRadius(5)
                    }.padding()
                }
            }
        }
    }
}

struct HomeViewLoggedIn_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewLoggedIn()
    }
}
