//
//  BlogPostDetailView.swift
//  Bible Buddy
//
//  Created by Jannis Gutleben on 29.05.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import SwiftUI

struct BlogPostDetailView: View {
    @ObservedObject var postVM: BlogPostVM
    	
    
    var body: some View {
        ScrollView {
            VStack() {
                Image(uiImage: UIImage(data: postVM.blogImage) ?? UIImage())
                .resizable()
                    .frame(height: 300)
                    .cornerRadius(10)
                
                Image(uiImage: UIImage(data: postVM.userProfileVM.profilepicture) ?? UIImage())
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
                        Text(postVM.dateString)
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        Image(systemName: "star.fill")
                            .foregroundColor(Color.yellow)
                        .padding()
                        
                    }
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding(10)
                .background(Color.gray.opacity(0.5))
                .cornerRadius(10)
                
                HStack(){
                    Text(postVM.post.body)
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding(10)
                .background(Color.gray.opacity(0.5))
                .cornerRadius(10)
                
                Spacer()
                
            }.padding()
        }.background(Color("basicBackgroundColor"))
    }
}

struct BlogPostDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BlogPostDetailView(postVM: BlogPostVM(post: BlogPost(title: "Test Überschrift", body: "Lorem ipsum bla bla blaa", userName: "Jannis G.", userID: "123", category: "Bible study", imageURL: "")))
    }
}


