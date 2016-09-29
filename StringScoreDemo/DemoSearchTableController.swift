//
//  DemoSearchTableController.swift
//  StringScoreDemo
//
//  Created by Yichi on 6/03/2015.
//  Copyright (c) 2015 YICHI ZHANG. All rights reserved.
//

import Foundation
import UIKit
import StringScore_Swift

typealias NameAndScoreTuple = (name:String, score:Double)

class DemoSearchTableController: UITableViewController, UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating
{
    lazy var dataSourceArray: [String] = {
        if let path = Bundle.main.path(forResource: "name_list", ofType: "txt"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: path)),
            let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue) as? String
        {
            var arr = string.components(separatedBy: "\n")

            arr.sort {
                (a, b) -> Bool in
                return a < b
            }
            return arr
        }
        return []
    }()

    let defaultCellReuseIdentifier = "CellId"

    var searchController: UISearchController!
    var resultsTableController: ResultsTableController!


    func commonInit()
    {
        self.title = "Search"
        self.tabBarItem = UITabBarItem(title: self.title, image: DemoStyleKit.imageOf(string: "A"), tag: 0)
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        commonInit()
    }

    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        commonInit()
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()


        resultsTableController = ResultsTableController()

        // We want to be the delegate for our filtered table so didSelectRowAtIndexPath(_:) is called for both tables.
        resultsTableController.tableView.delegate = self


        searchController = UISearchController(searchResultsController: resultsTableController)
        searchController.searchResultsUpdater = self
        searchController.searchBar.sizeToFit()
        tableView.tableHeaderView = searchController.searchBar

        searchController.delegate = self
        searchController.dimsBackgroundDuringPresentation = false // default is YES
        searchController.searchBar.delegate = self    // so we can monitor text changes + others

        // Search is now just presenting a view controller. As such, normal view controller
        // presentation semantics apply. Namely that presentation will walk up the view controller
        // hierarchy until it finds the root view controller or one that defines a presentation context.
        definesPresentationContext = true



        tableView.register(UITableViewCell.self, forCellReuseIdentifier: defaultCellReuseIdentifier)
    }

    // MARK: Table View Data Source and Delegate methods
    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return dataSourceArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: defaultCellReuseIdentifier)

        cell.textLabel?.text = dataSourceArray[(indexPath as NSIndexPath).row]
        cell.detailTextLabel?.text = ""

        return cell
    }

    // MARK: UISearchBarDelegate
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        searchBar.resignFirstResponder()
    }

    // MARK: UISearchResultsUpdating

    func updateSearchResults(for searchController: UISearchController)
    {
        if let searchText = searchController.searchBar.text {
            var resultArray: Array<NameAndScoreTuple> = Array()
            for name in dataSourceArray {
                let score = name.score(searchText)

                let t = (name: name, score: score)
                resultArray.append(t)
            }

            resultArray.sort
            {
                (a, b) -> Bool in
                a.score > b.score
            }

            // Hand over the filtered results to our search results table.
            let resultsController = searchController.searchResultsController as! ResultsTableController
            resultsController.searchResultArray = resultArray
            resultsController.tableView.reloadData()
        }
    }
}

class ResultsTableController: UITableViewController, UISearchControllerDelegate
{
    var searchResultArray: [NameAndScoreTuple]!

    let defaultCellReuseIdentifier = "CellId"

    override func viewDidLoad()
    {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: defaultCellReuseIdentifier)
    }

    // MARK: Table View Data Source and Delegate methods
    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return searchResultArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: defaultCellReuseIdentifier)

        let t = searchResultArray[(indexPath as NSIndexPath).row]

        cell.textLabel?.text = t.name
        cell.detailTextLabel?.text = t.score.yz_toString()

        let maxBlackProportion: CGFloat = 0.7
        cell.textLabel?.textColor = UIColor(white: maxBlackProportion * CGFloat(1 - t.score), alpha: 1.0)

        return cell
    }
}
