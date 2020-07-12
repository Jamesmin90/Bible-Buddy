	//
//  ImagePicker.swift
//  Bible Buddy
//
//  Created by Jannis Gutleben on 11.06.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import SwiftUI

struct ImagePicker1 : View {
    @Binding var image: UIImage?
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
           ImagePickerViewController(presentationMode: presentationMode,image: $image)
} }

struct ImagePicker_Previews: PreviewProvider {
    static var previews: some View {
        //ImagePicker(image: <#T##Binding<UIImage?>#>)
        Text("test")
    }
}
