//
//  TextTableViewCell.swift
//  SuiShoujiTest
//
//  Created by DejingMa on 16/9/27.
//  Copyright © 2016年 DejingMa. All rights reserved.
//

import UIKit

class TextTableViewCell: UITableViewCell {
	@IBOutlet weak var m_dateBgView: UIView!
	@IBOutlet weak var m_secondViewHeight: NSLayoutConstraint!
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
		m_dateBgView.layer.cornerRadius = 14
		m_dateBgView.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
	
	static func getCellIndentify() -> String {
		return "TextTableViewCell"
	}


}
