import MobileCoreServices
import UIKit

extension UIViewController {
  @objc
  public func didPickEditedImage(_ image: UIImage) { }

  @objc
  public func didPickOriginalImage(_ image: UIImage) { }

  @objc
  public func didPickVideo(_ video: URL) { }
}

extension UIViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
  public func presentMediaOptions(withTitle title: String? = nil, mediaTypes: [String] = [kUTTypeImage as String], allowsEditing: Bool = true) {
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
            mediaTypes: mediaTypes,
            allowsEditing: allowsEditing
          )
        }
      )
      let cameraAction = UIAlertAction(
        title: "Take photo",
        style: .default,
        handler: { (_) in
          self.presentImagePickerController(
            with: .camera,
            mediaTypes: mediaTypes,
            allowsEditing: allowsEditing
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
        mediaTypes: mediaTypes,
        allowsEditing: allowsEditing
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
    dismiss(animated: true, completion: nil)
  }

  public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    dismiss(animated: true, completion: nil)
  }

  private func presentImagePickerController(
    with sourceType: UIImagePickerController.SourceType,
    mediaTypes: [String],
    allowsEditing: Bool = false
  ) {
    let picker = UIImagePickerController()
    picker.delegate = self
    picker.allowsEditing = allowsEditing
    picker.sourceType = sourceType
    picker.mediaTypes = mediaTypes
    present(picker, animated: true, completion: nil)
  }
}
