//
//  ViewController.swift
//  SuiShoujiTest2
//
//  Created by DejingMa on 16/9/26.
//  Copyright © 2016年 DejingMa. All rights reserved.
//

import UIKit

let kScreenWidth = UIScreen.main.bounds.width
let kScreenHeight = UIScreen.main.bounds.height

class ViewController: UIViewController {

	@IBOutlet weak var m_tableView: UITableView!
	
	@IBOutlet weak var m_imageTop: NSLayoutConstraint!
	
	fileprivate var m_curOffsetY: CGFloat!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		m_tableView.decelerationRate = 0.1
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		navigationController?.setNavigationBarHidden(true, animated: true)
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		
		navigationController?.setNavigationBarHidden(false, animated: true)
	}
	
	func popVC() {
		_ = navigationController?.popViewController(animated: true)
	}

}

extension ViewController: UIScrollViewDelegate {
	func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
		guard m_tableView == scrollView else {
			return
		}
		
		m_curOffsetY = scrollView.contentOffset.y
	}
	
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		guard m_tableView == scrollView else {
			return
		}
		
		if scrollView.contentOffset.y <= 64 {
			m_imageTop.constant = 64 - scrollView.contentOffset.y
		} else {
			m_imageTop.constant = 0
		}
	}
	
	func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
		guard m_tableView == scrollView else {
			return
		}
		
		if velocity.y == 0 {
			if scrollView.contentOffset.y <= 0 {

			} else if scrollView.contentOffset.y <= 64 {
				if m_curOffsetY <= 0 {
					m_tableView.scrollToRow(at: IndexPath(row: 0, section: 1), at: .top, animated: true)
				} else if m_curOffsetY <= 64 {
					m_tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
				} else {
					m_tableView.scrollToRow(at: IndexPath(row: 0, section: 1), at: .top, animated: true)
				}
			} else {
			}
			m_tableView.layoutIfNeeded()
		}
	}
	
	func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//		print(scrollView.contentOffset.y, "scrollViewDidEndDecelerating")
		
		if scrollView.contentOffset.y <= 0 {
			if m_curOffsetY <= 64 {
				m_tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
			} else {
				m_tableView.scrollToRow(at: IndexPath(row: 0, section: 1), at: .top, animated: true)
			}
		} else if scrollView.contentOffset.y <= 64 {
			if m_curOffsetY <= 0 {
				m_tableView.scrollToRow(at: IndexPath(row: 0, section: 1), at: .top, animated: true)
			} else if m_curOffsetY <= 64 {
				m_tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
			} else {
				m_tableView.scrollToRow(at: IndexPath(row: 0, section: 1), at: .top, animated: true)
			}
		} else {
		}
		
		m_tableView.layoutIfNeeded()
	}
	
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		return 3
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		switch section {
		case 0, 1:
			return 1
		case 2:
			return 10
		default:
			return 0
		}
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		switch indexPath.section {
		case 0:
			return 64
		case 1:
			return kScreenHeight*0.25
		default:
			return 80
		}
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		switch indexPath.section {
		case 0:
			let cell = tableView.dequeueReusableCell(withIdentifier: "topCell", for: indexPath)
			
			return cell
		case 1:
			let cell = tableView.dequeueReusableCell(withIdentifier: "textCell", for: indexPath)
			
			return cell
		case 2:
			let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
			
			return cell
		default:
			return UITableViewCell()
		}
	}
	
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		switch section {
		case 0, 1:
			return nil
		case 2:
			let headerView = UIView.init(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 100))
			headerView.backgroundColor = UIColor.white
			
//			let bgView = UIView.init(frame: CGRect(x: 0, y: 20, width: kScreenWidth, height: 100))
//			bgView.backgroundColor = UIColor.white
			
			let button = UIButton.init(type: .custom)
			button.frame = CGRect(x: 10, y: 10, width: kScreenWidth-20, height: 80)
			button.backgroundColor = UIColor.orange
			button.setTitle("button", for: .normal)
			button.setTitleColor(UIColor.white, for: .normal)
			button.addTarget(self, action: #selector(popVC), for: .touchUpInside)
			
//			bgView.addSubview(button)
			headerView.addSubview(button)
			
			return headerView
		default:
			return nil
		}
	}
	
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		switch section {
		case 0, 1:
			return 0
		case 2:
			return 100
		default:
			return 0
		}
	}
}

