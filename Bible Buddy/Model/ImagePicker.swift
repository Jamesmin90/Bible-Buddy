//
//  ImagePicker.swift
//  Bible Buddy
//
//  Created by James on 13.06.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import SwiftUI

struct ImagePicker : UIViewControllerRepresentable {
    
    @Binding var picker : Bool
    @Binding var imagedata : Data
    @Binding var presentationMode: PresentationMode
    
    func makeCoordinator() -> Coordinator {
        
        return Coordinator(self)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        
        let picker = UIImagePickerController()
        picker.sourceType = UIImagePickerController.SourceType.photoLibrary
        picker.allowsEditing = false
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
        
        
    }
    
    class Coordinator : NSObject,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
        
        var parent : ImagePicker
        
        init(_ parent1 : ImagePicker) {
            
            parent = parent1
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            
            self.parent.picker.toggle()
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            
            if let image = info[.originalImage] as? UIImage {
                
                let data = image.jpegData(compressionQuality: 0.1)
                self.parent.imagedata = data!
            }
            self.parent.picker = false
        }
            
            
            
            
            
            
            
            
        }
    }
    



