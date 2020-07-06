//
//  SignupDescription.swift
//  Bible Buddy
//
//  Created by admin on 06.07.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//


import SwiftUI

struct SignupDescription: View {
    var url : String
    var height: CGFloat
    var body: some View {
        NavigationLink(destination: WebView(url: self.url)){
            
            Text("Klicken Sie hier, um sich anzumelden")
            //.font(.headline)
            .foregroundColor(.blue)
            .frame(minWidth: 0, maxWidth: .infinity)
            .frame(height: self.height)
            .padding(.vertical, 10)
            //.background(Color.gray.opacity(0.5))
            //.cornerRadius(10)
        }
       
        
    }
}
