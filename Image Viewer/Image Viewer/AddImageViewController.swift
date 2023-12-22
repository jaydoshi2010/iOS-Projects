//
//  AddImageViewController.swift
//  Image Viewer
//
//  Created by Jay Doshi on 2023-11-07.
//

import UIKit


protocol ImageDataDelegate: AnyObject {
    func didAddNewImage(title: String, imageURL: String)
    func didCancel()
}


class AddImageViewController: UIViewController {

    
    @IBOutlet weak var imageTitleTextField: UITextField!
    @IBOutlet weak var imageURLTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    
    // declare delegate property protocol
    weak var delegate: ImageDataDelegate?
    
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//    }
    
    
    @IBAction func DoneClicked(_ sender: Any) {
        
        if let title = imageTitleTextField.text, !title.isEmpty, let imageURL = imageURLTextField.text, !imageURL.isEmpty {
            
            delegate?.didAddNewImage(title: title, imageURL: imageURL)
            print(title)
            print(imageURL)
            dismiss(animated: true, completion: nil)
            
        }
        else{
            errorLabel.text = "Both image title and URL are required"
        }
    }
    
    
    @IBAction func CancelClicked(_ sender: Any) {
        delegate?.didCancel()
        //dismiss(animated: true, completion: nil)
    }
    
}
