//
//  WelcomeTextView.swift
//  Bible Buddy
//
//  Created by TextMessage on 15.05.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import SwiftUI

struct WelcomeTextView: View {
    var body: some View {
        VStack {
            Text("Willkommen Buddy!")
                .padding(5)
                .font(.system(size:35))
                .background(Color.white)
                .cornerRadius(10)
        }.padding(.top, 60)
    }
}

struct WelcomeTextView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeTextView()
    }
}
