//
//  ImageSaver.swift
//  Instafilter
//
//  Created by Kiran Sonne on 28/11/22.
//


import UIKit
import SwiftUI
class ImageSaver: NSObject {
    var successHandler: (() -> Void)?
    var errorHandler: ((Error) -> Void)?
    
    
    func writeToPhotoAlbum(image: UIImage){
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveComplete), nil)
        
    }
    @objc func saveComplete(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer){
        if let error = error {
            errorHandler?(error)
        } else {
            successHandler?()
        }
        
         
    }
}
