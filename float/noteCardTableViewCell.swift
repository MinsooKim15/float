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
    
    /*
     Cell 관련 변수 (이미지 파일명) 모음
    */
    var todoButtonImgTxt : [String:String] = [
        "noneTodo": "bigTodoButton.png",
        "todo" : "bigTodoButtonTodo.png",
        "todoDone" :  "bigTodoButtonDone.png"
    ]
    var agendaButtonImgTxt : [String:String] = [
        "notAgenda": "agenda.png",
        "agenda" : "agendaSelected.png"
    ]
    var pinButtonImgTxt : [String:String] = [
        "notPinned": "pinButton.png",
        "pinned" : "pinButtonSelected.png"
    ]
    var calendarButtonImgTxt: [String: String] = [
        "noCalendar": "notYet.png",
        "calendarSetted" : "notYet2.png"
    ]
    
    var todoButtonState = false
    var todoDoneButtonState = false
    var calendarButtonState = false
    var agendaButtonState = false
    var pinButtonState = false
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        
    }

    @IBAction func todoButton(_ sender: UIButton) {
//        if todoButtonState{
//
//        }
        self.delegate?.todoButtonTapped(at: indexPath)
        if todoDoneButtonState{
            print("할일 끝!")
            sender.setImage(UIImage(named: (todoButtonImgTxt["todoDone"]!) ), for: .normal)
        }else if todoButtonState{
            print("할일 시작!!")
            sender.setImage(UIImage(named:todoButtonImgTxt["todo"]!), for: .normal)
        }else {
            print("이것은 아직 할일이 아니다.")
            sender.setImage(UIImage(named:todoButtonImgTxt["noneTodo"]!), for: .normal)
        }
    }
    @IBAction func calendarButton(_ sender: UIButton) {
        self.delegate?.calendarButtonTapped(at: indexPath)
    }
    
    @IBAction func agendaButton(_ sender: UIButton) {
        if agendaButtonState{
            sender.setImage(UIImage(named: agendaButtonImgTxt["agenda"]!), for: .normal)
        }else {
            sender.setImage(UIImage(named:agendaButtonImgTxt["notAgenda"]!), for: .normal)
        }
        self.delegate?.agendaButtonTapped(at: indexPath)
    }
    
    @IBAction func pinButton(_ sender: UIButton) {
        self.delegate?.pinButtonTapped(at: indexPath)
        if pinButtonState{
            sender.setImage(UIImage(named: pinButtonImgTxt["pinned"]!), for: .normal)
        }else {
            sender.setImage(UIImage(named: pinButtonImgTxt["notPinned"]!), for: .normal)
        }
    }
    
    @IBOutlet weak var noteLabel: UILabel!
    
    
    @IBOutlet weak var noteTextField: UITextField!{
        didSet{
            self.noteTextField.isHidden = true
        }
        
    }
    
    override func layoutSubviews() {
        if todoButtonState {
        }
    }
    
}
