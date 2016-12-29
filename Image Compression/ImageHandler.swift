//
//  ImageHandler.swift

//  Created by Sarath R on 28/12/16.
//  Copyright © 2016 SarathR. All rights reserved.
//

import UIKit

class ImageHandler {
    
    func compressImage(image: UIImage, compressRatio ratio: CGFloat) -> UIImage {
        
        return self.compressImage(image: image, compressRatio: ratio, maxCompressRatio: 0.1)
    }
    
    private func compressImage(image: UIImage, compressRatio ratio: CGFloat, maxCompressRatio maxRatio: CGFloat) -> UIImage {
        
        var _image: UIImage = image
        
        // We define the max and min resolutions to shrink to
        let MIN_UPLOAD_RESOLUTION = 1136 * 640
        let MAX_UPLOAD_SIZE = 50
        
        var factor: CGFloat?
        let currentResolution = _image.size.height * _image.size.width
        
        
        // We first shrink the image a little bit in order to compress it a little bit more
        if currentResolution > CGFloat(MIN_UPLOAD_RESOLUTION) {
            
            let _sqrt = sqrt(CGFloat(currentResolution) / CGFloat(MIN_UPLOAD_RESOLUTION))
            factor = _sqrt * 2.0
            _image = self.scaleDown(image: _image, withSize: CGSize(width: _image.size.width / factor!, height: _image.size.height / factor!))
        }
        
        
        //Compression settings
        var compression: CGFloat = ratio
        let maxCompression: CGFloat = maxRatio
        
        //We loop into the image data to compress accordingly to the compression ratio
        var imageData = UIImageJPEGRepresentation(_image, compression)
        while ((imageData?.count)! > MAX_UPLOAD_SIZE && compression > maxCompression) {
            compression -= 0.10
            imageData = UIImageJPEGRepresentation(_image, compression)
        }
        
        //Retuns the compressed image
        return UIImage(data: imageData!)!
        
    }
    
    private func compressRemoteImage(url: String, compressRatio ratio: CGFloat, maxCompressRatio maxRatio: CGFloat) -> UIImage {
        
        do {
            //Parse the URL
            let imageURL = URL(string: url)
            
            //We init the image with the rmeote data
            let remoteImage: UIImage = try UIImage(data: Data(contentsOf: imageURL!))!
            
            //Returns the remote image compressed
            return self.compressImage(image: remoteImage, compressRatio: ratio, maxCompressRatio: maxRatio)
            
        }
        catch let error {
            print("Image Handler reports -> Got some error -> compressRemoteImage: \(error)")
        }
        
        return UIImage()
    }
    
    
    private func compressRemoteImage(url: String, compressRatio ratio: CGFloat) -> UIImage {
        
        return self.compressRemoteImage(url: url, compressRatio: ratio, maxCompressRatio: 0.1)
    }
    
    
    private func scaleDown(image: UIImage, withSize newSize: CGSize) -> UIImage {
        
        //We prepare a bitmap with the new size
        UIGraphicsBeginImageContextWithOptions(newSize, true, 0.0)
        
        //Draws a rect for the image
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
       
        //We set the scaled image from the context
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage!
    }
    
}
