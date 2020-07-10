//
//  PostList.swift
//  Bible Buddy
//
//  Created by James on 27.05.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import SwiftUI
import Combine

struct EventsView: View {
    @State var posts: [EventsPost] = []
    
    init(){
        UITableView.appearance().backgroundColor = UIColor(red: 0.92, green: 1.00, blue: 1.00, alpha: 1.00)
        UITableViewCell.appearance().backgroundColor = UIColor(red: 0.92, green: 1.00, blue: 1.00, alpha: 1.00)
        UITableView.appearance().tableFooterView = UIView()
    }
    
    var body: some View {
        
            List(self.posts, id: \.name) { post in
                
                NavigationLink(destination: EventsDetail(posts: post, image: RemoteImage2(imageUrl: post.imageURL))) {
                    ZStack(alignment: .bottomLeading){
                        
                        RemoteImage(imageUrl: post.imageURL)
                        Text(post.name)
                            .foregroundColor(.white)
                            .font(.title)
                            .fontWeight(.bold)
                    }
                    
                    
                }
                
                
            }

            .onAppear{
                
                Api().getPosts { (posts) in
                    //differentiates post from above and the post we get from the api call
                    
                    self.posts = posts
                }
            }
            .navigationBarTitle(Text("Events"), displayMode: .inline)
            
    }
}

struct EventsView_Previews: PreviewProvider {
    static var previews: some View {
        EventsView()
    }
}





