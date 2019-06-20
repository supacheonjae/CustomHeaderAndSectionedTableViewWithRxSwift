//
//  ToDoListSection.swift
//  CustomHeaderAndSectionedTableViewWithRxSwift
//
//  Created by 하윤 on 20/06/2019.
//  Copyright © 2019 Supa HaYun. All rights reserved.
//

import RxDataSources

struct ToDoListSection {
    /// 날짜
    var date: Date
    /// 정신상태
    var mindState: String
    
    /// To do List
    var items: [Item]
}

extension ToDoListSection: SectionModelType {
    typealias Item = String
    
    init(original: ToDoListSection, items: [Item]) {
        self = original
        self.items = items
    }
}
