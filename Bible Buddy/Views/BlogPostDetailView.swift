//
//  BlogPostDetailView.swift
//  Bible Buddy
//
//  Created by jag on 29.05.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import SwiftUI

struct BlogPostDetailView: View {
    var post: BlogPost
    
    var body: some View {
        VStack() {
            Image(post.image)
            .resizable()
                //.edgesIgnoringSafeArea(.top)
                .frame(height: 300)
            
            Image("userdummy")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .background(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
                .frame(width: 150, height: 200)
                .clipShape(Circle())
                .overlay(
                    Circle().stroke(Color.white, lineWidth: 4))
                .shadow(radius: 10)
                .offset(y: -90)
                .padding(.bottom, -100)
                
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text(post.category)
                        .font(.headline)
                        .foregroundColor(.secondary)
                    Text(post.title)
                        .font(.title)
                        .fontWeight(.black)
                        .foregroundColor(.primary)
                        .lineLimit(3)
                    Text(post.userName.uppercased())
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .layoutPriority(100)
                
                Spacer()
                
                VStack(alignment: .trailing){
                    Text("29.05.2020")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Image(systemName: "star.fill")
                        .foregroundColor(Color.yellow)
                    .padding()
                    
                }
            }.padding()
            
            HStack(){
                Text(post.body)
                    .multilineTextAlignment(.leading)
                Spacer()
            }.padding()
            
            Spacer()
            
        }
    }
}

struct BlogPostDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BlogPostDetailView(post: BlogPost(title: "Test Überschrift", body: "Lorem ipsum bla bla blaa", userName: "Jannis G.", userID: "123", category: "Bible study", image: "people"))
    }
}


