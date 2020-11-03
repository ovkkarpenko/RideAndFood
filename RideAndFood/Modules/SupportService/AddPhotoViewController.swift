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
import Photos

class AddPhotoViewController: UIViewController {
    @IBOutlet weak var addPhotoView: UIView!
    @IBOutlet weak var sendButton: CustomButton!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var photoCollectionView: UICollectionView!
    @IBOutlet weak var responseMessageView: UIView!
    @IBOutlet weak var requestSentMessageLabel: UILabel!
    @IBOutlet weak var requestSentMessageDescriptionLabel: UILabel!
    
    private var photos: [UIImage] = []
    var message: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = SupportServiceString.getString(.supportServiceTitle)()
        
        customizeAddPhotoView()
        customizeInfoLabel()
        customizeAddPhotoButton()
        customizeRequestSentMessageLabel()
        customizeRequestSentMessageDescriptionLabel()
    }
    
    private func customizeAddPhotoView() {
        addPhotoView.layer.borderWidth = 1
        addPhotoView.layer.borderColor = Colors.getColor(.borderGray)().cgColor
        addPhotoView.layer.cornerRadius = generalCornerRaduis
    }
    
    private func customizeInfoLabel() {
        infoLabel.text = SupportServiceString.getString(.photoAdderDescription)()
        infoLabel.textColor = Colors.getColor(.textGray)()
    }
    
    private func customizeAddPhotoButton() {
        sendButton.customizeButton(type: .blueButton)
        sendButton.setTitle(SupportServiceString.getString(.sendButton)(), for: .normal)
    }
    
    private func customizeRequestSentMessageLabel() {
        requestSentMessageLabel.text = SupportServiceString.getString(.requestSentMessage)()
        requestSentMessageLabel.textColor = Colors.getColor(.buttonGreen)()
    }
    
    private func customizeRequestSentMessageDescriptionLabel() {
        requestSentMessageDescriptionLabel.text = SupportServiceString.getString(.requestSentMessageDescription)()
        requestSentMessageDescriptionLabel.textColor = Colors.getColor(.textGray)()
    }
    
    @IBAction func send(_ sender: Any) {
        if responseMessageView.isHidden {
            let model = SupportResponseModel(message: message)
            let request = RequestModel(path: supportPath, method: .post, body: model)
            let networker = Networker()

            networker.makeRequest(request: request, images: photos) { [weak self] (results: [SupportResponseModel]?, error: RequestErrorModel?) in
                guard let self = self else { return }
                
//                if let results = results {
//                    print(results)
//                }

                if let error = error {
                    print(error.message)
                    if error.response == .allRight {
                        self.addPhotoView.isHidden = true
                        self.photoCollectionView.isHidden = true
                        self.responseMessageView.isHidden = false
                        self.sendButton.setTitle(SupportServiceString.getString(.great)(), for: .normal)
                        self.navigationItem.setHidesBackButton(true, animated: true)
                    }
                }
            }
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func addPhoto(_ sender: UIButton) {
        if PHPhotoLibrary.authorizationStatus() == .authorized {
            callPicker()
        } else {
            PHPhotoLibrary.requestAuthorization {  [weak self] (granted: PHAuthorizationStatus) in
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    
                    if granted == .authorized {
                        self.callPicker()
                    } else {
                        let privacyInfo = UIAlertController(title: SupportServiceString.getString(.allowAccess)(), message: SupportServiceString.getString(.allowAccessMessage)(), preferredStyle: .alert)
                        
                        let settings = UIAlertAction(title: SupportServiceString.getString(.settings)(), style: .default) { _ in
                            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:]) { _ in
                                privacyInfo.dismiss(animated: true, completion: nil)
                            }
                        }
                        
                        privacyInfo.addAction(settings)
                        privacyInfo.addAction(UIAlertAction(title: SupportServiceString.getString(.cancelButton)(), style: .cancel, handler: nil))
                        self.present(privacyInfo, animated: true)
                    }
                }
            }
        }
    }
    
    private func callPicker() {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            presentPhotoPicker(sourceType: .photoLibrary)
            return
        }
        
        let picker = UIAlertController()
        
        let takePhoto = UIAlertAction(title: SupportServiceString.getString(.takePhoto)(), style: .default) { [unowned self] _ in
            self.presentPhotoPicker(sourceType: .camera)
        }
        
        takePhoto.setValue(UIImage(systemName: "camera.fill"), forKey: "image")
        
        let choosePhoto = UIAlertAction(title: SupportServiceString.getString(.mediaLibrary)(), style: .default) { [unowned self] _ in
            self.presentPhotoPicker(sourceType: .photoLibrary)
        }
        choosePhoto.setValue(UIImage(systemName: "rectangle.on.rectangle"), forKey: "image")
        
        picker.addAction(takePhoto)
        picker.addAction(choosePhoto)
        picker.addAction(UIAlertAction(title: SupportServiceString.getString(.cancelButton)(), style: .cancel, handler: nil))
        
        present(picker, animated: true)
    }
    
}

// MARK: - extensions
extension AddPhotoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func presentPhotoPicker(sourceType: UIImagePickerController.SourceType) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.allowsEditing = true
        pickerController.sourceType = sourceType
        pickerController.mediaTypes = [kUTTypeMovie as String, kUTTypeImage as String]
        present(pickerController, animated: true, completion: nil)
    }
    
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let url = info[UIImagePickerController.InfoKey.mediaURL] as? URL {
            if let image = videoPreviewImage(url: url) {
                photos.append(image)
                photoCollectionView.reloadData()
                
            }
        }
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            photos.append(image)
            photoCollectionView.reloadData()
        } else if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            photos.append(editedImage)
            photoCollectionView.reloadData()
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    private func videoPreviewImage(url: URL) -> UIImage? {
        let asset = AVURLAsset(url: url)
        let generator = AVAssetImageGenerator(asset: asset)
        generator.appliesPreferredTrackTransform = true
        if let cgImage = try? generator.copyCGImage(at: CMTime(seconds: 2, preferredTimescale: 60), actualTime: nil) {
            return UIImage(cgImage: cgImage)
        }
        else {
            return nil
        }
    }
}

extension AddPhotoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCollection", for: indexPath) as? PhotoCollectionViewCell else { fatalError() }
        
        cell.imageView.image = photos[indexPath.row]
        
        cell.removeButton.tag = indexPath.row
        cell.removeButton.addTarget(self, action: #selector(removePhoto), for: .touchUpInside)
        
        return cell
    }
    
    @objc private func removePhoto(sender: UIButton) {
        let index = sender.tag
        
        photos.remove(at: index)
        photoCollectionView.reloadData()
    }
}

class PhotoCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var removeButton: UIButton!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.layer.cornerRadius = generalCornerRaduis
    }
}
