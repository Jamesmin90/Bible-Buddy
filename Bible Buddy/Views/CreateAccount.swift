//
//  CreateAccount.swift
//  Bible Buddy
//
//  Created by admin on 13.06.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import SwiftUI
import Firebase

struct AccountCreation : View {
    
    @Binding var show : Bool
    @State var name = ""
    @State var picker = false
    @State var loading = false
    @State var imagedata : Data = .init(count: 0)
    @State var userName = ""
    @State var surName = ""
    @State var showAlert = false
    
    @Environment(\.presentationMode) var presMode: Binding<PresentationMode>
    
    var body : some View{
        
        VStack(alignment: .leading, spacing: 15){
            
            TextMessage(textMessage: "Geben Sie bitte Ihren Benutzernamen und Ihr Profilbild an")
            
            
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
                    
            
            
            if self.loading{
                
                HStack{
                    
                    Spacer()
                    
                    Indicator()
                    
                    Spacer()
                }
            }
                
            else{
                
                Button(action: {
                    
                    if self.name != "" && self.imagedata.count != 0{
                        
                        self.loading.toggle()
                        CreateUser(vorName: self.name, surName: self.surName, userName: self.userName, imagedata: self.imagedata) { (status) in
                            
                            
                            if status{
                                
                                self.showAlert.toggle()
                            }
                        }
                    }
                    
                }) {
                    

                Text("erstellen").frame(minWidth: 0, maxWidth: .infinity)
                .frame(height: 50)
                .font(.system(size: 13, weight: .bold))
                .foregroundColor(.black)
                .background(Color(#colorLiteral(red: 0.9198423028, green: 0.9198423028, blue: 0.9198423028, alpha: 1)))
                .cornerRadius(5)
                         
                }.padding(.top, 30)
                
                
            }
            Spacer()
            
        }
        .padding(.horizontal)
        .background(Color("basicBackgroundColor")
        .edgesIgnoringSafeArea(.all))
        .navigationBarTitle("Profil", displayMode: .inline)
        .alert(isPresented: self.$showAlert) {
            Alert(title: Text(""), message: Text("Benutzer erfolgreich erstellt"), dismissButton: .default(Text("OK"), action: {self.presMode.wrappedValue.dismiss()}))
        }

        .sheet(isPresented: self.$picker, content: {
            
            ImagePicker(picker: self.$picker, imagedata: self.$imagedata, presentationMode: self.presMode)
        })
    }
}
