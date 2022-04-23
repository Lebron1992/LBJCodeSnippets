import MobileCoreServices
import UIKit

extension UIViewController {
  @objc
  open func didPickEditedImage(_ image: UIImage) { }

  @objc
  open func didPickOriginalImage(_ image: UIImage) { }

  @objc
  open func didPickVideo(_ video: URL) { }

  @objc
  open func imagePickerControllerDidCancel() { }
}

extension UIViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
  public enum MediaType {
    case image
    case video
    case any

    var typeStrings: [String] {
      switch self {
      case .image: return [kUTTypeImage as String]
      case .video: return [kUTTypeVideo as String]
      case .any: return [kUTTypeImage as String, kUTTypeVideo as String]
      }
    }
  }

  public func presentMediaOptions(
    withTitle title: String? = nil,
    mediaType: MediaType = .image,
    allowsEditing: Bool = true,
    delegate: (UIImagePickerControllerDelegate & UINavigationControllerDelegate)? = nil
  ) {
    if UIImagePickerController.isSourceTypeAvailable(.camera) {
      let optionMenu = UIAlertController(
        title: title,
        message: "",
        preferredStyle: .actionSheet
      )
      optionMenu.popoverPresentationController?.sourceView = view
      optionMenu.popoverPresentationController?.sourceRect = CGRect(
        x: view.bounds.midX,
        y: view.bounds.midY,
        width: 0,
        height: 0
      )
      optionMenu.popoverPresentationController?.permittedArrowDirections = []

      let libraryAction = UIAlertAction(
        title: "Choose from library",
        style: .default,
        handler: { (_) in
          self.presentImagePickerController(
            with: .photoLibrary,
            mediaTypes: mediaType.typeStrings,
            allowsEditing: allowsEditing,
            delegate: delegate
          )
        }
      )
      let cameraAction = UIAlertAction(
        title: "Take photo",
        style: .default,
        handler: { (_) in
          self.presentImagePickerController(
            with: .camera,
            mediaTypes: mediaType.typeStrings,
            allowsEditing: allowsEditing,
            delegate: delegate
          )
        }
      )
      let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
      optionMenu.addAction(libraryAction)
      optionMenu.addAction(cameraAction)
      optionMenu.addAction(cancelAction)
      present(optionMenu, animated: true, completion: nil)
    } else {
      presentImagePickerController(
        with: .photoLibrary,
        mediaTypes: mediaType.typeStrings,
        allowsEditing: allowsEditing,
        delegate: delegate
      )
    }
  }

  public func imagePickerController(
    _ picker: UIImagePickerController,
    didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]
  ) {
    guard let type = info[UIImagePickerController.InfoKey.mediaType] as? String else {
      return
    }

    if type == kUTTypeImage as String {

      if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
        didPickOriginalImage(originalImage)
      }
      if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
        didPickEditedImage(editedImage)
      }

    } else if type == kUTTypeMovie as String ||
                type == kUTTypeVideo as String,
              let pickedVideoPath = info[UIImagePickerController.InfoKey.mediaURL] as? URL {

      didPickVideo(pickedVideoPath)
    }
  }

  public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    imagePickerControllerDidCancel()
  }

  private func presentImagePickerController(
    with sourceType: UIImagePickerController.SourceType,
    mediaTypes: [String],
    allowsEditing: Bool = true,
    delegate: (UIImagePickerControllerDelegate & UINavigationControllerDelegate)? = nil
  ) {
    let picker = UIImagePickerController()
    picker.delegate = delegate ?? self
    picker.allowsEditing = allowsEditing
    picker.sourceType = sourceType
    picker.mediaTypes = mediaTypes
    present(picker, animated: true, completion: nil)
  }
}
