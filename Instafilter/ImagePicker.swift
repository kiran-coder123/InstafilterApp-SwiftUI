//
//  ImagePicker.swift
//  Instafilter
//
//  Created by Kiran Sonne on 28/11/22.
//

import Foundation
import PhotosUI
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    class Coordinator: NSObject, PHPickerViewControllerDelegate{
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
             //tell picker to go away
            picker.dismiss(animated: true, completion: nil)
            
            // exit if no selection was made
            guard let provider  =  results.first?.itemProvider else { return}
            
            // if this has an image we can use, use it
            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { image, _ in
                    self.parent.image  = image as? UIImage
                }
            }
        }
        
        var parent: ImagePicker
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
    }
    @Binding var image: UIImage?
 typealias UIViewControllerType = PHPickerViewController
    
   

    func makeUIViewController(context: Context) -> PHPickerViewController {
        
        var config = PHPickerConfiguration()
        config.filter = .images
        
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
         
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}
