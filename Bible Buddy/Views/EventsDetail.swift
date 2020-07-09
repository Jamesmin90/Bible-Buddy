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
    @State var resp = [Response]()
    @State var resp2 = [Response2]()
    @State var icount = ""
    @State var bcount = ""
    
    
    var body: some View {
        List{
            
            
            ZStack(alignment: .bottomLeading){
                RemoteImage2(imageUrl: posts.imageURL)
                //ActivitiyIndicatorView(animating: self.$loading, style: .large)
                Text(posts.name)
                    .foregroundColor(.white)
                    .font(.title)
                    .fontWeight(.bold)
            }
            if (session.session != nil){
                HStack(spacing: 1){
                    Spacer()
                    VStack{
                        EventsButton(action: {}, content: {
                            Image(systemName: "flag")
                                .frame(width: 40, height: 40)
                        }, postName: posts.name)
                        Text("Interessiert")
                        
                    }
                    Spacer()
                    VStack{
                        EventsButton2(action: {}, content: {
                            Image(systemName: "checkmark")
                                .frame(width: 40, height: 40)
                        }, postName: posts.name)
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
            
            //SignupDescription(url: posts.signup, height: 50)
            
            MapView(latitude: posts.latitude, longitude: posts.longitude, title: posts.location, subtitle: posts.name)
                . frame(width: 380, height: 180)
            
            
            
        }
        .navigationBarTitle(Text(posts.name), displayMode: .inline)
        .onAppear{
            self.besuchen()
            self.interessiert()
        }
        
    }
    
    func besuchen() {
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
}

struct Response{
    
    var bcount : Int
}

struct Response2 {
    
    var icount : String
}


struct EventsDetail_Previews: PreviewProvider {
    static var previews: some View {
        EventsDetail(posts: EventsPost(
        name: "",
        location: "",
        date: "",
        imageURL: "",
        description: "",
        signup: "",
        latitude: 48.149996544187985,
        longitude: 11.594266891479492))
    }
}
