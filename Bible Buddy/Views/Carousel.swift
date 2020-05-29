//
//  Carousel.swift
//  Bible Buddy
//
//  Created by admin on 15.05.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import SwiftUI

struct Carousel: View {
    
    var shadowColor =  Color(#colorLiteral(red: 0.9515599744, green: 1, blue: 0.4813389062, alpha: 0.8140517979))
    var backgroundColorTitle =  Color(#colorLiteral(red: 0.9190552344, green: 1, blue: 0.6697965896, alpha: 0.3696757277))
    
    var body: some View {
        
        ScrollView(.horizontal, showsIndicators: false) {
            
            HStack {
                
                CarouselCard(image: "bible", title: "Bibel", backgroundColorCard: Color(#colorLiteral(red: 0.2522913464, green: 0.2399643849, blue: 0.8064919099, alpha: 0.3844178082)), backgroundColorTitle: backgroundColorTitle, shadowColorCard: shadowColor)
                
                CarouselCard(image: "blog", title: "Blog", backgroundColorCard: Color(#colorLiteral(red: 0.5808190107, green: 0.0884276256, blue: 0.3186392188, alpha: 0.6243846318)), backgroundColorTitle: backgroundColorTitle, shadowColorCard: shadowColor)
                
                CarouselCard(image: "event", title: "Events", backgroundColorCard: Color(#colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 0.3774614726)), backgroundColorTitle: backgroundColorTitle, shadowColorCard: shadowColor)
                
            }
        }
    }
}

struct Carousel_Previews: PreviewProvider {
    static var previews: some View {
        Carousel()
    }
}
