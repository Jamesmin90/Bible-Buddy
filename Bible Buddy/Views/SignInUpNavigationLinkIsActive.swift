//
//  SignInUpNavigationLinkIsActive.swift
//  Bible Buddy
//
//  Created by admin on 06.06.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import SwiftUI

struct SignInUpNavigationLinkIsActive<Content: View>: View {
    
    @Binding var isActive: Bool
    
    var destinationView: Content
    var buttonText: String
    
    init(destinationView: Content, buttonText: String, isActive: Binding<Bool>) {
        self.destinationView = destinationView
        self.buttonText = buttonText
        self._isActive = isActive
    }
    
    var body: some View {
        NavigationLink(destination: destinationView, isActive: self.$isActive) {
            Text(buttonText)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity)
                .padding(20)
                .background(Color.white)
                .cornerRadius(10)
        }.isDetailLink(false).padding()
    }
}
