//
//  Blog.swift
//  ChristeninMuenchen
//
//  Created by admin on 12.05.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import SwiftUI

struct BlogView: View {
    var body: some View {
        NavigationView {
            VStack(alignment: .center){
                Text("Blog")
                
            }
            .navigationBarItems(leading:
                HStack(spacing: 220){
                    Text("Blog")
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

struct BlogView_Previews: PreviewProvider {
    static var previews: some View {
        BlogView()
    }
}
