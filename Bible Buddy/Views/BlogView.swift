//
//  Blog.swift
//  ChristeninMuenchen
//
//  Created by admin on 12.05.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import SwiftUI

struct BlogView: View {
    @ObservedObject var postlistVM = BlogPostListVM()
    @State var showAddPost: Bool = false
    
    var body: some View {
        ZStack{
            
            Color(#colorLiteral(red: 0.4620226622, green: 0.8382837176, blue: 1, alpha: 0.22)).edgesIgnoringSafeArea(.all)
            List{
                ForEach(postlistVM.blogPostVMs) { postVM in
                    NavigationLink(destination: BlogPostDetailView(postVM: postVM)) {
                        BlogPostCard(postVM: postVM)
                    }
                }
            }.navigationBarTitle("Blog", displayMode: .inline)
                .onAppear {
                    UITableView.appearance().separatorStyle = .none
//            }.navigationBarItems(trailing: Button(action: {
//                self.showAddPost.toggle()
//            }){
//                Text("Add")
//            }).sheet(isPresented: $showAddPost) {
//                BlogPostEditView()
//            }
            }.navigationBarItems(trailing:
                HStack{
                NavigationLink(
                    destination: BlogPostEditView(showSelf: $showAddPost).environmentObject(postlistVM),
                    isActive: $showAddPost ){
                            //Text("Add")
                        EmptyView()
                }
                Button(action: {
                    self.showAddPost.toggle()
                }) {
                    Image(systemName: "plus.circle")
                }
                }
            )
            
        }
    }
}

struct BlogView_Previews: PreviewProvider {
    static var previews: some View {
        BlogView()
    }
}
