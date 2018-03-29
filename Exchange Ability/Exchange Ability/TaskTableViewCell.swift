//
//  TaskTableViewCell.swift
//  Exchange Ability
//
//  Created by Eva Suska on 2018-03-26.
//  Copyright © 2018 Eva Suska. All rights reserved.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var fee: UILabel!
	@IBOutlet weak var Category: UILabel!
	@IBOutlet weak var location: UILabel!
	@IBOutlet weak var Date: UILabel!

	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
