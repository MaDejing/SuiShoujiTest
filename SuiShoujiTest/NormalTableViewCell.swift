//
//  NormalTableViewCell.swift
//  SuiShoujiTest
//
//  Created by DejingMa on 16/9/27.
//  Copyright © 2016年 DejingMa. All rights reserved.
//

import UIKit

class NormalTableViewCell: UITableViewCell {

	@IBOutlet weak var m_label: UILabel!
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

	static func getCellIndentify() -> String {
		return "NormalTableViewCell"
	}
	
	func updateCellWithData() {
	}

}
