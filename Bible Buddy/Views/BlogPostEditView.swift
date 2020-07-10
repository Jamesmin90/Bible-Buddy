//
//  BlogPostEditView.swift
//  Bible Buddy
//
//  Created by Jannis Gutleben on 30.05.20.
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
    
    @State private var showImageWarning = false
    @State private var showTitleWarning = false
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
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
                }//.listRowBackground(Color("basicBackgroundColor"))
                if(self.showImageWarning) {
                    ErrorText(errorText: "Bitte wählen Sie ein Bild aus!")
                }
                VStack(alignment: .leading) {
                    Text("Titel").font(.headline)
                    TextField("Titel ...", text: $postVM.post.title).modifier(MyTextFieldStyle())
                }//.listRowBackground(Color("basicBackgroundColor"))
                if(self.showTitleWarning) {
                    ErrorText(errorText: "Bitte geben Sie einen Titel ein!")
                }
                VStack(alignment: .leading) {
                    Text("Kategorie").font(.headline)
                    Picker(selection: $postVM.post.category, label: Text("Kategorie")){
                        Text("reading").tag("reading")
                        Text("people").tag(" people")
                    }.pickerStyle(DefaultPickerStyle()).modifier(MyTextFieldStyle())
                }//.listRowBackground(Color("basicBackgroundColor"))
                
                VStack(alignment: .leading) {
                    Text("Text").font(.headline)
                    TextView(text: $postVM.post.body, textStyle: $textStyle).frame(height: 300).modifier(MyTextFieldStyle())
                }//.listRowBackground(Color("basicBackgroundColor"))
                
                
            }
            //Spacer()
            Button(action: {
                if (self.libraryImage == nil) {
                    self.showImageWarning = true
                } else {
                    self.showImageWarning = false
                }
                if (self.postVM.post.title == "") {
                    self.showTitleWarning = true
                } else {
                    self.showTitleWarning = false
                }
                
                if(self.libraryImage != nil && self.postVM.post.title != "") {
                    self.presentationMode.wrappedValue.dismiss()
                    ImageUploadService.upload(for: self.libraryImage!) { result in
                        print("Image uploaded to URL: \(result)")
                        self.postVM.post.imageURL = result
                        self.postVM.post.userID = self.session.session != nil ? self.session.session!.uid : ""
                        self.postlistVM.addPost(post: self.postVM.post)
                    }
                }
            }
                
            ) {
                Text("POST")
                    .font(.headline)
                    .foregroundColor(.black)
                    .padding()
                    .frame(width: 220, height: 60)
                    .background(Color.gray)
                    .cornerRadius(6.0)
            }
        }
        .navigationBarTitle("Neuer Post")
        .sheet(isPresented: $showingImagePicker) {
            
            ImagePicker1(image: self.$libraryImage)
            
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
