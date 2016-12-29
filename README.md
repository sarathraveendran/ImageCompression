# ImageCompression

============================================================================================  

Compress your image size with just one line of code.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
1. Add    -> "ImageHandler.swift" file in your project 
2. Usage  -> let newImage = ImageHandler().compressImage(image: "Your-Image-Name", compressRatio: 0.9)

~~~~~~~~~~~~~~~~~~~~~~~~~
Thats it.. Happy Coding :)


Highlights
~~~~~~~~~~
1. Reduces size around 60% to 90% of original size or more -> 23MB to 600KB
2. Quality stabilization

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Detailed Sample

// Orginal Image
let image = UIImage(named: "Your-Image-Name")

// Prints size of your original Image
let imgData: NSData = NSData(data: UIImagePNGRepresentation(image)!)
let imageSize: Double = Double(imgData.length)
print("Size of choosen image in MB:  \((imageSize / 1024.0 ) / 1024.0))")
        
// Compressed image almost a 90% reduction
let compressedImage =  ImageHandler().compressImage(image: image, compressRatio: 0.9)

// Prints the size of the compressed Image
let compressedImageData = NSData(data: UIImageJPEGRepresentation(compressedImage, 1)!)
let imageSize: Double = Double(compressedImageData.length)
print("Compressed size: \((imageSize / 1024.0 ) / 1024.0))")
============================================================================================         
