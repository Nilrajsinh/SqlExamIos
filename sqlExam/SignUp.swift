//
//  SignUp.swift
//  sqlExam
//
//  Created by Nilrajsinh Vaghela on 19/01/20.
//  Copyright © 2020 Nilrajsinh Vaghela. All rights reserved.
//

import UIKit

class SignUp: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
  
    
    var City = ["gandhinagar","Ahemdabad","Rajkot","Other"]
    //step-1
    var db = DBmanage()
    
    
    @IBOutlet weak var Img: UIImageView!
    
    @IBOutlet weak var Name: UITextField!
    @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var Password: UITextField!
    @IBOutlet weak var genderSegment: UISegmentedControl!
    
 //selection of gender
      var arrGender = ["Male","Female","Other"]
    
    @IBAction func RegisterBtn(_ sender: UIButton) {
        
        let Gender = arrGender[genderSegment.selectedSegmentIndex]
        
         //save image into sql or core data
        
         let UserImage = Img.image!.jpegData(compressionQuality: 1.0)
         let strBase64 = UserImage?.base64EncodedString(options: .lineLength64Characters)
         
         
        let command = "INSERT INTO User(Name,Email,Password,Gender,Image) VALUES('\(Name.text!)','\(Email.text!)','\(Password.text!)','\(Gender)','\(strBase64!)')"
         if db.RunCommand(cmd: command)
         {
            
             print("Data Saved!")
             
             let alert = UIAlertController(title: "Sign Up", message: "Your data in saved Succefully", preferredStyle: .alert)
             
             let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                 self.dismiss(animated: true, completion: nil)
                 self.navigationController?.popViewController(animated: true)
             }
             alert.addAction(okAction)
             self.present(alert, animated: true, completion: nil)
         }
         else
         {
             print("Not Saved!")
         }
        
        
    }
    
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
          return 1
      }
      
      func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return City.count
      }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return City[row]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //imageUploading
        let tapgest = UITapGestureRecognizer()
              tapgest.addTarget(self, action: #selector(SignUp.opengalary(tapgest:)))
              Img.isUserInteractionEnabled = true
              Img.addGestureRecognizer(tapgest)

        // Do any additional setup after loading the view.
    }
    
    

 //MARK:-ImagePicking Funtion Start Here
    //first we add gesture in view did load
    
    @objc func opengalary(tapgest: UITapGestureRecognizer) {
          self.setmyimg()
      }
    
    let imagepicker = UIImagePickerController()
    
      func setmyimg(){
          if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
              imagepicker.sourceType = .photoLibrary
              imagepicker.delegate = self
              imagepicker.isEditing = true
              self.present(imagepicker, animated: true, completion: nil)
          }
      }
      
      func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
          let imagee = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
          Img.image = imagee
          self.dismiss(animated: true, completion: nil)
          
          
      }
    
    
    
    
    

}
