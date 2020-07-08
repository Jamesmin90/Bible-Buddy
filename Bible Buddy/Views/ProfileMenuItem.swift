//
//  ProfileMenuItem.swift
//  Bible Buddy
//
//  Created by admin on 31.05.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import SwiftUI

struct ProfileMenuItem<Content: View>: View {
    
    var image: String
    var profileItemTitle: String
    var destinationView: Content
    
    init(image: String, profileItemTitle: String, destinationView: Content) {
        self.image = image
        self.profileItemTitle = profileItemTitle
        self.destinationView = destinationView
    }
    
    var body: some View {
        
        NavigationLink(destination: destinationView) {
            
            HStack() {
                
                Image(image)
                    .renderingMode(.original)
                    .resizable()
                    .frame(width: 30, height: 30)
                    .padding(.horizontal, 20)
                
                Text(profileItemTitle)
                    .font(.system(size: 13, weight: .bold))
                    .foregroundColor(.black)
                
                Spacer()
                
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .frame(height: 45)
            .background(Color("basicForegroundColor"))
            .cornerRadius(5)
            
        }.padding()
    }
}

struct ProfileMenuItem_Previews: PreviewProvider {
    static var previews: some View {
        ProfileMenuItem(image: "mail", profileItemTitle: "Update email", destinationView: TestView())
    }
}
