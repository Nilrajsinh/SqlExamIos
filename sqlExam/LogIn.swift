//
//  LogIn.swift
//  sqlExam
//
//  Created by Nilrajsinh Vaghela on 19/01/20.
//  Copyright © 2020 Nilrajsinh Vaghela. All rights reserved.
//

import UIKit

class LogIn: UIViewController {
    
    @IBOutlet weak var Name: UITextField!
    @IBOutlet weak var Password: UITextField!
    
    var value = [Any]()
     var db = DBmanage() 
    
    @IBAction func LoginAction(_ sender: UIButton) {
        
        if (Name.text != "" && Password.text != "") {
                 let queryTxt = "SELECT * from User where Name = \"\(Name.text!)\" AND Password = \"\(Password.text!)\""
                 
                 let id = db.RunQuery(query: queryTxt)
                 //print(id.count)
                 
                 if (id.count == 0){
                     let alert = UIAlertController.init(title: "Error", message: "Details not found, please try again or register a new user!", preferredStyle: .alert)
                     let continueAction = UIAlertAction.init(title: "Continue", style: .default, handler: { (alert) in
                         self.dismiss(animated: true, completion: nil)
                     })
                     alert.addAction(continueAction)
                     self.present(alert, animated: true, completion: nil)
                     return
                 }
            
                 
                 for key in id[0].keys {
                     //print(id[key]!)
                    //print("Done")
                    self.value.append(id[0][key]!)
                     //self.value.append(id[key]!)
                 }
            //print(value)
            //let navigation = self.storyboard?.instantiateViewController(withIdentifier: "ViewPage")
            //self.navigationController?.pushViewController(navigation!, animated: true)
            performSegue(withIdentifier: "pushViewPage", sender: sender)
            }
            
             else
             {
                 print("\n\n\t\tError!")
                 let alert = UIAlertController.init(title: "Error", message: "Please enter Username and Password..!", preferredStyle: .alert)
                 let continueAction = UIAlertAction.init(title: "Continue", style: .default, handler: { (alert) in
                     self.dismiss(animated: true, completion: nil)
                 })
                 alert.addAction(continueAction)
                 self.present(alert, animated: true, completion: nil)
             }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let vc = segue.destination as? ViewPage
            vc?.finalValue = value
        }
    

}
