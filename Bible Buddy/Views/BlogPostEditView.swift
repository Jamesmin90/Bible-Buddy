//
//  BlogPostEditView.swift
//  Bible Buddy
//
//  Created by jag on 30.05.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import SwiftUI

struct BlogPostEditView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var showSelf: Bool
    @State private var textStyle = UIFont.TextStyle.body
    @EnvironmentObject var postlistVM: BlogPostListVM
    @State var postVM: BlogPostVM = BlogPostVM.init(post: BlogPost(id: UUID().uuidString, title: "", body: "", userName: "", userID: "", category: "", image: ""))
    var body: some View {
        VStack{
            Form(){
                VStack(alignment: .leading) {
                    Text("Title").font(.headline)
                    TextField("enter Title ...", text: $postVM.post.title).overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.gray, lineWidth: 0.5))
                }
                
                VStack(alignment: .leading) {
                    Text("Category").font(.headline)
                    Picker(selection: $postVM.post.category, label: Text("Choose category")){
                        Text("reading").tag("reading")
                        Text("people").tag(" people")
                        }.pickerStyle(DefaultPickerStyle())
                    .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.gray, lineWidth: 0.5))
                }
                
                VStack(alignment: .leading) {
                    Text("Post").font(.headline)
                    TextView(text: $postVM.post.body, textStyle: $textStyle).frame(height: 300).overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.gray, lineWidth: 0.5))
                }
                
                
            }
            Spacer()
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
                self.postlistVM.addPost(post: self.postVM.post)	
            } ) {
                            Text("POST")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 220, height: 60)
                    .background(Color.green)
                    .cornerRadius(6.0)
            }
            
        }.navigationBarTitle("New Post")
    }
}

struct BlogPostEditView_Previews: PreviewProvider {
    @State static var show = true
    static var previews: some View {
        
        BlogPostEditView(showSelf: $show)
        //Text("dummy")
    }
}
