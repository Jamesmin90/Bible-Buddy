//
//  FirestorageImageUploader.swift
//  Bible Buddy
//
//  Created by jag on 12.06.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import Foundation
import Combine
import FirebaseStorage

struct ImageUploadService {
    
    
    static func upload(for image: UIImage,to path: String = "Blogs", completion: @escaping (_ result: String) -> () ) {
        let imageRef = Storage.storage().reference().child(path).child(UUID().uuidString)
        uploadImage(image: image, reference: imageRef) { (downloadURL) in
            guard let downloadURL = downloadURL else {
                return
            }

            let data = downloadURL.absoluteString
            print("image url: \(data)")
            completion(data)
        }
    }
    
    
    static func uploadImage(image: UIImage, reference: StorageReference, completion: @escaping (URL?) -> Void) {

        guard let imageData = image.jpegData(compressionQuality: 0.1) else {
            return completion(nil)
        }
        
        reference.putData(imageData, metadata: nil, completion: { (metadata, error) in

            if let error = error {
                assertionFailure(error.localizedDescription)
                return completion(nil)
            }
            
            reference.downloadURL(completion: { (url, error) in
                if let error = error {
                    assertionFailure(error.localizedDescription)
                    return completion(nil)
                }
                completion(url)
            })
        })
    }
}



