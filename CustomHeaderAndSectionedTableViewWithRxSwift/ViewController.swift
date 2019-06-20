//
//  ViewController.swift
//  CustomHeaderAndSectionedTableViewWithRxSwift
//
//  Created by 하윤 on 20/06/2019.
//  Copyright © 2019 Supa HaYun. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa
import RxDataSources

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let disposeBag = DisposeBag()
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        
        return formatter
    }
    
    /// Sectioned To Do List
    private lazy var toDoListByDate = self.getToDoListByDate()
    /// Custom Header & Sectioned Data Source
    private lazy var dataSource = self.getDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 커스텀 헤더가 적용되는 부분은 UITableViewDelegate!
        // 그러므로 꼭 tableView.delegate에 값을 할당해야 합니다.
        tableView.delegate = dataSource as? UITableViewDelegate
        
        // Sectioned 목록들과 UITableView 바인딩
        Observable.just(toDoListByDate)
            .asDriver(onErrorJustReturn: [])
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }

    /// 나의 날짜 별 할 일 목록을 반환
    private func getToDoListByDate() -> [ToDoListSection] {
        
        let now = Date()
        let day: TimeInterval = 24 * 60 * 60
        
        
        let myToDoListByDate: [ToDoListSection] = [
            ToDoListSection(date: Date(timeInterval: (day * 1), since: now),
                            mindState: "맑음",
                            items: ["즐거운 Swift 공부", "신나는 농구", "코인 노래방에서 미친듯이 노래 부르기"]),
            ToDoListSection(date: Date(timeInterval: (day * 2), since: now),
                            mindState: "흐림",
                            items: ["해물파전에 막걸리", "고추장 찌개에 소주"]),
            ToDoListSection(date: Date(timeInterval: (day * 3), since: now),
                            mindState: "미침",
                            items: ["몬스터 헌터 월드 역전왕 네르기간테 사냥", "월드 오브 워크래프트 제이나 레이드"]),
            ToDoListSection(date: Date(timeInterval: (day * 4), since: now),
                            mindState: "우울",
                            items: ["...", "......", "........."]),
            ToDoListSection(date: Date(timeInterval: (day * 5), since: now),
                            mindState: "짜증",
                            items: ["왕좌의 게임 시즌 8"]),
            ToDoListSection(date: Date(timeInterval: (day * 6), since: now),
                            mindState: "분노",
                            items: ["꼰대 상사와 스파링", "꼰대보다 무서운 꼰망주"])
        ]
        
        return myToDoListByDate
    }
    
    
    // MARK: - Data Source
    /// ToDoListSection을 SectionModelType으로 갖는 CustomHeaderRxTableViewSectionedReloadDataSource를 반환
    ///
    /// CustomHeaderRxTableViewSectionedReloadDataSource는 UITableView의 헤더 부분을 커스터마이징 할 수 있습니다.
    private func getDataSource() -> RxTableViewSectionedReloadDataSource<ToDoListSection> {
        
        let dataSource = CustomHeaderRxTableViewSectionedReloadDataSource<ToDoListSection>(
            // 셀 설정
            configureCell: { dataSource, tableView, indexPath, toDo in
                let cell = tableView.dequeueReusableCell(withIdentifier: "ContentCell", for: indexPath) as! ContentCell
                
                cell.lbl_toDo.text = toDo
                
                return cell
            },
            // 헤더 설정
            configureHeaderView: { [unowned self] dataSource, tableView, section, toDoListSection -> UIView? in
                let headerCell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell", for: IndexPath(row: 0, section: section)) as! HeaderCell
                
                headerCell.lbl_date.text = self.dateFormatter.string(from: toDoListSection.date)
                headerCell.lbl_mindState.text = toDoListSection.mindState
                
                return headerCell
            }
        )
        
        return dataSource
    }
}
