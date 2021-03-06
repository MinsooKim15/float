//
//  ViewController.swift
//  float
//
//  Created by minsoo kim on 14/12/2018.
//  Copyright © 2018 minsoo kim. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, OptionButtonsForListCellDelegate, UITextFieldDelegate {
    
    func getNoteCard(at sibling: Int) -> (NoteCard) {
        return noteCards[focusedIndex ?? 0].siblingNotes[sibling]
    }
    func getNoteCardList() ->([NoteCard]){
        return noteCards[focusedIndex ?? 0].siblingNotes
    }
    
    func setNoteCard(at sibling: Int, to item: NoteCard) {
        if noteCards[focusedIndex ?? 0].siblingNotes.count == 0{
            let cellItem = NoteCard(text:"and")
            noteCards[focusedIndex ?? 0].siblingNotes.append(cellItem)
        }
        noteCards[focusedIndex ?? 0].siblingNotes[sibling] = item
    }
    
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
        //예전 코드
//        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCardCell") as! noteCardTableViewCell
        //Cell 코드를 너무 많이 의존하고 있다. 데이터 부분으로 넘기는 방법이 있을까?
        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCardCell") as! noteCardTableViewCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCardListCell") as! EmbedingTableViewCell
        cell.delegate = self
        cell.indexPath = indexPath
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped(sender: )))
        cell.noteLabel.isUserInteractionEnabled = true
    cell.noteLabel.addGestureRecognizer(tapgesture)
        cell.noteLabel.text = noteCards[indexPath.row].noteCardText
        cell.noteLabel.sizeToFit()
        tapgesture.view?.tag = cell.indexPath.row
        cell.noteTextField.delegate = self
        cell.listOfCard = noteCards[indexPath.row].siblingNotes
//        cell.noteBodyTextField.delegate = self
//        cell.noteBodyLabel.text = noteCards[indexPath.row].noteCardBody
//        cell.noteBodyLabel.lineBreakMode = .byWordWrapping
//        cell.noteBodyLabel.sizeToFit()
        return cell
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
        print("tapped")
        
    
//        let itemCell = noteCardTableView.cellForRow(at: index) as! noteCardTableViewCell
        (noteCardTableView.cellForRow(at: index) as! noteCardTableViewCell).todoButtonState = noteCards[index.row].noteCardIsTodo
        (noteCardTableView.cellForRow(at: index) as! noteCardTableViewCell).todoDoneButtonState = noteCards[index.row].noteCardIsTodoDone
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
        print("Pin button")
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
    
//    var focusedCellItem : noteCardTableViewCell?
    var focusedCellItem : EmbedingTableViewCell?
    var focusedIndex : Int?
    
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
    //TODO : 세 번째 카드를 만들면 Fatal error : Unexpectedly found nil while ... -> 해결하기
    @IBAction func buttonClick(_ sender: UIButton){
        print("yeah touched")
        let newNote = NoteCard(text: "")
        print("Button Tapped")
        noteCards.append(newNote)
        let indexPathRow = noteCards.count - 1
        let indexPath = IndexPath.init(row:indexPathRow, section:0)
        let itemCell = noteCardTableView.cellForRow(at: indexPath) as! EmbedingTableViewCell
        itemCell.noteTextField.text = itemCell.noteLabel.text
        itemCell.noteLabel.isHidden = true
        itemCell.noteTextField.isHidden = false
        itemCell.noteTextField.becomeFirstResponder()
        focusedIndex = indexPathRow
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
        let itemCell = noteCardTableView.cellForRow(at: indexPath) as! EmbedingTableViewCell
        itemCell.noteTextField.text = noteCards[indexPathRow!].noteCardText
        itemCell.noteLabel.isHidden = true
        itemCell.noteTextField.isHidden = false
        itemCell.noteTextField.becomeFirstResponder()
        focusedIndex = indexPathRow
        focusedCellItem = itemCell
    }
    @objc func endTextField(sender:Any?){
        print("3sadadgfsdg!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
        view.endEditing(true)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == focusedCellItem?.noteTextField{
            print("WOW!!!!!")
            noteCards[(focusedCellItem?.indexPath.row)!].noteCardText = focusedCellItem?.noteTextField.text ?? ""
            focusedCellItem?.noteLabel.isHidden = false
            focusedCellItem?.noteTextField.isHidden = true
        }
//        else if textField == focusedCellItem?.noteBodyTextField{
//            print("Yeah!!! Body!")
//            noteCards[(focusedCellItem?.indexPath.row)!].noteCardBody = focusedCellItem?.noteBodyTextField.text ?? ""
//            focusedCellItem?.noteBodyLabel.isHidden = false
//            focusedCellItem?.noteBodyTextField.isHidden = true
//            focusedCellItem = nil
//        }
        
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("started")
    }
    
    //TODO : 타이틀에서 return을 떄렸을 때, 밑으로 내려가는 것이 동작
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        if textField  == focusedCellItem?.noteTextField{
            noteCards[(focusedCellItem?.indexPath.row)!].noteCardText = focusedCellItem?.noteTextField.text ?? ""
            noteCards[(focusedCellItem?.indexPath.row)!].noteCardText = focusedCellItem?.noteTextField.text ?? ""
//            focusedCellItem?.noteBodyLabel.isHidden = true
//            focusedCellItem?.noteBodyTextField.isHidden = false
            focusedCellItem?.noteTextField.resignFirstResponder()
            noteCards[focusedIndex ?? 0].siblingNotes.append(NoteCard(text:"Yeah"))
            //아래에서 두 개로 함수를 나눴다. 하나의 함수에는 siblingNotes 추가, 다른함수에는 displayCell 확인
            // 만약 이게 되면? 함수 단위로 시간이 흐른다..?
            focusedCellItem?.startNewText()
//            focusedCellItem?.noteBodyTextField.becomeFirstResponder()
        }
//        else if textField == focusedCellItem?.noteBodyTextField{
//            noteCards[(focusedCellItem?.indexPath.row)!].noteCardBody = focusedCellItem?.noteBodyTextField.text ?? ""
//            focusedCellItem?.noteBodyTextField.resignFirstResponder()
//        }
        return true
    }
}
