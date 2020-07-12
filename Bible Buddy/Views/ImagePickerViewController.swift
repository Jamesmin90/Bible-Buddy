//
//  ImagePickerViewController.swift
//  Bible Buddy
//
//  Created by Jannis Gutleben on 11.06.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import SwiftUI

struct ImagePickerViewController: UIViewControllerRepresentable {
    
    @Binding var presentationMode: PresentationMode
    @Binding var image: UIImage?
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePickerViewController>) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.allowsEditing = false
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController:
        UIImagePickerController,
                                context:
        UIViewControllerRepresentableContext<ImagePickerViewController>) {
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: ImagePickerViewController
        
        init(_ parent: ImagePickerViewController) {
            self.parent = parent
            
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }
            parent.presentationMode.dismiss()
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.dismiss()
        }
    }
    
}


struct ImagePickerViewController_Previews: PreviewProvider {
    static var previews: some View {
        //ImagePickerViewController()
        Text("test")
    }
}
