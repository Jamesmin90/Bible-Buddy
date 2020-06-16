//
//  BlogPostEditView.swift
//  Bible Buddy
//
//  Created by jag on 30.05.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import SwiftUI
import Combine

struct BlogPostEditView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Binding var showSelf: Bool
    @EnvironmentObject var session: SessionStore
    @State private var textStyle = UIFont.TextStyle.body
    @ObservedObject var postlistVM: BlogPostListVM
    @State var postVM: BlogPostVM = BlogPostVM.init(post: BlogPost(id: UUID().uuidString, title: "", body: "", userName: "", userID: "", category: "", imageURL: ""))
    
    @State private var showingImagePicker = false
    @State private var libraryImage: UIImage?
    
    
    var body: some View {
        
        VStack() {
            Form(){
                VStack() {
                    Text("Bild").font(.headline)
                    Button(action: { self.showingImagePicker.toggle()
                    }) {
                        Image(uiImage: self.libraryImage ?? (UIImage(named: "upload-image") ?? UIImage()))
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: .infinity, maxHeight: 180) .padding(6)
                    }
                }.listRowBackground(Color("basicBackgroundColor"))
                
                VStack(alignment: .leading) {
                    Text("Titel").font(.headline)
                    TextField("Titel ...", text: $postVM.post.title).modifier(MyTextFieldStyle())
                }.listRowBackground(Color("basicBackgroundColor"))
                
                VStack(alignment: .leading) {
                    Text("Kategorie").font(.headline)
                    Picker(selection: $postVM.post.category, label: Text("Kategorie")){
                        Text("reading").tag("reading")
                        Text("people").tag(" people")
                    }.pickerStyle(DefaultPickerStyle()).modifier(MyTextFieldStyle())
                }.listRowBackground(Color("basicBackgroundColor"))
                
                VStack(alignment: .leading) {
                    Text("Text").font(.headline)
                    TextView(text: $postVM.post.body, textStyle: $textStyle).frame(height: 300).modifier(MyTextFieldStyle())
                }.listRowBackground(Color("basicBackgroundColor"))
               
                
            }
            Spacer()
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
                ImageUploadService.upload(for: self.libraryImage!) { result in
                    print("Image uploaded to URL: \(result)")
                    self.postVM.post.imageURL = result
                    self.postVM.post.userID = self.session.session != nil ? self.session.session!.uid : ""
                    self.postlistVM.addPost(post: self.postVM.post)
                    
                }
            }
                
            ) {
                Text("POST")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 220, height: 60)
                    .background(Color.green)
                    .cornerRadius(6.0)
            }
        }
        .navigationBarTitle("New Post")
        .sheet(isPresented: $showingImagePicker) {
            
            ImagePicker(image: self.$libraryImage)
            
        }.buttonStyle(PlainButtonStyle())
        //.background(Color("basicBackgroundColor"))
            
    }
    
    
    
    
    
    
    struct BlogPostEditView_Previews: PreviewProvider {
        @State static var show = true
        static var previews: some View {
            
            BlogPostEditView(showSelf: $show, postlistVM: BlogPostListVM())
            //Text("dummy")
        }
    }
    
}
