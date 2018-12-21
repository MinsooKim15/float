//
//  EmbedingTableViewCell.swift
//  float
//
//  Created by minsoo kim on 20/12/2018.
//  Copyright © 2018 minsoo kim. All rights reserved.
//

import UIKit

class EmbedingTableViewCell: UITableViewCell,UITableViewDelegate, UITableViewDataSource {
    
    var listOfCard:[NoteCard]?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var cardTableView: UITableView!
    
}
