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
    
    //@ObservedObject var uploader: ImageUploadService = ImageUploadService()
    
    //private var cancellables = Set<AnyCancellable>()
    
    var body: some View {
        VStack() {
            Form(){
                VStack() {
                    Text("Picture").font(.headline)
                    Button(action: { self.showingImagePicker.toggle()
                    }) {
                        Image(uiImage: self.libraryImage ?? (UIImage(named: "upload-image") ?? UIImage()))
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            //.clipShape(Circle())
                            //.overlay(Circle().stroke(Color.purple, lineWidth: 3).shadow(radius:10))
                            .frame(maxWidth: .infinity, maxHeight: 180) .padding(6)
                    }
                    
                }
                
                
                
                VStack(alignment: .leading) {
                    Text("Titel").font(.headline)
                    TextField("enter Title ...", text: $postVM.post.title).modifier(MyTextFieldStyle())
                    //.overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.gray, lineWidth: 0.5))
                }
                
                VStack(alignment: .leading) {
                    Text("Category").font(.headline)
                    Picker(selection: $postVM.post.category, label: Text("Kategorie")){
                        Text("reading").tag("reading")
                        Text("people").tag(" people")
                    }.pickerStyle(DefaultPickerStyle()).modifier(MyTextFieldStyle())
                    //.overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.gray, lineWidth: 0.5))
                }
                
                VStack(alignment: .leading) {
                    Text("Text").font(.headline)
                    TextView(text: $postVM.post.body, textStyle: $textStyle).frame(height: 300).modifier(MyTextFieldStyle())
                    //.frame(height: 300).overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.gray, lineWidth: 0.5))
                }
                
                
            }
            .background(Color("basicBackgroundColor"))
            Spacer()
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
                ImageUploadService.upload(for: self.libraryImage!) { result in
                    print("Image uploaded to URL: \(result)")
                    self.postVM.post.imageURL = result
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
        .background(Color("basicBackgroundColor"))
        .navigationBarTitle("New Post")
        .sheet(isPresented: $showingImagePicker) {
            
            ImagePicker(image: self.$libraryImage)
            
        }.buttonStyle(PlainButtonStyle())
    }
    
    
    
    
    
    
    struct BlogPostEditView_Previews: PreviewProvider {
        @State static var show = true
        static var previews: some View {
            
            //BlogPostEditView(showSelf: $show, postlistVM: BlogPostListVM())
            Text("dummy")
        }
    }
    
}
