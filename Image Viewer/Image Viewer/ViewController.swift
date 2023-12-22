//
//  ViewController.swift
//  Image Viewer
//
//  Created by Jay Doshi on 2023-11-07.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, ImageDataDelegate {

    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var imageView: UIImageView!
    
    // use ImageModel class
   // var images = (UIApplication.shared.delegate as! AppDelegate).allImage
    
    // Declare a reference to the AppDelegate
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.dataSource = self
        pickerView.delegate = self
    }
    
    // ImageDataDelegate method
    func didAddNewImage(title: String, imageURL: String) {
        //print("didAddNewImage called title: \(title), imageURL: \(imageURL)")
        let image = ImageModel(title: title, imageURL: imageURL)
        appDelegate.images.append(image)
        pickerView.reloadAllComponents()
    }
    
    // ImageDataDelegate method didselectmage
    func didSelectImage(title: String) {
        if let selectedImage = appDelegate.images.first(where: { $0.title == title }),
           let imageURL = URL(string: selectedImage.imageURL) {
            
            // Use URLSession to load the image asynchronously
            URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
                if let data = data, let image = UIImage(data: data) {
                    // Update UI on the main thread
                    DispatchQueue.main.async {
                        self.imageView.image = image
                    }
                }else {
                    print("Error loading image data from URL")
                }
            }.resume()
        }
    }
    
    
    
    
    func didCancel(){
        dismiss(animated: true, completion: nil)
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return appDelegate.images.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        return appDelegate.images[row].title
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if appDelegate.images.indices.contains(row) {
            let selectedTitle = appDelegate.images[row].title
            didSelectImage(title: selectedTitle)
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let addimageVC = segue.destination as! AddImageViewController
        addimageVC.delegate = self
    }
    
}
