//
//  ViewController.swift
//  float
//
//  Created by minsoo kim on 14/12/2018.
//  Copyright © 2018 minsoo kim. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, OptionButtonsDelegate, UITextFieldDelegate {
    /*
     image Source 위치 변수
     */
    
    var floatButtonImgTxt : [String:String] = [
        "normal" : "addButton.png",
        "tapped" : "notyettt2.png"
    ]
    
    
    func tableViewCell(tableViewCell: noteCardTableViewCell) {
        print("YEAH")
    }
    

    var noteCards:[NoteCard] = []{
        didSet{
            noteCardTableView.reloadData()
        }
    }
    func saveAsNoteCard(_ text:String){
        noteCards.append(NoteCard(text: text))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        btn.removeFromSuperview()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noteCards.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500
        
    }
    @IBOutlet weak var noteCardTableView: UITableView!
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCardCell") as! noteCardTableViewCell
        cell.delegate = self
        cell.indexPath = indexPath
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped(sender: )))
        cell.noteLabel.isUserInteractionEnabled = true
        cell.noteLabel.addGestureRecognizer(tapgesture)
        cell.noteLabel.text = noteCards[indexPath.row].noteCardText
        tapgesture.view?.tag = cell.indexPath.row
        cell.noteTextField.delegate = self
        
        return cell
        //        return cell
        
    }
    
    
//    //buttonState 변경 function 정의 -> cellforRowAt에 쓸거임.
//    func setButtonState(of cell : noteCardTableViewCell,as item :NoteCard){
//        if item.noteCardIsAgenda{
//            cell.
//        }
//    }
    
    
    //TODO : 확인해야 할일 - var가 원본을 가리키는게 아니라 복사하는 거라면 아래의 로직 전체가 안 먹을거임.
    //정말로, 변수 복사를 하면 원본이 복사되는 거 였음. 그리고 사라짐. 지금 생각하면 당연한 거긴 한디..
    func todoButtonTapped(at index: IndexPath) {
        
        if noteCards[index.row].noteCardIsTodoDone {
            noteCards[index.row].noteCardIsTodo = false
            noteCards[index.row].noteCardIsTodoDone = false
        }else if noteCards[index.row].noteCardIsTodo {
            noteCards[index.row].noteCardIsTodoDone = true
        }else {
            noteCards[index.row].noteCardIsTodo = true
        }
        
        let itemCell = noteCardTableView.cellForRow(at: index) as! noteCardTableViewCell
        itemCell.todoButtonState = noteCards[index.row].noteCardIsTodo
        itemCell.todoDoneButtonState = noteCards[index.row].noteCardIsTodoDone
    }
    
    func agendaButtonTapped(at index: IndexPath) {
        noteCards[index.row].noteCardIsAgenda = !noteCards[index.row].noteCardIsAgenda
        let itemCell = noteCardTableView.cellForRow(at: index) as! noteCardTableViewCell
        itemCell.agendaButtonState = noteCards[index.row].noteCardIsAgenda
    }
    
    func pinButtonTapped(at index: IndexPath) {
        noteCards[index.row].noteCardIsPinned = !noteCards[index.row].noteCardIsPinned
        let itemCell = noteCardTableView.cellForRow(at: index) as! noteCardTableViewCell
        itemCell.pinButtonState = noteCards[index.row].noteCardIsPinned
    }
    
    func calendarButtonTapped(at index: IndexPath) {
        print("calendarButton tapped at index: \(index)")
        //calendar 버튼은 아직 구현하지 않음.
    }

   
    override func viewDidLoad() {
        super.viewDidLoad()
        noteCardTableView.delegate = self
        noteCardTableView.dataSource = self
        //MARK : Floating Button Codes from Here
        loadFloatButton()
        let tap = UITapGestureRecognizer(target: self, action: #selector(endTextField(sender:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        floatingButton()
    }
    

    
    override func viewWillLayoutSubviews() {
        layoutFloatButton()
    }
    
    var focusedCellItem : noteCardTableViewCell?
    
    //MARK: floating button(viewWillLayoutSubViews 때 해야 됨)
    
    var floatButton = UIButton()
    func layoutFloatButton(){
        floatButton.layer.cornerRadius = floatButton.layer.frame.size.width/2
        floatButton.clipsToBounds = true
        // 나중에 하자 이미지 추가
        if let image = UIImage(named: floatButtonImgTxt["normal"]!) {
            floatButton.setImage(image, for: .normal)
            floatButton.imageView?.contentMode = .scaleToFill
        }
        
        floatButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [floatButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -3),
             floatButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -53),
             floatButton.widthAnchor.constraint(equalToConstant: 50),
             floatButton.heightAnchor.constraint(equalToConstant: 50)])
    }
    //TODO : FloatButton 눌렀을 때의 동작
    @IBAction func buttonClick(_ sender: UIButton){
        print("yeah touched")
        let newNote = NoteCard(text: "")
        print("Button Tapped")
        noteCards.append(newNote)
        let indexPathRow = noteCards.count - 1
        let indexPath = IndexPath.init(row:indexPathRow, section:0)
        let itemCell = noteCardTableView.cellForRow(at: indexPath) as! noteCardTableViewCell
        itemCell.noteTextField.text = itemCell.noteLabel.text
        itemCell.noteLabel.isHidden = true
        itemCell.noteTextField.isHidden = false
        itemCell.noteTextField.becomeFirstResponder()
        focusedCellItem = itemCell
    }

    
    //MARK: floating button(viewDidLoad 때 해야 됨)
    func loadFloatButton(){
        self.floatButton = UIButton(type:.custom)
        self.floatButton.setTitleColor(UIColor.orange, for: .normal)
        self.floatButton.addTarget(self, action: #selector(buttonClick(_:)), for: UIControl.Event.touchUpInside)
        self.view.addSubview(floatButton)
    }
//    일단 받았어. Tap 기능을
    @objc func labelTapped(sender: UITapGestureRecognizer) {
        print("tapped!\(String(describing: sender.view?.tag))")
        let indexPathRow = sender.view?.tag
        let indexPath = IndexPath.init(row:indexPathRow!, section:0)
        let itemCell = noteCardTableView.cellForRow(at: indexPath) as! noteCardTableViewCell
        itemCell.noteTextField.text = noteCards[indexPathRow!].noteCardText
        itemCell.noteLabel.isHidden = true
        itemCell.noteTextField.isHidden = false
        itemCell.noteTextField.becomeFirstResponder()
        focusedCellItem = itemCell
    }
    @objc func endTextField(sender:Any?){
        print("3sadadgfsdg!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
        view.endEditing(true)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {

        noteCards[(focusedCellItem?.indexPath.row)!].noteCardText = focusedCellItem?.noteTextField.text ?? ""
        focusedCellItem?.noteLabel.isHidden = false
        focusedCellItem?.noteTextField.isHidden = true
        focusedCellItem = nil
    }
    //Return을 치면, 새로운 SiblingCard를 최상단에 생성한다 - 고쳐야 함
    //그 후 포커스를 SiblingCard로 넘긴다 - 고쳐야 함
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        noteCards[(focusedCellItem?.indexPath.row)!].noteCardText = focusedCellItem?.noteTextField.text ?? ""
        var siblingCard = NoteCard(text:"")
        noteCards[(focusedCellItem?.indexPath.row)!].addSibling(add: siblingCard, atFirstPlace: true)
        return false
    }
    
}

