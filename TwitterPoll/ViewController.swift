//
//  ViewController.swift
//  TwitterPoll
//
//  Created by SimpuMind on 11/28/17.
//  Copyright © 2017 SimpuMind. All rights reserved.
//

import UIKit
import GTProgressBar

protocol VotingDelegate: class{
    func showResults()
}

class ViewController: UIViewController, VotingDelegate {
    
    func showResults() {
        isResultsShow = true
        showTableView()
    }
    

    var voteTableView: UITableView = {
       let tv = UITableView()
        tv.separatorStyle = .none
        tv.clipsToBounds = true
        tv.isHidden = false
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    var resultTableView: UITableView = {
        let tv = UITableView()
        tv.separatorStyle = .none
        tv.clipsToBounds = true
        tv.isHidden = true
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    let containerView: UIView = {
       let view = UIView()
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let titleLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        label.text = "This is the begining the poll."
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var isResultsShow = false
    
    let animateTo = [0.9, 0.2, 0.7, 0.6, 0.4]
    let progressTexts = ["Muhammad Buhari", "Ebele Jonathan", "George Bush", "Bill Clliton", "Barrack Obama"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(containerView)
        containerView.addSubview(voteTableView)
        containerView.addSubview(resultTableView)
        
        voteTableView.rowHeight = 45
        resultTableView.rowHeight = 45
        voteTableView.delegate = self
        voteTableView.dataSource = self
        resultTableView.delegate = self
        resultTableView.dataSource = self
        
        voteTableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "cell")
        resultTableView.register(UINib(nibName: "ResultCell", bundle: nil), forCellReuseIdentifier: "resultCell")
        
        setupViews()
        
        showTableView()
    }
    
    func showTableView(){
        if isResultsShow{
            self.resultTableView.isHidden = false
            self.voteTableView.isHidden = true
        }else{
            resultTableView.isHidden = true
            voteTableView.isHidden = false
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isResultsShow {
            return 5
        }else {
            return 5
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch tableView {
        case resultTableView:
            let cell = tableView.dequeueReusableCell(withIdentifier: "resultCell", for: indexPath) as! ResultCell
            cell.selectionStyle = .none
            let progress = animateTo[indexPath.item]
            cell.titleLabel.text = progressTexts[indexPath.item]
            cell.progressBar
                .animateTo(progress: CGFloat(progress))
            return cell
        case voteTableView:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
            cell.selectionStyle = .none
            cell.votingDelegate = self
            cell.titleLabel.text = progressTexts[indexPath.item]
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func setupViews(){
        
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 84).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
        
        containerView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        containerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        containerView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 400).isActive = true
        
        voteTableView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 5).isActive = true
        voteTableView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -5).isActive = true
        voteTableView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 5).isActive = true
        voteTableView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -5).isActive = true
        
        resultTableView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 5).isActive = true
        resultTableView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -5).isActive = true
        resultTableView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 5).isActive = true
        resultTableView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -5).isActive = true
    }
}

class CustomTableViewCell: UITableViewCell{
    
    let containerHeight: CGFloat = 35
    weak var votingDelegate: VotingDelegate?
    
    var titleLabel: UILabel = {
       let label = UILabel()
        label.text = "Click Me"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = true
        return label
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        view.clipsToBounds = true
        view.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        view.layer.borderWidth = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(containerView)
        containerView.addSubview(titleLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupViews()
        containerView.layer.cornerRadius = containerHeight / 2
        titleLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showResults)))
    }
    
    @objc func showResults(){
        votingDelegate?.showResults()
    }
    
    func setupViews(){
        containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        containerView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        containerView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: containerHeight).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -10).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 10).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10).isActive = true
    }
}
