//
//  ViewController.swift
//  RateApp
//
//  Created by Zappfresh on 04/01/20.
//  Copyright © 2020 Demo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var rateBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        rateBtn.layer.cornerRadius = 12.0
    }

    @IBAction func rateBtnClicked(_ sender: Any) {
        let nextView = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RateViewController") as? RateViewController
        self.navigationController?.pushViewController(nextView!, animated: true)
    }
}

