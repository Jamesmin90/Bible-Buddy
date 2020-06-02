//
//  EventsDetail2.swift
//  Bible Buddy
//
//  Created by admin on 27.05.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import SwiftUI

struct EventsDetail: View {
    
    @State var posts: EventsPost
    @State private var loading: Bool = true
    
    var body: some View {
        List{
         

           ZStack(alignment: .bottomLeading){
            RemoteImage2(imageUrl: posts.imageURL)
            //ActivitiyIndicatorView(animating: self.$loading, style: .large)
               Text(posts.name)
                   .foregroundColor(.white)
                   .font(.title)
                   .fontWeight(.bold)
           }
            Text(posts.date)
                .font(.headline)
                .frame(width: 380, height: 50)
                .background(Color.gray.opacity(0.5))
                .cornerRadius(10)
            Text(posts.location)
                .font(.headline)
                .frame(width: 380, height: 50)
                .background(Color.gray.opacity(0.5))
                .cornerRadius(10)
            Text(posts.description)
                .font(.headline)
                .frame(width: 380, height: 150)
                .background(Color.gray.opacity(0.5))
                .cornerRadius(10)
            MapView(latitude: posts.latitude, longitude: posts.longitude, title: posts.location, subtitle: posts.name)
            . frame(width: 380, height: 180)
            
            
                
        }
        
        .navigationBarTitle(Text(posts.name), displayMode: .inline)
    }
}

struct EventsDetail_Previews: PreviewProvider {
    static var previews: some View {
        EventsDetail(posts: EventsPost(
        name: "",
        location: "",
        date: "",
        imageURL: "",
        description: "",
        signup: "",
        latitude: 48.149996544187985,
        longitude: 11.594266891479492))
    }
}