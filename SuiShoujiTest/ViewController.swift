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
	@IBOutlet weak var m_tableViewTop: NSLayoutConstraint!
	@IBOutlet weak var m_imageHeight: NSLayoutConstraint!
	
	fileprivate var m_curOffsetY: CGFloat!
	
	fileprivate var m_buttonHeight: CGFloat! = 60
	fileprivate var m_buttonTop: CGFloat! = 10
	fileprivate var m_buttonLeft: CGFloat! = 10
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
//		m_tableView.decelerationRate = 0.1
		m_imageHeight.constant = 70
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
		
		if scrollView.contentOffset.y < 64 {
			m_imageTop.constant = 64 - scrollView.contentOffset.y
			m_tableViewTop.constant = 0

		} else {
			m_imageTop.constant = 0
			if m_tableViewTop.constant == 0 {
				if scrollView.contentOffset.y > 64+kScreenHeight*0.25-20 {
					m_tableViewTop.constant = 20
					m_tableView.contentOffset = CGPoint(x: m_tableView.contentOffset.x,
					                                    y: m_tableView.contentOffset.y+20)
				} else {
					m_tableViewTop.constant = 0
				}
			} else {
				if scrollView.contentOffset.y > 64+kScreenHeight*0.25 {
					m_tableViewTop.constant = 20
				} else {
					m_tableViewTop.constant = 0
					m_tableView.contentOffset = CGPoint(x: m_tableView.contentOffset.x,
					                                    y: m_tableView.contentOffset.y-20)
				}
			}
			
			if scrollView.contentOffset.y < 64+kScreenHeight*0.25-20 {
				let cell = m_tableView.cellForRow(at: IndexPath(row: 0, section: 1)) as! TextTableViewCell
				cell.m_secondViewHeight.constant = min(max(75, 150-(scrollView.contentOffset.y-64)), 150)
				cell.layoutIfNeeded()
				m_tableView.reloadRows(at: [IndexPath(row: 0, section: 1)], with: .none)
			}
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
			return kScreenHeight*m_imageHeight.multiplier+m_imageHeight.constant
		case 2:
			return 80
		default:
			return 0
		}
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		switch indexPath.section {
		case 0:
			let cell = tableView.dequeueReusableCell(withIdentifier: TopTableViewCell.getCellIndentify(), for: indexPath) as! TopTableViewCell
			
			return cell
		case 1:
			let cell = tableView.dequeueReusableCell(withIdentifier: TextTableViewCell.getCellIndentify(), for: indexPath) as! TextTableViewCell
			
			return cell
		case 2:
			let cell = tableView.dequeueReusableCell(withIdentifier: NormalTableViewCell.getCellIndentify(), for: indexPath) as! NormalTableViewCell
			
			cell.m_label.text = "\(indexPath.row + 1)"
			
			return cell
		default:
			return UITableViewCell()
		}
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: false)
		
		
	}
	
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		switch section {
		case 0, 1:
			return nil
		case 2:
			let headerView = UIView.init(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: m_buttonHeight+m_buttonTop*2))
			headerView.backgroundColor = UIColor.white
			
			let button = UIButton.init(type: .custom)
			button.frame = CGRect(x: m_buttonLeft, y: m_buttonTop, width: kScreenWidth-m_buttonLeft*2, height: m_buttonHeight)
			button.backgroundColor = UIColor.orange
			button.setTitle("button", for: .normal)
			button.setTitleColor(UIColor.white, for: .normal)
			button.addTarget(self, action: #selector(popVC), for: .touchUpInside)
			
			button.layer.cornerRadius = 8.0
			button.layer.masksToBounds = true
			
			let lineView = UIView.init(frame: CGRect(x: 0, y: m_buttonHeight+m_buttonTop*2-0.5, width: kScreenWidth, height: 0.5))
			lineView.backgroundColor = UIColor.lightGray
			
			headerView.addSubview(button)
			headerView.addSubview(lineView)
			
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
			return m_buttonHeight+m_buttonTop*2
		default:
			return 0
		}
	}
}

