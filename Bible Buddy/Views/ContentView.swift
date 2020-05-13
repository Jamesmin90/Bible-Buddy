//
//  ContentView.swift
//  ChristeninMuenchen
//
//  Created by admin on 11.05.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationView {
            VStack{
                Divider()
                Spacer()
                mainNavi()
                Spacer()
                HStack(spacing: 220){
                        Text("Reigster")
                            .font(.system(size: 25, weight: .bold))
                            .padding(10.0)
                        Text("Login")
                            .font(.system(size: 25, weight: .bold))
                            .padding(5.0)
                    }
            }
            .navigationBarItems(leading:
                HStack(spacing: 190){
                    Text("Home")
                        .font(.system(size: 35, weight: .bold))
                        .padding(5.0)
                    Image("people").resizable()
                        .frame(width: 80.0, height: 50.0)
                        .cornerRadius(8.0)
                        .padding(5.0)
            })
        }
    
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


