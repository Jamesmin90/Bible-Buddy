//
//  Blog.swift
//  ChristeninMuenchen
//
//  Created by admin on 12.05.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import SwiftUI

struct BlogView: View {	
    @ObservedObject var posts = FirestoreBlogPostRepository()
    var body: some View {
        ZStack{
            
            Color(#colorLiteral(red: 0.4620226622, green: 0.8382837176, blue: 1, alpha: 0.22)).edgesIgnoringSafeArea(.all)
            List(posts.blogposts){ post in
                NavigationLink(destination: BlogPostDetailView(post: post)){
                    BlogPostCard(post: post)
                }
            }.navigationBarTitle("Blog", displayMode: .inline)
                .onAppear {
                    UITableView.appearance().separatorStyle = .none
            }
        }
    }
}

struct BlogView_Previews: PreviewProvider {
    static var previews: some View {
        BlogView()
    }
}
