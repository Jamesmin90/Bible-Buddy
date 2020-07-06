//
//  SignInUpView.swift
//  Bible Buddy
//
//  Created by admin on 20.05.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import SwiftUI
import Firebase

struct SignInUpView: View {
    
    @EnvironmentObject var session: SessionStore
    @Environment(\.presentationMode) var presMode: Binding<PresentationMode>
    
    @State var userName: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var hidePassword: Bool = true
    @State var error: String = ""
    @State var creation = false
    @State var loading = false
    @State var name = ""
    @State var picker = false
    @State var imagedata : Data = .init(count: 0)
    @State var surName = ""
    @State var showAlert = false
    
    var continueText: String
    var buttonText: String
    
    var body: some View {
        
        VStack {
            
            TextMessage(textMessage: continueText)
            
            if(self.buttonText == "Registrieren"){
                HStack{
                    
                    Spacer()
                    
                    Button(action: {
                        
                        self.picker.toggle()
                        
                    }) {
                        
                        if self.imagedata.count == 0{
                            
                           Image("upload-image").resizable()
                           .aspectRatio(contentMode: .fit)
                           .frame(maxWidth: .infinity, maxHeight: 180)
                           .padding(6)
                           .foregroundColor(.black)
                           Spacer()
                        }
                        else{
                            
                            Image(uiImage: UIImage(data: self.imagedata)!).resizable().renderingMode(.original).frame(width: 90, height: 90).clipShape(Circle())
                        }
                        
                        
                    }
                    
                    Spacer()
                }
                .padding(.vertical, 15)
                
                TextField("UserName", text: self.$userName)
                     .font(.system(size: 14))
                     .padding(15)
                     .background(RoundedRectangle(cornerRadius: 5)
                     .strokeBorder(Color.black, lineWidth: 1))
                     .background(Color(.white))
                 
                 TextField("Vorname", text: self.$name)
                     .font(.system(size: 14))
                     .padding(15)
                     .background(RoundedRectangle(cornerRadius: 5)
                     .strokeBorder(Color.black, lineWidth: 1))
                     .background(Color(.white))
                
                 TextField("Surname", text: self.$surName)
                     .font(.system(size: 14))
                     .padding(15)
                     .background(RoundedRectangle(cornerRadius: 5)
                     .strokeBorder(Color.black, lineWidth: 1))
                     .background(Color(.white))
                
            }
            
            EmailField(email: self.$email)
            
            PasswordField(password: self.$password, hidePassword: self.$hidePassword)
            
            if (buttonText == "Anmelden") {
                NavigationLink(destination: ForgotPasswordView(continueText: "Geben Sie bitte Ihre Email-Adresse ein", buttonText: "Passwort zurücksetzen")) {
                    HStack {
                        Text("Passwort vergessen?")
                            .foregroundColor(.gray)
                            .font(.system(size: 15))
                        Spacer()
                    }.padding(.horizontal, 10)
                }.navigationBarTitle(Text(buttonText), displayMode: .inline)
            }
            
            ManageUserButton(handleButton: {
                (self.buttonText == "Registrieren") ? self.signUp() : self.signIn();
                if self.name != "" && self.imagedata.count != 0{
                    
                    self.loading.toggle()
                    CreateUser(vorName: self.name, surName: self.surName, userName: self.userName, imagedata: self.imagedata) { (status) in
                        
                        
                        if status{
                            
                            self.showAlert.toggle()
                        }
                    }
                }
            }, buttonText: buttonText)
            
            if (error != "") {
                ErrorText(errorText: error)
            }
            
            Spacer()
        }
        .padding(.horizontal)
        .background(Color("basicBackgroundColor")
        .edgesIgnoringSafeArea(.all))
        .sheet(isPresented: self.$picker, content: {
            
            ImagePicker(picker: self.$picker, imagedata: self.$imagedata, presentationMode: self.presMode)
        })
    }
    
    func signIn() {
        session.signIn(email: email, password: password) {
            (result, error) in
            
            if error != nil{
            self.signInUpCompletionHandler(error: error)
            }
            checkUser { (exists, userName, uid, pic) in
                
                if exists{
                     UserDefaults.standard.set(true, forKey: "status")
                     
                     UserDefaults.standard.set(userName, forKey: "userName")
                    
                     UserDefaults.standard.set(uid, forKey: "uid")
                    
                     UserDefaults.standard.set(pic, forKey: "pic")
                     
                     NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)
                }
                else{
                    self.loading.toggle()
                    self.creation.toggle()
                }
            }
        }
    }
    
    func signUp() {
        
        session.signUp(email: email, password: password) {
            (result, error) in
            self.signInUpCompletionHandler(error: error)
        }

    }
    
    func signInUpCompletionHandler(error: Error?) {
        if let error = error {
            self.error = error.localizedDescription
        } else {
            self.email = ""
            self.password = ""
        }
    }
}


struct SignInUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignInUpView(continueText: "123", buttonText: "Sign In")
    }
}

