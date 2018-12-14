//
//  ViewController.swift
//  float
//
//  Created by minsoo kim on 14/12/2018.
//  Copyright © 2018 minsoo kim. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, OptionButtonsDelegate, UITextFieldDelegate {
    func tableViewCell(tableViewCell: noteCardTableViewCell) {
        print("YEAH")
    }
    


    var noteCards = [NoteCard]()
    
    func saveAsNoteCard(_ text:String){
        noteCards.append(NoteCard(text: text))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        btn.removeFromSuperview()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    @IBOutlet weak var noteCardTableView: UITableView!
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCardCell") as! noteCardTableViewCell
        cell.delegate = self
        cell.indexPath = indexPath
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped(sender: )))
        cell.noteLabel.isUserInteractionEnabled = true
        cell.noteLabel.addGestureRecognizer(tapgesture)
        tapgesture.view?.tag = cell.indexPath.row
        return cell
        //        return cell
        
    }
    
    func todoButtonTapped(at index: IndexPath) {
        print("button tapped at index:\(index)")
    }
    
    func agendaButtonTapped(at index: IndexPath) {
        print("agendaButton tapped at index: \(index)")
    }
    
    func pinButtonTapped(at index: IndexPath) {
        print("pinButton tapped at index: \(index)")
    }
    
    func calendarButtonTapped(at index: IndexPath) {
        print("calendarButton tapped at index: \(index)")
    }

   
    override func viewDidLoad() {
        super.viewDidLoad()
        noteCardTableView.delegate = self
        noteCardTableView.dataSource = self
        //MARK : Floating Button Codes from Here
        loadFloatButton()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        floatingButton()
    }
    
    @IBAction func buttonClick(_ sender: UIButton){
        print("yeah touched")
    }

    
    override func viewWillLayoutSubviews() {
        layoutFloatButton()
    }
    
    
    
    //MARK: floating button(viewWillLayoutSubViews 때 해야 됨)
    
    var floatButton = UIButton()
    func layoutFloatButton(){
        floatButton.layer.cornerRadius = floatButton.layer.frame.size.width/2
        floatButton.backgroundColor = UIColor.lightGray
        floatButton.clipsToBounds = true
        // 나중에 하자 이미지 추가
        //        roundButton.setImage(<#T##image: UIImage?##UIImage?#>, for: <#T##UIControl.State#>)
        floatButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [floatButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -3),
             floatButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -53),
             floatButton.widthAnchor.constraint(equalToConstant: 50),
             floatButton.heightAnchor.constraint(equalToConstant: 50)])
    }
    //TODO : Button 눌렀을 때의 동작 
    @objc func floatButtonTapped(){
        print("tapped")
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
        var indexPathRow = sender.view?.tag
        let indexPath = IndexPath.init(row:indexPathRow!, section:0)
        let itemCell = noteCardTableView.cellForRow(at: indexPath) as! noteCardTableViewCell
        itemCell.noteLabel.isHidden = true
        itemCell.noteTextField.isHidden = false
    }
    
}

