import UIKit

public extension UIImage {
  func crop(to aspectRatio: CGSize) -> UIImage? {
    // Calculate the target width and height based on the aspect ratio
    let targetWidth = size.height * aspectRatio.width / aspectRatio.height
    let targetHeight = size.width * aspectRatio.height / aspectRatio.width
    
    // Determine the crop rectangle
    var cropRect: CGRect
    if targetWidth > size.width {
      // Crop based on height
      let yOffset = (size.height - targetHeight) / 2
      cropRect = CGRect(x: 0, y: yOffset, width: size.width, height: targetHeight)
    } else {
      // Crop based on width
      let xOffset = (size.width - targetWidth) / 2
      cropRect = CGRect(x: xOffset, y: 0, width: targetWidth, height: size.height)
    }

    // Ensure the crop rectangle is within the bounds of the image
    cropRect = cropRect.intersection(CGRect(origin: .zero, size: size))

    // Crop the image
    guard let cgImage = self.cgImage?.cropping(to: cropRect) else {
      return nil
    }

    return UIImage(cgImage: cgImage, scale: scale, orientation: imageOrientation)
  }
}
