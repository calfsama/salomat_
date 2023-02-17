//
//  ReceiptViewController.swift
//  Salomat
//
//  Created by Tomiris Negmatova on 01/09/22.
//

import UIKit
import Photos

class ReceiptViewController: UIViewController, UICollectionViewDelegateFlowLayout {
    var receiptCollectionView = ReceiptCollectionView()
    var imagePickerController = UIImagePickerController()
    var alert: UIAlertController!
    var imagesArray: [UIImage] = [
    UIImage(named: "image 6")!]
    
    struct Constants {
        static let backgroundAlphaTo:  CGFloat = 0.6
    }
    
    lazy var backgroundView: UIView = {
        let backgroundView = UIView()
        backgroundView.backgroundColor = .black
        backgroundView.alpha = 0
        return backgroundView
    }()
    
    lazy var alertView: UIView = {
        let alert = UIView()
        alert.backgroundColor = .white
        alert.layer.cornerRadius = 12
        alert.layer.masksToBounds = true
        return alert
    }()
    
    lazy var image: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "image 6")
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //checkPermissions()
        for var i in 0...imagesArray.count - 1 {
            print("qwerty", imagesArray[i])
            i += 1
        }
        
        hideKeyboardWhenTappedAround()
        view.backgroundColor = .white
        receiptCollectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        receiptCollectionView.register(ReceiptCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: ReceiptCollectionReusableView.identifier)
        receiptCollectionView.register(ReceiptHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ReceiptHeaderCollectionReusableView.identifier)
        receiptCollectionView.delegate = self
        receiptCollectionView.dataSource = self
        navigationItem.title = "Электронный рецепт"
        configureConstraints()
    }

    func configureConstraints() {
        view.addSubview(receiptCollectionView)

        NSLayoutConstraint.activate([

            receiptCollectionView.heightAnchor.constraint(equalToConstant: view.frame.size.height),
            receiptCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            receiptCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
     func uploadImage() {
         print("pressed")
        //let imageData: Data = image.image!.pngData()!
        //let imageStr: String = imageData.base64EncodedString()
         let boundary = UUID().uuidString
         //let imageData = image.image!.pngData()
         var imagesStr = [String]()
         for i in 0...imagesArray.count - 1 {
             let imageData: Data = imagesArray[i].jpegData(compressionQuality: 1)!
             imagesStr.append(imageData.base64EncodedString())
         }
         //let urlString: String = "imageStr=" + imageData
         let url = URL(string: "/recipes/store")
         var request = URLRequest(url: url!)
         //request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
         request.setValue("multipart/form-data", forHTTPHeaderField: "Content-Type")
         request.httpMethod = "POST"
         let parameters: [String: Any] = [
            "recipe_phone": "987305959",
            "recipe_name": "tom",
            "recipe_comment": "blah blah blah",
            "recipe_pics": "\(imagesStr)"
         ]
         guard let data = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
             return
         }
         let dataString: String = String(data: data, encoding: String.Encoding.utf8) ?? ""
         request.httpBody = dataString.data(using: .utf8)
         NSURLConnection.sendAsynchronousRequest(request, queue: .main, completionHandler: {(request, data, error) in
             guard let data = data else { return }
             let responseString: String = String(data: data, encoding: .utf8)!
             print("my_log" + responseString)
         })
    }
    
    
    // Open gallery
    @objc func gallery() {
        self.imagePickerController.sourceType = .photoLibrary
        self.imagePickerController.allowsEditing = true
        self.imagePickerController.delegate = self
        self.present(self.imagePickerController, animated: true, completion: nil)
    }
    private var myTargetView: UIView?
    
    // Create custom alert
    func showAlert(with title: String, message: String, on viewController: UIViewController) {
        guard let targetView = viewController.view else { return }
        myTargetView = targetView
        backgroundView.frame = targetView.bounds
        targetView.addSubview(backgroundView)
        targetView.addSubview(alertView)
        
        alertView.frame = CGRect(x: 40, y: -300, width: targetView.frame.size.width - 120, height: 300)
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        alertView.addSubview(titleLabel)
        
        let image = UIImageView()
        image.image = UIImage(named: "done")
        image.translatesAutoresizingMaskIntoConstraints = false
        alertView.addSubview(image)
        
        let button = UIButton()
        button.setTitle("Готово", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.layer.cornerRadius = 4
        button.layer.masksToBounds = true
        button.backgroundColor = UIColor(red: 0.118, green: 0.745, blue: 0.745, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(dismissAlert), for: .touchUpInside)
        alertView.addSubview(button)
        self.backgroundView.alpha = Constants.backgroundAlphaTo
        self.alertView.center = targetView.center
        
        // Constraints
        image.topAnchor.constraint(equalTo: alertView.topAnchor, constant: 30).isActive = true
        image.centerXAnchor.constraint(equalTo: alertView.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 20).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 16).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -16).isActive = true
        button.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30).isActive = true
        button.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 60).isActive = true
        button.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -60).isActive = true
        button.heightAnchor.constraint(equalToConstant: 45).isActive = true
    }
    
    @objc func dismissAlert() {
        guard let targetView = myTargetView else { return }
        self.alertView.frame = CGRect(x: 40, y: targetView.frame.size.height, width: targetView.frame.size.width - 80, height: 300)
        self.backgroundView.alpha = 0
        self.alertView.removeFromSuperview()
        self.backgroundView.removeFromSuperview()
    }
    
    @objc func didTapButton() {
        print("pressed1")
        showAlert(with: "Рецепт отправлен", message: "", on: self)
        let reg = MainTabBarViewController()
        reg.selectedIndex = 4
        let appDelegate = UIApplication.shared.delegate
        appDelegate?.window??.rootViewController = reg
        uploadImage()
       
    }
    
    func showAlert() {
        self.alert = UIAlertController(title: "", message: "Заполните поля", preferredStyle: UIAlertController.Style.alert)
        self.present(self.alert, animated: true, completion: nil)
        Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(dismissAlert), userInfo: nil, repeats: false)
    }

    @objc func dismissAlertController(){
        // Dismiss the alert from here
        self.alert.dismiss(animated: true, completion: nil)
    }
    
    @objc func uploadImages() {
        let imageData = image.image!.pngData()
        //let urlString: String = "imageStr=" + imageData
        let url = URL(string: "http://slomat2.colibri.tj/recipes/store")
        var request = URLRequest(url: url!)
        //request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.setValue("multipart/form-data", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
    }

