//
//  EmbedingTableViewCell.swift
//  float
//
//  Created by minsoo kim on 20/12/2018.
//  Copyright © 2018 minsoo kim. All rights reserved.
//

import UIKit


protocol OptionButtonsForListCellDelegate{
    func todoButtonTapped(at index: IndexPath)
    func agendaButtonTapped(at index: IndexPath)
    func pinButtonTapped(at index: IndexPath)
    func calendarButtonTapped(at index: IndexPath)
    func tableViewCell(tableViewCell: noteCardTableViewCell)
}


class EmbedingTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UITextFieldDelegate {
    var delegate: OptionButtonsDelegate!
    
    var indexPath : IndexPath!
    
    //원래 코드
    
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listOfCard?.count ?? 0
    }

    // 버튼 정의 가자
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
    //버튼 정의 끝
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = noteCollectionView.dequeueReusableCell(withReuseIdentifier: "noteCardCollectionCell", for: indexPath) as! EmbededCollectionViewCell
        cell.noteLabel.text = listOfCard?[indexPath.row].noteCardText
        cell.noteLabel.isUserInteractionEnabled = true
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped(sender: )))
        cell.noteLabel.addGestureRecognizer(tapgesture)
        tapgesture.view?.tag = indexPath.row
        cell.noteLabelTextField.delegate = self
        return cell
    }
    //    일단 받았어. Tap 기능을
    @objc func labelTapped(sender: UITapGestureRecognizer) {
        print("tapped!\(String(describing: sender.view?.tag))")
        let indexPathRow = sender.view?.tag
        let indexPath = IndexPath.init(row:indexPathRow!, section:0)
        let itemCell = noteCollectionView.cellForItem(at: indexPath) as! EmbededCollectionViewCell
        itemCell.noteLabelTextField.text = listOfCard?[indexPathRow!].noteCardText
        itemCell.noteLabel.isHidden = true
        itemCell.noteLabelTextField.isHidden = false
        itemCell.noteLabelTextField.becomeFirstResponder()
        focusedCellItem = itemCell
    }
    var focusedCellItem : EmbededCollectionViewCell?
    var listOfCard:[NoteCard]?
    
    @IBOutlet weak var noteLabel: UILabel!
    
    @IBOutlet weak var noteTextField: UITextField!{
        didSet{
            self.noteTextField.isHidden = true
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var noteCollectionView: UICollectionView!
}


    





    

    

