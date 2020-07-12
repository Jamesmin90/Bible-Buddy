//
//  Chat.swift
//  Bible Buddy
//
//  Created by James on 07.06.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//


import SwiftUI
import SDWebImageSwiftUI
import Firebase

struct Chat : View {
    
    @EnvironmentObject var datas : MainObservable
    @State var show = false
    @State var chat = false
    @State var uid = ""
    @State var name = ""
    @State var pic = ""
    
    var body : some View{
        
        ZStack{
            
            Color("basicBackgroundColor")
                .edgesIgnoringSafeArea(.all)
            
            NavigationLink(destination: ChatView(name: self.name, pic: self.pic, uid: self.uid, chat: self.$chat), isActive: self.$chat) {
                
                Text("")
            }

            VStack{
                
                if self.datas.recents.count == 0{
                    
                    if self.datas.norecetns{
                        
                        Text("No Chat History")
                    }
                    else{
                        
                        Indicator()
                    }
                
                }
                else{
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        VStack(spacing: 12){
                            
                            ForEach(datas.recents.sorted(by: {$0.stamp > $1.stamp})){i in
                                
                                Button(action: {
                                    
                                    self.uid = i.id
                                    self.name = i.userName
                                    self.pic = i.pic
                                    self.chat.toggle()
                                    
                                }) {
                                    
                                    RecentCellView(url: i.pic, name: i.userName, time: i.time, date: i.date, lastmsg: i.lastmsg)
                                }
                                
                            }
                            
                        }.padding()
                        
                    }
                }
            }
            .navigationBarTitle("ChatRoom",displayMode: .inline)
              .navigationBarItems(trailing:
              
                  Button(action: {
                      
                    self.show.toggle()
                    
                  }, label: {
                      
                      Image(systemName: "square.and.pencil").resizable().frame(width: 25, height: 25)
                  }
              )
              
            )
        }
        .sheet(isPresented: self.$show) {
            
            newChatView(name: self.$name, uid: self.$uid, pic: self.$pic, show: self.$show, chat: self.$chat)
        }
    }
}

struct newChatView : View {
    
    @ObservedObject var datas = getAllUsers()
    @Binding var name : String
    @Binding var uid : String
    @Binding var pic : String
    @Binding var show : Bool
    @Binding var chat : Bool
    @State private var searchText = ""
    
    
    var body : some View{
        
        VStack(alignment: .leading){

                if self.datas.users.count == 0{
                    
                    if self.datas.empty{
                        
                        Text("No Users Found")
                    }
                    else{
                        VStack{
                            Spacer()
                            HStack{
                                Spacer()
                                Indicator()
                                Spacer()
                            }
                            Spacer()
                        }
                        
                    }
                    
                }
                else{
                    
                    Text("Select To Chat").font(.title).foregroundColor(Color.black.opacity(0.5))
                    
                    SearchBar(text: $searchText, placeholder: "Suche Benutzername")
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        VStack(spacing: 12){
                            
                            ForEach(datas.users.filter{self.searchText.isEmpty ? true:($0.userName.contains(self.searchText))}, id: \.self.id)  {i in
                                
                                Button(action: {
                                    
                                    self.uid = i.id
                                    self.name = i.userName
                                    self.pic = i.pic
                                    self.show.toggle()
                                    self.chat.toggle()
                                    
                                    
                                }) {
                                    
                                    UserCellView(url: i.pic, name: i.userName)
                                }
                                
                                
                            }
                            
                        }
                        
                    }
              }
        }.padding()
        .background(Color("basicBackgroundColor")
        .edgesIgnoringSafeArea(.all))
    }
}

struct ChatView : View {
    
    var name : String
    var pic : String
    var uid : String
    @Binding var chat : Bool
    @State var msgs = [Msg]()
    @State var txt = ""
    @State var nomsgs = false
    let mypic = UserDefaults.standard.value(forKey: "pic") as? String
    
    var body : some View{
        
        VStack{
            
            
            if msgs.count == 0{
                
                if self.nomsgs{
                    
                    Text("Start New Conversation !!!").foregroundColor(Color.black.opacity(0.5)).padding(.top)
                    
                    Spacer()
                }
                else{
                    
                    Spacer()
                    Indicator()
                    Spacer()
                }

                
            }
            else{
                
                CustomScrollView(scrollToEnd: true) {
                    
                    VStack(spacing: 8){
                        
                        ForEach(self.msgs){i in
                            
                            
                            HStack{
                                
                                if i.user == Auth.auth().currentUser?.uid{
                                    
                                    Spacer()
                                    
                                    Text(i.msg)
                                        .padding()
                                        .background(Color.blue)
                                        .clipShape(ChatBubble(mymsg: true))
                                        .foregroundColor(.white)
                                    
                                    AnimatedImage(url: URL(string: self.mypic!)).resizable().renderingMode(.original).frame(width: 55, height: 55).clipShape(Circle())
                                }
                                else{
                                    AnimatedImage(url: URL(string: self.pic)!).resizable().renderingMode(.original).frame(width: 55, height: 55).clipShape(Circle())
                                    
                                    Text(i.msg).padding().background(Color.green).clipShape(ChatBubble(mymsg: false)).foregroundColor(.white)
                                    
                                    Spacer()
                                }
                            }

                        }
                    }
                }
            }
            
            HStack{
                
                TextField("Enter Message", text: self.$txt).textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button(action: {
                    
                    sendMsg(user: self.name, uid: self.uid, pic: self.pic, date: Date(), msg: self.txt)
                    
                    self.txt = ""
                    
                }) {
                    
                    Text("Send")
                }
            }
            
                .navigationBarTitle("\(name)",displayMode: .inline)
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading: Button(action: {
                    
                    self.chat.toggle()
                    
                }, label: {
                
                    Image(systemName: "arrow.left").resizable().frame(width: 20, height: 15)
                    
                }))
            
        }.padding()
        .background(Color("basicBackgroundColor")
        .edgesIgnoringSafeArea(.all))
        .onAppear {
        
            self.getMsgs()
                
        }
    }
    
    func getMsgs(){
        
        let db = Firestore.firestore()
        
        let uid = Auth.auth().currentUser?.uid
        
        db.collection("msgs").document(uid!).collection(self.uid).order(by: "date", descending: false).addSnapshotListener { (snap, err) in
            
            if err != nil{
                
                print((err?.localizedDescription)!)
                self.nomsgs = true
                return
            }
            
            if snap!.isEmpty{
                
                self.nomsgs = true
            }
            
            for i in snap!.documentChanges{
                
                if i.type == .added{
                    
                    
                    let id = i.document.documentID
                    let msg = i.document.get("msg") as! String
                    let user = i.document.get("user") as! String
                    let pic = i.document.get("pic") as! String
                    
                    self.msgs.append(Msg(id: id, msg: msg, user: user, pic: pic))
                }

            }
        }
    }
}