//    func checkPermissions() {
//        if PHPhotoLibrary.authorizationStatus() != PHAuthorizationStatus.authorized {
//            PHPhotoLibrary.requestAuthorization({ (status: PHAuthorizationStatus) -> Void in()
//            })
//        }
//        if PHPhotoLibrary.authorizationStatus() == PHAuthorizationStatus.authorized {
//        }
//        else {
//            PHPhotoLibrary.requestAuthorization(requestAuthorizationHandler)
//        }
//    }
//
//    func requestAuthorizationHandler(status: PHAuthorizationStatus) {
//        if PHPhotoLibrary.authorizationStatus() == PHAuthorizationStatus.authorized {
//            print("Access granted to use Photo Library")
//        }
//        else {
//            print("We don't use access to your Photos")
//        }
//    }
    
//    func uploadImage(paramName: [String:String], fileName: String, image: UIImage) {
//        let url = URL(string: "http://slomat2.colibri.tj/recipes/store")
//        print(url)
//
//        // generate boundary string using a unique per-app string
//        let boundary = UUID().uuidString
//
//        let session = URLSession.shared
//
//        // Set the URLRequest to POST and to the specified URL
//        var urlRequest = URLRequest(url: url!)
//        urlRequest.httpMethod = "POST"
//
//        // Set Content-Type Header to multipart/form-data, this is equivalent to submitting form data with file upload in a web browser
//        // And the boundary is also set here
//        urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
//
//        var data = Data()
//        //image = imagesArray
//        // Add the image data to the raw http request data
//        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
//        data.append("Content-Disposition: form-data; name=\"\(paramName)\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
//        data.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
////        for var i in 1...imagesArray.count {
////            data.append(imagesArray[i].pngData()!)
////            i += 1
////        }
//        data.append(image.pngData()!)
//
//        data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
//
//        // Send a POST request to the URL, with the data we created earlier
//        session.uploadTask(with: urlRequest, from: data, completionHandler: { responseData, response, error in
//            if error == nil {
//                let jsonData = try? JSONSerialization.jsonObject(with: responseData!, options: .allowFragments)
//                if let json = jsonData as? [String: Any] {
//                    print(json)
//                }
//            }
//            else {
//                print(error)
//            }
//        }).resume()
//    }

