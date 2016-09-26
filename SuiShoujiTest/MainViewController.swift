//
//  MainViewController.swift
//  SuiShoujiTest2
//
//  Created by DejingMa on 16/9/26.
//  Copyright © 2016年 DejingMa. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

	@IBAction func click(_ sender: AnyObject) {
		let vc = storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
		navigationController?.pushViewController(vc, animated: true)
	}
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
