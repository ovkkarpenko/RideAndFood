//
//  AddPhotoViewController.swift
//  RideAndFood
//
//  Created by Лаура Есаян on 24.10.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit
import AVFoundation
import MobileCoreServices

class AddPhotoViewController: UIViewController {
    @IBOutlet weak var addPhotoView: UIView!
    @IBOutlet weak var addPhotoButton: UIButton!
    @IBOutlet weak var infoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeAddPhotoView()
        customizeInfoLabel()
        
    }
    
    private func customizeAddPhotoView() {
        addPhotoView.layer.borderWidth = 1
        addPhotoView.layer.borderColor = Colors.getColor(.borderGray)().cgColor
        addPhotoView.layer.cornerRadius = 15
    }
    
    private func customizeInfoLabel() {
        infoLabel.text = "При необходимости прикрепите изображения"
        infoLabel.textColor = Colors.getColor(.textGray)()
    }
    
    @IBAction func addPhoto(_ sender: UIButton) {
        if AVCaptureDevice.authorizationStatus(for: AVMediaType.video) ==  AVAuthorizationStatus.authorized {
            callPicker()
        } else {
            AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { [weak self] (granted: Bool) -> Void in
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    
                    if granted {
                        self.callPicker()
                    } else {
                        let privacyInfo = UIAlertController(title: "Разрешите доступ", message: "Предоставьте приложению необходимые права доступа в настройках", preferredStyle: .alert)
                        
                        let settings = UIAlertAction(title: "Настройки", style: .default) { _ in
                            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:]) { _ in
                                privacyInfo.dismiss(animated: true, completion: nil)
                            }
                        }
                        
                        privacyInfo.addAction(settings)
                        privacyInfo.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
                        self.present(privacyInfo, animated: true)
                    }
                }
            })
        }
    }
    
    private func callPicker() {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            presentPhotoPicker(sourceType: .photoLibrary)
            return
        }
        
        let picker = UIAlertController()
        let takePhoto = UIAlertAction(title: "Снять фото или видео", style: .default) { [unowned self] _ in
            self.presentPhotoPicker(sourceType: .camera)
        }
        let choosePhoto = UIAlertAction(title: "Медиатека", style: .default) { [unowned self] _ in
            self.presentPhotoPicker(sourceType: .photoLibrary)
        }
        
        picker.addAction(takePhoto)
        picker.addAction(choosePhoto)
        picker.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        
        present(picker, animated: true)
    }
    
}

extension AddPhotoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func presentPhotoPicker(sourceType: UIImagePickerController.SourceType) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.allowsEditing = true
        pickerController.sourceType = sourceType
        pickerController.mediaTypes = [kUTTypeMovie as String, kUTTypeImage as String]
        present(pickerController, animated: true, completion: nil)
    }
    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        guard let url = info[UIImagePickerController.InfoKey.mediaURL] as? URL else {
//            return
//        }
//                if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
//        //            imageView.image = image
//        //            updateClassifications(for: image)
//                } else if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
//        //            imageView.image = editedImage
//        //            updateClassifications(for: editedImage)
//                }
//
//        dismiss(animated: true, completion: nil)
//    }
}