//

}
extension ReceiptViewController: UICollectionViewDelegate, UICollectionViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as! PhotoCollectionViewCell
        if indexPath.row >= 1 {
            cell.photo.layer.borderColor = UIColor(red: 0.738, green: 0.741, blue: 1, alpha: 1).cgColor
            cell.photo.layer.borderWidth = 1
            cell.cancelButton.layer.setValue(indexPath.row, forKey: "index")
            cell.cancelButton.addTarget(self, action: #selector(deleteUser), for: .touchUpInside)
            cell.cancelButton.setImage(UIImage(named: "cancel"), for: .normal)
        }
        else if indexPath.row == 0 {
            cell.cancelButton.layer.setValue(indexPath.row, forKey: "index")
            cell.cancelButton.addTarget(self, action: #selector(empty), for: .touchUpInside)
            cell.cancelButton.setImage(UIImage(named: ""), for: .normal)
            cell.photo.layer.borderWidth = 0
        }
        cell.photo.layer.cornerRadius = 4
        cell.photo.layer.masksToBounds = true
        cell.photo.image = imagesArray[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ReceiptHeaderCollectionReusableView.identifier, for: indexPath) as! ReceiptHeaderCollectionReusableView
            header.configure()
            return header
            
        case UICollectionView.elementKindSectionFooter:
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: ReceiptCollectionReusableView.identifier, for: indexPath) as! ReceiptCollectionReusableView
            if footer.phoneTextField.text != "" && footer.nameTextField.text != "" && footer.commentTextField.text != ""{
                footer.button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
            }
            footer.button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
            return footer
            
        default:
            assert(false, "Unexpected element kind")
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 55)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height - 380)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width / 3 * 0.8  , height: 90)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            gallery()
        }
    }
    
    @objc func deleteUser(sender:UIButton) {
        let i : Int = (sender.layer.value(forKey: "index")) as! Int
        let objectToDelete = imagesArray.remove(at: i)
        receiptCollectionView.reloadData()
    }
    
    @objc func empty() {
        
    }
    
    func imageUploadRequest(imageView imageView: UIImage, uploadUrl: NSURL, param: [String:String]?) {
        
        //let myUrl = NSURL(string: "http://192.168.1.103/upload.photo/index.php");
        
        let request = NSMutableURLRequest(url: uploadUrl as URL);
        request.httpMethod = "POST"
        
        let boundary = generateBoundaryString()
        
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        let imageData = imageView.jpegData(compressionQuality: 1)
        
        if(imageData==nil)  { return; }
        
        request.httpBody = createBodyWithParameters(parameters: param, filePathKey: "file", imageDataKey: imageData! as NSData, boundary: boundary) as Data
        
        //myActivityIndicator.startAnimating();
        
        let task =  URLSession.shared.dataTask(with: request as URLRequest,
                                               completionHandler: {
            (data, response, error) -> Void in
            if let data = data {
                
                // You can print out response object
                print("******* response = \(response)")
                
                // print(data.length)
                // you can use data here
                
                // Print out reponse body
                let responseString = NSString(data: data, encoding: NSUTF8StringEncoding)
                print("****** response data = \(responseString!)")
                
                let json =  try! JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary
                
                print("json value \(json)")
                
                
            } else if let error = error {
                //print(error.description)
            }
        })
        task.resume()
    }


    // extension for impage uploading
    
    func createBodyWithParameters(parameters: [String: String]?, filePathKey: String?, imageDataKey: NSData, boundary: String) -> NSData {
        let body = NSMutableData();
        
        if parameters != nil {
            for (key, value) in parameters! {
                body.appendString(string: "--\(boundary)\r\n")
                body.appendString(string: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString(string: "\(value)\r\n")
            }
        }
        
        let filename = "user-profile.jpg"
        
        let mimetype = "image/jpg"
        
        body.appendString(string: "--\(boundary)\r\n")
        body.appendString(string: "Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n")
        body.appendString(string: "Content-Type: \(mimetype)\r\n\r\n")
        body.append(imageDataKey as Data)
        body.appendString(string: "\r\n")
        
        body.appendString(string: "--\(boundary)--\r\n")
        
        return body
    }
    
    func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedimage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            imagesArray += [pickedimage]
            print("hello", pickedimage.pngData())
            for var i in 0...imagesArray.count - 1 {
                print("qwerty", imagesArray[i])
                i += 1
            }
            receiptCollectionView.reloadData()
        }
        else {
            print("something went wrong...")
        }
        picker.dismiss(animated: true, completion: nil)
    }
}

extension NSMutableData {

    func appendString(string: String) {
        let data = string.data(using: String.Encoding(rawValue: NSUTF8StringEncoding), allowLossyConversion: true)
        append(data!)
    }
}


