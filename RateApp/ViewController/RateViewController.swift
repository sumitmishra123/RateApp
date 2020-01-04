//
//  RateViewController.swift
//  RateApp
//
//  Created by Zappfresh on 04/01/20.
//  Copyright © 2020 Demo. All rights reserved.
//

import UIKit
import CoreData

class RateViewController: UIViewController {

    @IBOutlet var rate4: UIButton!
    @IBOutlet var rate3: UIButton!
    @IBOutlet var rate2: UIButton!
    @IBOutlet var rate1: UIButton!
    @IBOutlet var rate0: UIButton!
    @IBOutlet var rateUsBtn: UIButton!
    @IBOutlet var nameTextField: UITextField!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var btnArray: [UIButton]!
    var rated: Int! = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Rate Us"
        btnArray = [rate0,rate1,rate2,rate3,rate4]
        unchecked()
        rateUsBtn.layer.cornerRadius = 12.0
    }
    
    func unchecked(){
        for i in 0..<btnArray.count{
            btnArray[i].backgroundColor = .clear
            let image = UIImage(named: "unchecked")
            btnArray[i].setBackgroundImage(image, for: .normal)
            
        }
    }
    
    func checked(){
        for i in 0...rated - 1 {
            let image = UIImage(named: "checked")
            btnArray[i].setBackgroundImage(image, for: .normal)
        }
    }
    
    
    @IBAction func rateBtnClick(_ sender: Any) {
        unchecked()
        rated = (sender as AnyObject).tag
        print((rated!))
        checked()
    }
    
    
    @IBAction func rateUsClicked(_ sender: Any) {
        if(nameTextField.text == nil || nameTextField.text == ""){
            alert(message: "Enter user name")
        }else{
            let date = NSDate()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy hh:mm:ss"
            var dateString = dateFormatter.string(from: date as Date)
            print(dateString)
            let userName = nameTextField.text!
            let data = userName + " at time " + dateString
            saveData(rating: (rated) , userName: data)}
    }

    func alert(message: String, title: String = "") {
      let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
      let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
      alertController.addAction(OKAction)
      self.present(alertController, animated: true, completion: nil)
    }
    
    
    func saveData(rating: Int , userName: String)  {
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Rating", in: context)
        let newUser = NSManagedObject(entity: entity!, insertInto: context);
        newUser.setValue(rating, forKey: "rating")
        newUser.setValue(userName, forKey: "userName")
        do {
        try context.save();
            print("saved")
            let nextView = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "OverallRateViewController") as? OverallRateViewController
            self.navigationController?.pushViewController(nextView!, animated: true)
        }
        catch {
            print("Failed saving")
        }
    }
    
}
