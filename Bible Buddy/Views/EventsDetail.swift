//
//  EventsDetail2.swift
//  Bible Buddy
//
//  Created by James on 27.05.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import SwiftUI
import Firebase

struct EventsDetail: View {
    
    @State var posts: EventsPost
    @State private var loading: Bool = true
    @EnvironmentObject var session: SessionStore
    @State var icount = ""
    @State var bcount = ""
    @State var isSelectedb = false
    @State var isSelectedi = false
    @State var x = false
    @State var image: RemoteImage2
    
    var body: some View {
        
        List{
            
            
            ZStack(alignment: .bottomLeading){
                image
                Text(posts.name)
                    .foregroundColor(.white)
                    .font(.title)
                    .fontWeight(.bold)
            }
            
            if (session.session != nil){
                HStack(spacing: 1){
                    Spacer()
                    VStack{
                        EventsButton(isSelected: self.$isSelectedi, postName: $posts.name)
                        Text("Interessiert")
                    }
                    Spacer()
                    VStack{
                        EventsButton2(isSelected: self.$isSelectedb, postName: $posts.name)
                        Text("Besuchen")
                    }
                    Spacer()
                    
                    
                }
                .buttonStyle(BorderlessButtonStyle())
            }
            
            
            EventsResponse(postName: posts.name, height: 100, icount: self.icount, bcount: self.bcount)
            
            TextDescription(descriptiontext: posts.date, height: 50 )
            
            TextDescription(descriptiontext: posts.location, height: 50)
            
            TextDescription(descriptiontext: posts.description, height: 150)
            
            MapView(latitude: posts.latitude, longitude: posts.longitude, title: posts.location, subtitle: posts.name)
                . frame(width: 380, height: 180)
            
            
            
        }
        .navigationBarTitle(Text(posts.name), displayMode: .inline)
        .onAppear{
            self.BesuchenSelected()
            self.interresiertSelected()
            self.besuchen()
            self.interessiert()
            
        }
        
    }
    
    func besuchen() {
        //let Username = UserDefaults.standard.value(forKey: "userName") as! String
        let db = Firestore.firestore()
        db.collection("events").document("\(posts.name)").collection("Besuchen").addSnapshotListener{
            DocumentsSnapshot, error in guard let documents = DocumentsSnapshot else {
                print("Error fetching document: \(error!)")
                return
            }
            
            self.bcount = String(documents.count)
           
        }
    }
    
    func interessiert() {
        
        let db = Firestore.firestore()
        db.collection("events").document("\(posts.name)").collection("Interessiert").addSnapshotListener{
            DocumentsSnapshot, error in guard let documents = DocumentsSnapshot else {
                print("Error fetching document: \(error!)")
                return
            }
            
            self.icount = String(documents.count)
        }
    }
    
    func interresiertSelected(){
        let Username = UserDefaults.standard.value(forKey: "userName") as! String
        let db = Firestore.firestore()
        db.collection("events").document("\(posts.name)").collection("Interessiert").document(Username).addSnapshotListener { (document, err) in
            
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                print("Document data: \(dataDescription)")
                self.isSelectedi = true
            }else{
                self.isSelectedi = false
                print("Document does not exist")
            }
            
                
                
            }
        }
    
    func BesuchenSelected(){
        let Username = UserDefaults.standard.value(forKey: "userName") as! String
        let db = Firestore.firestore()
        db.collection("events").document("\(posts.name)").collection("Besuchen").document(Username).addSnapshotListener { (document, err) in
            
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                print("Document data: \(dataDescription)")
                self.isSelectedb = true
            }else{
                self.isSelectedb = false
                print("Document does not exist")
            }
            
            
            
        }
    }

}


