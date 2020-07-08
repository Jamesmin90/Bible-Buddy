//
//  ReferenceImage.swift
//  Bible Buddy
//
//  Created by admin on 07.07.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import SwiftUI

struct ReferenceImageItem: View {
    
    var image: String
    var madeFrom: String
    var link: String
    
    var body: some View {
        
        HStack() {
            
            Image(image)
                .renderingMode(.original)
                .resizable()
                .frame(width: 70, height: 70)
            
            VStack {
                
                HStack {
                    Text(madeFrom)
                        .font(.system(size: 16))
                        .foregroundColor(.black).padding(5)
                    Spacer()
                }
                
                
                HStack {
                    Button(action: {
                        guard let url = URL(string: self.link),
                            UIApplication.shared.canOpenURL(url) else {
                                return
                        }
                        UIApplication.shared.open(url)
                    }) {
                        Text(link)
                            .font(.system(size: 12))
                            .foregroundColor(.black)
                            .padding(5)
                    }
                    Spacer()
                }
            }
        }.padding(20).background(Color(#colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 0.3997076304))).cornerRadius(10)
    }
}

struct ReferenceImageItem_Previews: PreviewProvider {
    static var previews: some View {
        ReferenceImageItem(image: "bible", madeFrom: "Icon made by Freepik from www.flaticon.com", link: "https://www.flaticon.com/free-icon/bible_2913087?term=bible&page=1&position=9")
    }
}
