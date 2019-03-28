//
//  MainDisplayViewController.swift
//  GradeTracker
//
//  Created by edan yachdav on 7/21/18.
//  Copyright © 2018 edan yachdav. All rights reserved.
//

import UIKit

class GTBaseViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, GTTableViewSwipeActionDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    private var tableViewDelegateWrapper: TableViewDelegateWrapper!
    private var gradeDisplayStyle: GradeStyle!
    private var duplicateItemName: String?
    
    var databaseDelegate: GTTableViewDataBaseDelegate?
    var indexOfSwipedCell: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)

        tableViewDelegateWrapper = TableViewDelegateWrapper()
        tableViewDelegateWrapper.swipeActionDelegate = self

        tableView.delegate = tableViewDelegateWrapper
        tableView.dataSource = self
        tableView.rowHeight = 75
        gradeDisplayStyle = GradeStyle.Letter
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPressGestureHandler(_:)))
        longPressGesture.minimumPressDuration = 0.2
        tableView.addGestureRecognizer(longPressGesture)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateTableViewVisibility()
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if duplicateItemName != nil {
            UserErrorAlerts.duplicatAdded(withName: duplicateItemName!, on: self)
            duplicateItemName = nil
        }
    }
    
    private func alert() -> UIAlertController {
        let alert = UIAlertController(title: "Duplicate", message: "Duplicated Added", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        return alert
    }
    
    /***********Class specific methods***********/
    
    func updateTableViewVisibility() {
        databaseDelegate?.count() == 0 ? (tableView.isHidden = true) : (tableView.isHidden = false)
    }
    
    @objc private func longPressGestureHandler(_ sender: UILongPressGestureRecognizer) {
        switch sender.state {
        case .began:
            gradeDisplayStyle = GradeStyle.Numerical
        case .ended:
            gradeDisplayStyle = GradeStyle.Letter
        default:
            break
        }
        tableView.reloadData()
    }
    
    /***********Unwind Methods***********/
    @IBAction func unwindFromSave(_ sender: UIStoryboardSegue) {
        if let sourceVC = sender.source as? InputFormViewController {
            switch sourceVC.inputMode! {
            case InputMode.Add:
                if !(databaseDelegate!.add(PresentableElement: sourceVC.newItem!)) {
                    duplicateItemName = sourceVC.newItem!.name
                }
            case InputMode.Edit:
                databaseDelegate?.updateElement(at: indexOfSwipedCell!, withUpdatedInfoFrom: sourceVC.newItem!)
            }
            indexOfSwipedCell = nil
            DataPersistenceService.saveData()
            tableView.reloadData()
        }
    }
    
    @IBAction func unwindFromCancel(_ sender: UIStoryboardSegue) {
        tableView.reloadData()
    }
    
    /***********TableView data source methods***********/
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return databaseDelegate!.count()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Table View Cell", for: indexPath)
        let itemToDisplay = databaseDelegate!.element(at: indexPath.row)
        if let grade = itemToDisplay.grade {
            cell.detailTextLabel?.text = GradeFormatter(grade, withStyle: gradeDisplayStyle).formatedGrade
        } else {
            cell.detailTextLabel?.text = "-/-"
        }
        cell.textLabel?.text = itemToDisplay.name
        return cell
    }
    
    /***********GTTableViewSwipeDelegate methods***********/
    
    func cellSwiped(at indexPath: IndexPath, withAction action: GTCellSwipeAction) {
        indexOfSwipedCell = indexPath.row
        switch action {
        case .Edit:
            performSegue(withIdentifier: "Edit Segue", sender: nil)
        case .Delete:
            databaseDelegate?.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            updateTableViewVisibility()
            
            let name = Notification.Name(rawValue: NotificationNames.dataModified)
            NotificationCenter.default.post(name: name, object: nil)
            
        }
        DataPersistenceService.saveData()
    }
    
    /***********Segue methods***********/
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let segueID = segue.identifier {
            if segueID == "Table Cell Tapped Segue" {
                let destVC = segue.destination as! GTBaseViewController
                let indexOfTappedCell = tableView.indexPathForSelectedRow?.row
                destVC.databaseDelegate = (databaseDelegate?.element(at: indexOfTappedCell!) as? GTTableViewDataBaseDelegate)!
                
            }
            if segueID == "Edit Segue" {
                let destVC = segue.destination as! InputFormViewController
                destVC.itemToEdit = databaseDelegate?.element(at: indexOfSwipedCell!)
            }
        }
    }
}
