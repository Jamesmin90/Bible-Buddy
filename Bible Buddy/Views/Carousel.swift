//
//  Carousel.swift
//  Bible Buddy
//
//  Created by admin on 15.05.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import SwiftUI

struct Carousel: View {
    
    @EnvironmentObject var session: SessionStore
    
    var shadowColor =  Color(#colorLiteral(red: 0.9515599744, green: 1, blue: 0.4813389062, alpha: 0.8140517979))
    var backgroundColorTitle =  Color(#colorLiteral(red: 0.9190552344, green: 1, blue: 0.6697965896, alpha: 0.3696757277))
    
    var body: some View {
        
        ScrollView(.horizontal, showsIndicators: false) {
            
            HStack {
                NavigationLink(destination: BibleBookTableOfContents()){
                    CarouselCard(image: "bible", title: "Bibel", backgroundColorCard: Color(#colorLiteral(red: 0.2522913464, green: 0.2399643849, blue: 0.8064919099, alpha: 0.3844178082)), backgroundColorTitle: backgroundColorTitle, shadowColorCard: shadowColor)
                }.padding(10)
                NavigationLink(destination: BlogView()){
                    CarouselCard(image: "blog", title: "Blog", backgroundColorCard: Color(#colorLiteral(red: 0.5808190107, green: 0.0884276256, blue: 0.3186392188, alpha: 0.6243846318)), backgroundColorTitle: backgroundColorTitle, shadowColorCard: shadowColor)
                }.padding(10)
                NavigationLink(destination: EventsView()){
                    CarouselCard(image: "event", title: "Events", backgroundColorCard: Color(#colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 0.3774614726)), backgroundColorTitle: backgroundColorTitle, shadowColorCard: shadowColor)
                }.padding(10)
                
                if (session.session != nil) {
                    NavigationLink(destination: Chat().environmentObject(MainObservable())){
                        CarouselCard(image: "chat", title: "Chat", backgroundColorCard: Color(#colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 0.4465466833)), backgroundColorTitle: backgroundColorTitle, shadowColorCard: shadowColor)
                    }.padding(10)
                    NavigationLink(destination: NoteView(notelistVM: NoteListVM(session: session), showAsLinks: true)){
                        CarouselCard(image: "notes", title: "Notizen", backgroundColorCard: Color(#colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 0.5516439801)), backgroundColorTitle: backgroundColorTitle, shadowColorCard: shadowColor)
                    }.padding(10)
                }
            }
        }
    }
}

struct Carousel_Previews: PreviewProvider {
    static var previews: some View {
        Carousel()
    }
}
