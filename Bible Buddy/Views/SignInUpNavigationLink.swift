//
//  LogInButton.swift
//  Bible Buddy
//
//  Created by admin on 15.05.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import SwiftUI

struct SignInUpNavigationLink<Content: View>: View {
    
    var destinationView: Content
    var buttonText: String
    
    init(destinationView: Content, buttonText: String) {
        self.destinationView = destinationView
        self.buttonText = buttonText
    }
    
    var body: some View {
        NavigationLink(destination: destinationView) {
            Text(buttonText)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity)
                .padding(20)
                .background(Color.white)
                .cornerRadius(10)
        }.padding()
    }
}

struct SignInUpNavigationLink_Previews: PreviewProvider {
    static var previews: some View {
        SignInUpNavigationLink(destinationView: TestView(), buttonText: "Anmelden")
    }
}
