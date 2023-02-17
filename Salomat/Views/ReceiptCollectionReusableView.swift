//
//  ReceiptCollectionReusableView.swift
//  Salomat
//
//  Created by Tomiris Negmatova on 29/11/22.
//

import UIKit
import MobileCoreServices
import UniformTypeIdentifiers

class ReceiptCollectionReusableView: UICollectionReusableView {
    static let identifier = "ReceiptCollectionReusableView"
    var messangerButton = MessangerCollectionView()
    var imagesArray = [String]()
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 0.118, green: 0.745, blue: 0.745, alpha: 1)
        button.setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        button.setTitle("Отправить рецепт", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        button.layer.cornerRadius = 4
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var or: UILabel = {
        let label = UILabel()
        label.text = "или"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = UIColor(red: 0.22, green: 0.208, blue: 0.325, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var sendPhoto: UILabel = {
        let label = UILabel()
        label.text = "отправить фото рецепта по мессенджеру"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = UIColor(red: 0.478, green: 0.463, blue: 0.617, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var uiView: UIView = {
        let uiView = UIView()
        uiView.backgroundColor = UIColor(red: 0.738, green: 0.741, blue: 1, alpha: 1)
        uiView.layer.cornerRadius = 4
        uiView.translatesAutoresizingMaskIntoConstraints = false
        return uiView
    }()
    
    lazy var uiView2: UIView = {
        let uiView = UIView()
        uiView.backgroundColor = UIColor(red: 0.738, green: 0.741, blue: 1, alpha: 1)
        uiView.layer.cornerRadius = 4
        uiView.translatesAutoresizingMaskIntoConstraints = false
        return uiView
    }()
    
    lazy var phoneTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Телефон"
        textField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        textField.returnKeyType = .next
        textField.keyboardType = .phonePad
        textField.leftViewMode = .always
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.layer.cornerRadius = 4
        textField.layer.borderWidth = 1
        textField.layer.masksToBounds = true
        textField.layer.borderColor = UIColor(red: 0.929, green: 0.93, blue: 1, alpha: 1).cgColor
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Имя и фамилия"
        textField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        textField.returnKeyType = .next
        textField.leftViewMode = .always
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.layer.cornerRadius = 4
        textField.layer.borderWidth = 1
        textField.layer.masksToBounds = true
        textField.layer.borderColor = UIColor(red: 0.929, green: 0.93, blue: 1, alpha: 1).cgColor
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var commentTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Комментарий"
        textField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        textField.returnKeyType = .next
        textField.leftViewMode = .always
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.layer.cornerRadius = 4
        textField.layer.borderWidth = 1
        textField.layer.masksToBounds = true
        textField.layer.borderColor = UIColor(red: 0.929, green: 0.93, blue: 1, alpha: 1).cgColor
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        messangerButton.set(cell: Messenger.items())
        configureConstraints()
    }
    
    func configureConstraints() {
        
        addSubview(phoneTextField)
        addSubview(nameTextField)
        addSubview(commentTextField)
        addSubview(button)
        addSubview(or)
        addSubview(uiView)
        addSubview(uiView2)
        addSubview(messangerButton)
        addSubview(sendPhoto)
        
        
        NSLayoutConstraint.activate([
            
            phoneTextField.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            phoneTextField.leadingAnchor.constraint(equalTo: leadingAnchor),
            phoneTextField.trailingAnchor.constraint(equalTo: trailingAnchor),
            phoneTextField.heightAnchor.constraint(equalToConstant: 45),
            
            nameTextField.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: 10),
            nameTextField.leadingAnchor.constraint(equalTo: leadingAnchor),
            nameTextField.trailingAnchor.constraint(equalTo: trailingAnchor),
            nameTextField.heightAnchor.constraint(equalToConstant: 45),
            
            commentTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 10),
            commentTextField.leadingAnchor.constraint(equalTo: leadingAnchor),
            commentTextField.trailingAnchor.constraint(equalTo: trailingAnchor),
            commentTextField.heightAnchor.constraint(equalToConstant: 80),
            
            button.topAnchor.constraint(equalTo: commentTextField.bottomAnchor, constant: 10),
            button.leadingAnchor.constraint(equalTo: leadingAnchor),
            button.trailingAnchor.constraint(equalTo: trailingAnchor),
            button.heightAnchor.constraint(equalToConstant: 45),
            
            or.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 25),
            or.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            or.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            uiView.centerYAnchor.constraint(equalTo: or.centerYAnchor),
            uiView.leadingAnchor.constraint(equalTo: leadingAnchor),
            uiView.widthAnchor.constraint(equalToConstant: frame.size.width / 2 * 0.84),
            uiView.heightAnchor.constraint(equalToConstant: 0.7),
            
            uiView2.centerYAnchor.constraint(equalTo: or.centerYAnchor),
            uiView2.trailingAnchor.constraint(equalTo: trailingAnchor),
            uiView2.widthAnchor.constraint(equalToConstant: frame.size.width / 2 * 0.84),
            uiView2.heightAnchor.constraint(equalToConstant: 0.7),
            
            messangerButton.topAnchor.constraint(equalTo: or.bottomAnchor, constant: 25),
            messangerButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            messangerButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            messangerButton.heightAnchor.constraint(equalToConstant: 70),
            
            sendPhoto.topAnchor.constraint(equalTo: messangerButton.bottomAnchor, constant: 20),
            sendPhoto.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            sendPhoto.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
    
    // - MARK: POST REQUEST
    
    func createRequest(phone: String, name: String, comment: String) throws -> URLRequest {
        let parameters = [
            "recipe_phone"  : phone,
            "recipe_name"    : name,
            "recipe_comment" : comment]
        
        let boundary = generateBoundaryString()
        
        let url = URL(string: "http://374315-ca17278.tmweb.ru/recipes/store")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        let fileURL = Bundle.main.url(forResource: "image 3", withExtension: "png")!
        request.httpBody = try createBody(with: parameters, filePathKey: "file", urls: [fileURL], boundary: boundary)
        
        return request
    }
    
    @objc func sendRequest() {
        let request: URLRequest

        do {
            request = try createRequest(phone: phoneTextField.text!, name: nameTextField.text!, comment: commentTextField.text!)
        } catch {
            print(error)
            return
        }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                // handle error here
                print(error ?? "Unknown error")
                return
            }
        }
        task.resume()
    }
    
    /// Create body of the `multipart/form-data` request
    ///
    /// - parameter parameters:   The optional dictionary containing keys and values to be passed to web service.
    /// - parameter filePathKey:  The optional field name to be used when uploading files. If you supply paths, you must supply filePathKey, too.
    /// - parameter urls:         The optional array of file URLs of the files to be uploaded.
    /// - parameter boundary:     The `multipart/form-data` boundary.
    ///
    /// - returns:                The `Data` of the body of the request.
    
    private func createBody(with parameters: [String: String]? = nil, filePathKey: String, urls: [URL], boundary: String) throws -> Data {
        var body = Data()
        
        parameters?.forEach { (key, value) in
            body.append("--\(boundary)\r\n")
            body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
            body.append("\(value)\r\n")
        }
        
        for url in urls {
            let filename = url.lastPathComponent
            let data = try Data(contentsOf: url)
            
            body.append("--\(boundary)\r\n")
            body.append("Content-Disposition: form-data; name=\"\(filePathKey)\"; filename=\"\(filename)\"\r\n")
            body.append("Content-Type: \(url.mimeType)\r\n\r\n")
            body.append(data)
            body.append("\r\n")
        }
        
        body.append("--\(boundary)--\r\n")
        return body
    }
    
    /// Create boundary string for multipart/form-data request
    ///
    /// - returns:            The boundary string that consists of "Boundary-" followed by a UUID string.
    
    private func generateBoundaryString() -> String {
        return "Boundary-\(UUID().uuidString)"
    }
    
    
    // - MARK: OLD
    
    @objc func postRequestButton() {
        let url = URL(string: "http://374315-ca17278.tmweb.ru/users/check_phone")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "POST"
        let parameters: [String: Any] = [
            "recipe_phone": "\(phoneTextField.text)",
            "recipe_name": "\(nameTextField.text)",
            "recipe_comment": "\(commentTextField.text)",
            "recipe_pics": ""
        ]
        request.httpBody = parameters.percentEncoded()
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard
                let data = data,
                let response = response as? HTTPURLResponse,
                error == nil
            else {                                                               // check for fundamental networking error
                print("error", error ?? URLError(.badServerResponse))
                return
            }
            
            guard (200 ... 299) ~= response.statusCode else {                    // check for http errors
                print("statusCode should be 2xx, but is \(response.statusCode)")
                print("response = \(response)")
                return
            }
            
            // do whatever you want with the `data`, e.g.:
            
            do {
                let responseObject = try JSONDecoder().decode(CheckPhone.self, from: data)
                print(responseObject)
            } catch {
                print(error) // parsing error
                
                if let responseString = String(data: data, encoding: .utf8) {
                    print("responseString = \(responseString)")
                } else {
                    print("unable to parse response as string")
                }
            }
        }
        
        task.resume()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension URL {
    /// Mime type for the URL
    ///
    /// Requires `import UniformTypeIdentifiers` for iOS 14 solution.
    /// Requires `import MobileCoreServices` for pre-iOS 14 solution

    var mimeType: String {
        if #available(iOS 14.0, *) {
            return UTType(filenameExtension: pathExtension)?.preferredMIMEType ?? "application/octet-stream"
        } else {
            guard
                let identifier = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, pathExtension as CFString, nil)?.takeRetainedValue(),
                let mimeType = UTTypeCopyPreferredTagWithClass(identifier, kUTTagClassMIMEType)?.takeRetainedValue() as String?
            else {
                return "application/octet-stream"
            }
            return mimeType
        }
    }
}

extension Data {
    mutating func append(_ string: String, using encoding: String.Encoding = .utf8) {
        if let data = string.data(using: encoding) {
            append(data)
        }
    }
}



