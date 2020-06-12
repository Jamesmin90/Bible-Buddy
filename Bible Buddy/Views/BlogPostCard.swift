//
//  BlogPostCard.swift
//  Bible Buddy
//
//  Created by jag on 29.05.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import SwiftUI

struct BlogPostCard: View {
    
    @ObservedObject var postVM: BlogPostVM
    
    var body: some View {
        
        VStack {
            
            Image(uiImage: UIImage(data: postVM.blogImage) ?? UIImage())
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text(postVM.post.category)
                        .font(.headline)
                        .foregroundColor(.secondary)
                    Text(postVM.post.title)
                        .font(.title)
                        .fontWeight(.black)
                        .foregroundColor(.primary)
                        .lineLimit(3)
                    Text(postVM.post.userName.uppercased())
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
            }
            .padding()
        }.cornerRadius(10)
         .overlay(
             RoundedRectangle(cornerRadius: 10)
                 .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 1)
         )
         .padding([.top, .horizontal])
    }
}

struct BlogPostCard_Previews: PreviewProvider {
    static var previews: some View {
        BlogPostCard(postVM: BlogPostVM(post: BlogPost(title: "Test Überschrift", body: "Lorem ipsum", userName: "Jannis G.", userID: "123", category: "Bible study", imageURL: "people")))
    }
}
