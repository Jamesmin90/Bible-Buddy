//
//  LogInButton.swift
//  Bible Buddy
//
//  Created by admin on 15.05.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import SwiftUI

struct LogInButton: View {
    
    var buttonText: String
    
    var body: some View {
        
        NavigationLink(destination: EventsView()) {
            Text(buttonText).foregroundColor(.black)
                .padding(20)
                .background(Color.white)
                .cornerRadius(10)
        }
    }
}

struct LogInButton_Previews: PreviewProvider {
    static var previews: some View {
        LogInButton(buttonText: "Login")
    }
}
