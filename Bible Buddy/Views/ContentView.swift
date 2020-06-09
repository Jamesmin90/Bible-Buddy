//
//  ContentView.swift
//  ChristeninMuenchen
//
//  Created by admin on 11.05.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var session: SessionStore
    
    @State var showSideMenu = false
    
    @State var isSignInViewActive: Bool = false
    @State var isProfilePageViewActive: Bool = false
    
    var body: some View {
        
        Group {
            NavigationView {
                
                ZStack {

                    HomeView(isActive: self.$isSignInViewActive)
                    
                    GeometryReader { _ in
                        HStack {
                            SideMenuView(isActive: self.$isProfilePageViewActive)
                                .offset(x: self.showSideMenu ? 0 : -UIScreen.main.bounds.width)
                                .animation(.interactiveSpring(response: 0.6, dampingFraction: 0.6, blendDuration: 0.6))
                            Spacer()
                        }
                    }.background(Color.black.opacity(self.showSideMenu ? 0.5 : 0).edgesIgnoringSafeArea(.bottom))
                    
                }.onReceive(self.session.$moveToRootView) { moveToRootView in
                    if moveToRootView {
                        self.isSignInViewActive = false
                        self.isProfilePageViewActive = false
                        self.session.moveToRootView = false
                    }
                }
                .navigationBarTitle("Home", displayMode: .inline)
                .navigationBarItems(leading: Button(action: {
                    self.showSideMenu.toggle()}) {
                        if (self.showSideMenu) {
                            Image(systemName: "arrow.left").font(.body)
                        }
                        else {
                            Image(systemName: "line.horizontal.3")
                        }
                    }
                )
            }
        }.onAppear(perform: session.listen)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/

    }
}
