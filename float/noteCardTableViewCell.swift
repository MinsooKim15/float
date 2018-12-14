//
//  noteCardTableViewCell.swift
//  float
//
//  Created by minsoo kim on 14/12/2018.
//  Copyright © 2018 minsoo kim. All rights reserved.
//

import UIKit

protocol OptionButtonsDelegate{
    func todoButtonTapped(at index: IndexPath)
    func agendaButtonTapped(at index: IndexPath)
    func pinButtonTapped(at index: IndexPath)
    func calendarButtonTapped(at index: IndexPath)
    func tableViewCell(tableViewCell: noteCardTableViewCell)
}

class noteCardTableViewCell: UITableViewCell {
    var delegate: OptionButtonsDelegate!
    var indexPath : IndexPath!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        print("Cell touched")
        // Configure the view for the selected state
    }

    @IBAction func todoButton(_ sender: UIButton) {
        self.delegate?.todoButtonTapped(at: indexPath)
    }
    @IBAction func calendarButton(_ sender: UIButton) {
        self.delegate?.calendarButtonTapped(at: indexPath)
    }
    
    @IBAction func agendaButton(_ sender: UIButton) {
        self.delegate?.agendaButtonTapped(at: indexPath)
    }
    
    @IBAction func pinButton(_ sender: Any) {
        self.delegate?.pinButtonTapped(at: indexPath)
    }
    
    @IBOutlet weak var noteLabel: UILabel!
    
    
    @IBOutlet weak var noteTextField: UITextField!
    

    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.noteTextField.isHidden = true
    }
}
