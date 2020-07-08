//
//  CarouselCard.swift
//  Bible Buddy
//
//  Created by admin on 14.05.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import SwiftUI

struct CarouselCard: View {
    
    var image: String
    var title: String
    var backgroundColorCard: Color
    var backgroundColorTitle: Color
    var shadowColorCard: Color
    
    var body: some View {
            
            VStack {
                
                Image(image)
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 165, height: 165)
                    .padding(10)
                
                
                Text(title)
                    .frame(width: 130, height: 30)
                    .foregroundColor(Color.black)
                    .background(backgroundColorTitle)
                    .cornerRadius(10)
                    
                
            }.frame(width: 220, height: 320)
             .shadow(color: shadowColorCard, radius: 30)
             .background(backgroundColorCard).cornerRadius(15)
    }
}

struct CarouselCard_Previews: PreviewProvider {
    static var previews: some View {
        CarouselCard(image: "event", title: "Events", backgroundColorCard: Color(#colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 0.3774614726)), backgroundColorTitle: Color(#colorLiteral(red: 0.9190552344, green: 1, blue: 0.6697965896, alpha: 0.3696757277)), shadowColorCard: Color(#colorLiteral(red: 0.9515599744, green: 1, blue: 0.4813389062, alpha: 0.8140517979)))
    }
}
