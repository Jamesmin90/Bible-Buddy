//
//  ReigsterView.swift
//  Bible Buddy
//
//  Created by admin on 17.05.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import SwiftUI
import Firebase

let lightgrey = SwiftUI.Color.init(red: 0.81, green: 0.85, blue: 0.86, opacity: 1.00)
let darkgrey = SwiftUI.Color.init(red: 0.15, green: 0.20, blue: 0.22, opacity: 1.00)



struct LogInView: View {
    @State var name: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var authenticationDidFail: Bool = false
    @State var authenticationDidSucceed: Bool = false
    @State private var selection: Int? = nil
    @State var image: Data = .init(count: 0)
    
    
    var body: some View {
        
        ZStack {
            VStack{
                SetUp()
                UserImage()
                
                UserEmail(email: $email)
                UserPass(password: $password)
                
                if authenticationDidFail{
                    Text("Password should be at least 6 characters")
                        .offset(y: -10)
                        .foregroundColor(.red)
                }
                
                NavigationLink(destination: MessagePage(sender: self.email, image: self.$image), tag:1, selection: self.$selection){
                    Text("")
                }
                Button(action:{
                    let email = self.email
                    let password = self.password
                    Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                        if let e = error{
                            self.authenticationDidFail = true
                        }else{
                            self.selection = 1
                            print(email)
                        }
                    }
                    
                }){
                    LogInButton()
                }
                
                
                
                
            }//VStack
            .padding()
            if authenticationDidSucceed{
                Text("Welcome!")
                    .font(.headline)
                    .frame(width: 250, height: 80)
                    .background(lightgrey)
                    .foregroundColor(darkgrey)
                    .cornerRadius(20.0)
                    .animation(Animation.default)
                
            }
        }//ZStack
        
    }// BodyView
    
}


struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}


struct SetUp: View {
    var body: some View {
        Text("Welcome Back!")
            .font(.largeTitle)
            .fontWeight(.semibold)
            .padding(.bottom, 20)
    }
}

struct UserImage: View {
    var body: some View {
        Image("register")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width:150, height: 150)
            .clipped()
            .cornerRadius(150)
            .padding(.bottom, 75)
    }
}

struct LogInButton: View {
    var body: some View {
        Text("Log In")
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 220, height: 60)
            .background(darkgrey)
            .cornerRadius(35.0)
    }
}

struct UserName: View {
    
    @Binding var name: String
    
    var body: some View {
        TextField("Enter your Name", text: $name)
            .padding()
            .background(lightgrey)
            .cornerRadius(10)
            .padding(.bottom, 20)
    }
}

struct UserEmail: View {
    
    @Binding var email: String
    
    var body: some View {
        TextField("Email", text: $email)
            .padding()
            .background(lightgrey)
            .cornerRadius(10)
            .padding(.bottom, 20)
    }
}

struct UserPass: View {
    
    @Binding var password: String
    
    var body: some View {
        SecureField("Password", text: $password)
            .padding()
            .background(lightgrey)
            .cornerRadius(10)
            .padding(.bottom, 20)
    }
}

/*if self.name == storedName && self.password == storedPassword && self.email == storedEmail{
                       self.authenticationDidSucceed = true
                       self.authenticationDidFail = false
                   } else{
                       self.authenticationDidFail = true
                   }*/

/*NavigationView {
        ZStack{
            Color(UIColor(red: 0.81, green: 0.85, blue: 0.86, alpha: 1.00)).edgesIgnoringSafeArea(.all)
            VStack{
                TextField("Name", text: self.$name, .foregroundColor = .white)
                .background(SwiftUI.Color.init(UIColor(red: 0.27, green: 0.35, blue: 0.39, alpha: 1.00)))
                .foregroundColor(.white)
                .cornerRadius(10)
            }
        }
        .navigationBarTitle(Text("Let's get you set up"))
    }
}
init(){
    UINavigationBar.appearance().backgroundColor = .some(UIColor(red: 0.27, green: 0.35, blue: 0.39, alpha: 1.00))
}*/

