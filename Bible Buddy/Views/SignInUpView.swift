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
    @State var userNameAlert = false
    
    var continueText: String
    var buttonText: String
    
    var body: some View {
        
        VStack {
            
            TextMessage(textMessage: continueText)
            
            if(self.buttonText == "Registrieren"){
                HStack(alignment: .center){
                    
                    Spacer()
                    
                    Button(action: {
                        
                        self.picker.toggle()
                        
                    }) {
                        
                        if self.imagedata.count == 0{
                            
                            HStack {
                                Spacer()
                                Image("upload-image")
                                 .renderingMode(.original)
                                 .resizable()
                                 .frame(width: 40, height: 40)
                                Spacer()
                            }
                            
                           Spacer()
                        }
                        else{
                            
                            Image(uiImage: UIImage(data: self.imagedata)!).resizable().renderingMode(.original).frame(width: 90, height: 90).clipShape(Circle())
                        }
                    }
                    
                    Spacer()
                }
                .padding(.bottom, 15)
                
                UserInputTextField(userInput: self.$userName, textFieldText: "UserName")
                
                UserInputTextField(userInput: self.$name, textFieldText: "Vorname")
                
                UserInputTextField(userInput: self.$surName, textFieldText: "Surname")

            }
            
            UserInputTextField(userInput: self.$email, textFieldText: "Email-Adresse")
            
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
        .alert(isPresented: self.$userNameAlert) {
            Alert(title: Text(""), message: Text("The Username is already in use"), dismissButton: .default(Text("OK")))}
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
        
        var usernames = [String]()
        
        let db = Firestore.firestore()
        
        db.collection("users").getDocuments { (snap, err) in

        if err != nil{
            
            print((err?.localizedDescription)!)
            return
        }
            for i in snap!.documents{
                let username1 = i.get("userName") as! String
                usernames.append(username1)
                }
            if usernames.contains(self.userName){
                self.userNameAlert.toggle()
                return
            } else{
                
                    if self.name != "" && self.imagedata.count != 0 && self.surName != ""{
                        
                        self.session.signUp(email: self.email, password: self.password) {
                        (result, error) in
                        self.signInUpCompletionHandler(error: error)
                        
                            if error == nil{
                        
                        self.loading.toggle()
                        CreateUser(vorName: self.name, surName: self.surName, userName: self.userName, imagedata: self.imagedata) { (status) in
                            
                            if status{
                                
                                self.showAlert.toggle()
                            }
                        }
                    }
                    }
                }
                
            }
            
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




