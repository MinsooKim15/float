//
//  embededCardTableViewCell.swift
//  float
//
//  Created by minsoo kim on 21/12/2018.
//  Copyright © 2018 minsoo kim. All rights reserved.
//

import UIKit

class embededCardTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var oneCard: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
