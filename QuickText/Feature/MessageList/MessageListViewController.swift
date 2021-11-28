//
//  MessageListViewController.swift
//  QuickText
//
//  Created by Debashree Joshi on 26/11/21.
//

import UIKit

class MessageListViewController: UIViewController {
        
    private var tableView: UITableView! {
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
        
    var viewModel: MessageListViewModel = MessageListViewModel()
    
    private let cellIdentifier: String = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.refreshData()
        tableView.reloadData()
    }
    
    func setupViews() {
        self.navigationItem.title = viewModel.title

        setupNavigationBar()
        setupTableView()
    }
    
    func setupTableView() {
        tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        self.view.addSubview(tableView)
        
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
    }
    
    func setupNavigationBar() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addMessageAction))
    }
    
    @objc func addMessageAction() {
        let addMessageVC = AddMessageViewController()
        self.navigationController?.pushViewController(addMessageVC, animated: true)
    }
    
}

extension MessageListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        cell?.textLabel?.text = viewModel.datasource[indexPath.row]
        cell?.textLabel?.numberOfLines = 3
        cell?.selectionStyle = .none
        return cell!
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.deleteMessage(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

extension MessageListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let editViewController = EditViewController()
        let index = indexPath.row
        let editViewModel = EditMessageViewModel(index: index, message: viewModel.datasource[index])
        editViewController.viewModel = editViewModel
        self.navigationController?.pushViewController(editViewController, animated: true)
    }
}
