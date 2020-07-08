//
//  Chat.swift
//  Bible Buddy
//
//  Created by admin on 07.06.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//


import SwiftUI
import Firebase
import SDWebImageSwiftUI
import FirebaseFirestore

struct Chat : View {
    
    @EnvironmentObject var datas : MainObservable
    @State var show = false
    @State var chat = false
    @State var uid = ""
    @State var name = ""
    @State var pic = ""
    @EnvironmentObject var session: SessionStore
    
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

struct RecentCellView : View {
    
    var url : String
    var name : String
    var time : String
    var date : String
    var lastmsg : String
    
    var body : some View{
        
        HStack{
            
            AnimatedImage(url: URL(string: url)!).resizable().renderingMode(.original).frame(width: 55, height: 55).clipShape(Circle())
            
            
            VStack{
                
                HStack{
                    
                    VStack(alignment: .leading, spacing: 6) {
                        
                        Text(name).foregroundColor(.black)
                        Text(lastmsg).foregroundColor(.gray)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 6) {
                        
                         Text(date).foregroundColor(.gray)
                         Text(time).foregroundColor(.gray)
                    }
                }
                
                Divider()
            }
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

class getAllUsers : ObservableObject{
    
    @Published var users = [User_Chat]()
    @Published var empty = false
    
    init() {
        
        let db = Firestore.firestore()
        
        
        db.collection("users").getDocuments { (snap, err) in

            if err != nil{
                
                print((err?.localizedDescription)!)
                self.empty = true
                return
            }
            
            if (snap?.documents.isEmpty)!{
                
                self.empty = true
                return
            }
            
            for i in snap!.documents{
                
                let id = i.documentID
                let userName = i.get("userName") as! String
                let pic = i.get("pic") as! String
               // let about = i.get("about") as! String
                
                if id != Auth.auth().currentUser?.uid{
                    
                    self.users.append(User_Chat(id: id, userName: userName, pic: pic))

                }
                
            }
            
            if self.users.isEmpty{
                
                self.empty = true
            }
        }
    }
}

struct User_Chat : Identifiable, Hashable {
    
    var id : String
    var userName : String
    var pic : String
}

struct UserCellView : View {
    
    var url : String
    var name : String
    //var about : String
    
    var body : some View{
        
        HStack{
            
            AnimatedImage(url: URL(string: url)!).resizable().renderingMode(.original).frame(width: 55, height: 55).clipShape(Circle())
            
            VStack{
                
                HStack{
                    
                    VStack(alignment: .leading, spacing: 6) {
                        
                        Text(name).foregroundColor(.black)
                        //Text(about).foregroundColor(.gray)
                    }
                    
                    Spacer()
                    
                }
                
                Divider()
            }
        }
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

struct CustomScrollView<Content>: View where Content: View {
    var axes: Axis.Set = .vertical
    var reversed: Bool = false
    var scrollToEnd: Bool = false
    var content: () -> Content

    @State private var contentHeight: CGFloat = .zero
    @State private var contentOffset: CGFloat = .zero
    @State private var scrollOffset: CGFloat = .zero

    var body: some View {
        GeometryReader { geometry in
            if self.axes == .vertical {
                self.vertical(geometry: geometry)
            } else {
                // implement same for horizontal orientation
            }
        }
        .clipped()
    }

    private func vertical(geometry: GeometryProxy) -> some View {
        VStack {
            content()
        }
        .modifier(ViewHeightKey())
        .onPreferenceChange(ViewHeightKey.self) {
            self.updateHeight(with: $0, outerHeight: geometry.size.height)
        }
        .frame(height: geometry.size.height, alignment: (reversed ? .bottom : .top))
        .offset(y: contentOffset + scrollOffset)
        .animation(.easeInOut)
        .background(Color(UIColor(red: 0.92, green: 1.00, blue: 1.00, alpha: 1.00)))
        .gesture(DragGesture()
            .onChanged { self.onDragChanged($0) }
            .onEnded { self.onDragEnded($0, outerHeight: geometry.size.height) }
        )
    }

    private func onDragChanged(_ value: DragGesture.Value) {
        self.scrollOffset = value.location.y - value.startLocation.y
    }

    private func onDragEnded(_ value: DragGesture.Value, outerHeight: CGFloat) {
        let scrollOffset = value.predictedEndLocation.y - value.startLocation.y

        self.updateOffset(with: scrollOffset, outerHeight: outerHeight)
        self.scrollOffset = 0
    }

    private func updateHeight(with height: CGFloat, outerHeight: CGFloat) {
        let delta = self.contentHeight - height
        self.contentHeight = height
        if scrollToEnd {
            self.contentOffset = self.reversed ? height - outerHeight - delta : outerHeight - height
        }
        if abs(self.contentOffset) > .zero {
            self.updateOffset(with: delta, outerHeight: outerHeight)
        }
    }

    private func updateOffset(with delta: CGFloat, outerHeight: CGFloat) {
        let topLimit = self.contentHeight - outerHeight

        if topLimit < .zero {
             self.contentOffset = .zero
        } else {
            var proposedOffset = self.contentOffset + delta
            if (self.reversed ? proposedOffset : -proposedOffset) < .zero {
                proposedOffset = 0
            } else if (self.reversed ? proposedOffset : -proposedOffset) > topLimit {
                proposedOffset = (self.reversed ? topLimit : -topLimit)
            }
            self.contentOffset = proposedOffset
        }
    }
}

struct ViewHeightKey: PreferenceKey {
    static var defaultValue: CGFloat { 0 }
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = value + nextValue()
    }
}

extension ViewHeightKey: ViewModifier {
    func body(content: Content) -> some View {
        return content.background(GeometryReader { proxy in
            Color.clear.preference(key: Self.self, value: proxy.size.height)
        })
    }
}

struct Msg : Identifiable {
    
    var id : String
    var msg : String
    var user : String
    var pic : String
}

struct ChatBubble : Shape {
    
    var mymsg : Bool
    
    func path(in rect: CGRect) -> Path {
            
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft,.topRight,mymsg ? .bottomLeft : .bottomRight], cornerRadii: CGSize(width: 16, height: 16))
        
        return Path(path.cgPath)
    }
}

func sendMsg(user: String,uid: String,pic: String,date: Date,msg: String){
    
    let db = Firestore.firestore()
    
    let myuid = Auth.auth().currentUser?.uid
    
    db.collection("users").document(uid).collection("recents").document(myuid!).getDocument { (snap, err) in
        
        if err != nil{
            
            print((err?.localizedDescription)!)
            // if there is no recents records....
            
            setRecents(user: user, uid: uid, pic: pic, msg: msg, date: date)
            return
        }
        
        if !snap!.exists{
            
            setRecents(user: user, uid: uid, pic: pic, msg: msg, date: date)
        }
        else{
            
            updateRecents(uid: uid, lastmsg: msg, date: date)
        }
    }
    
    updateDB(uid: uid, msg: msg, date: date, pic: pic)
}

func setRecents(user: String,uid: String,pic: String,msg: String,date: Date){
    
    
    let db = Firestore.firestore()
    
    let myuid = Auth.auth().currentUser?.uid
    
    let myname = UserDefaults.standard.value(forKey: "userName") as! String
    
    let mypic = UserDefaults.standard.value(forKey: "pic") as! String
    
    db.collection("users").document(uid).collection("recents").document(myuid!).setData(["userName":myname,"pic":mypic,"lastmsg":msg,"date":date]) { (err) in
        
        if err != nil{
            
            print((err?.localizedDescription)!)
            return
        }
    }
    
    db.collection("users").document(myuid!).collection("recents").document(uid).setData(["userName":user,"pic":pic,"lastmsg":msg,"date":date]) { (err) in
        
        if err != nil{
            
            print((err?.localizedDescription)!)
            return
        }
    }
}

func updateRecents(uid: String,lastmsg: String,date: Date){
    
    let db = Firestore.firestore()
    
    let myuid = Auth.auth().currentUser?.uid
    
    db.collection("users").document(uid).collection("recents").document(myuid!).updateData(["lastmsg":lastmsg,"date":date])
    
     db.collection("users").document(myuid!).collection("recents").document(uid).updateData(["lastmsg":lastmsg,"date":date])
}

func updateDB(uid: String,msg: String,date: Date, pic: String){
    
    let db = Firestore.firestore()
    
    let myuid = Auth.auth().currentUser?.uid
    
    db.collection("msgs").document(uid).collection(myuid!).document().setData(["msg":msg,"user":myuid!,"date":date, "pic":pic]) { (err) in
        
        if err != nil{
            
            print((err?.localizedDescription)!)
            return
        }
    }
    
    db.collection("msgs").document(myuid!).collection(uid).document().setData(["msg":msg,"user":myuid!,"date":date, "pic": pic]) { (err) in
        
        if err != nil{
            
            print((err?.localizedDescription)!)
            return
        }
    }
}

