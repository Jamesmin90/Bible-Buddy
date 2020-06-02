//
//  DataFire.swift
//  Bible Buddy
//
//  Created by admin on 19.05.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import Firebase
import Combine

class DataFire : ObservableObject{
    @Published var messages = [Message]()
    var write = ""

    init(){
        let db = Firestore.firestore()
        
        db.collection(K.FStore.collectionName)
            .order(by: K.FStore.dataField)
            .addSnapshotListener{ (snap, err) in
                //self.messages = []
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }
            for i in snap!.documentChanges{
                if i.type == .added{
                    guard let sender = i.document.get("sender") as? String else {return}
                    guard let msg = i.document.get("msg") as? String else {return}
                    guard let image = i.document.get("image") as? Data else {return}
                    let id = i.document.documentID
                    self.messages.append(Message(id: id, sender: sender, msg: msg, image: image))
                }//.added
            }//forloop
        }//addSnapshot
    }//init
    func addInfo(msg: String, user: String, image: Data, date: Double){
        let db = Firestore.firestore()
        
        db.collection(K.FStore.collectionName).addDocument(data: [K.FStore.msgField: msg, K.FStore.senderField: user,
            K.FStore.imageField: image,
            K.FStore.dataField: Date().timeIntervalSince1970]){ (err) in
            if err != nil{
                print((err?.localizedDescription)!)
                return
            }else{
                print("Success")
                DispatchQueue.main.async {
                    self.write = ""
                }
                }
            
        }
    }
}
