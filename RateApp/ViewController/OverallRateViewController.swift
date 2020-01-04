//
//  OverallRateViewController.swift
//  RateApp
//
//  Created by Zappfresh on 04/01/20.
//  Copyright © 2020 Demo. All rights reserved.
//

import UIKit
import CoreData
class OverallRateViewController: UIViewController {
    var userName: [String] = []
    var rating:[Int] = []
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Ratings"
        registerNib()
        fetchData()
    }
    
    func registerNib(){
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "TableViewCell")
        tableView.separatorStyle = .none
    }
    
    func fetchData()  {
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Rating")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            
            for data in result as! [NSManagedObject] {
                self.userName.append((data.value(forKey: "userName") as? String)!)
                self.rating.append((data.value(forKey: "rating") as? Int)!)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        } catch {
            
            print("Failed")
        }
    }
    
}

extension OverallRateViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rating.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        if(indexPath.row == 0){
            cell.rateLabel.text = "Rate"
            cell.nameLabel.text = "User Name"
            cell.rateLabel.textColor = .red
            cell.nameLabel.textColor = .red
            cell.backgroundColor = UIColor.init(red: 242.0/255.0, green: 248.0/255.0, blue: 252.0/255.0, alpha: 1.0)
        }else{
            cell.rateLabel.textColor = .black
            cell.nameLabel.textColor = .black
            cell.backgroundColor = .white
            cell.rateLabel.text = "\(rating[indexPath.row - 1])"
            cell.nameLabel.text = userName[indexPath.row - 1]
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}
