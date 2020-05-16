//
//  ContentView.swift
//  ChristeninMuenchen
//
//  Created by admin on 11.05.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var showSideMenu = false
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                
                HomeView()
                
                GeometryReader { _ in
                    HStack {
                        SideMenuView()
                            .offset(x: self.showSideMenu ? 0 : -UIScreen.main.bounds.width)
                            .animation(.interactiveSpring(response: 0.6, dampingFraction: 0.6, blendDuration: 0.6))
                        Spacer()
                    }
                }.background(Color.black.opacity(self.showSideMenu ? 0.5 : 0).edgesIgnoringSafeArea(.bottom))
                
            }.navigationBarTitle("Home", displayMode: .inline)
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
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


