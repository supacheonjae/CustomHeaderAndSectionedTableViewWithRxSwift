//
//  CustomHeaderRxTableViewSectionedReloadDataSource.swift
//  CustomHeaderAndSectionedTableViewWithRxSwift
//
//  Created by 하윤 on 20/06/2019.
//  Copyright © 2019 Supa HaYun. All rights reserved.
//

#if os(iOS)
import UIKit

import RxDataSources

/// 헤더 커스터마이징이 가능한 RxTableViewSectionedReloadDataSource
///
/// 헤더가 불필요하거나 헤더의 커스터마이징이 불필요한 상황이라면
/// RxTableViewSectionedReloadDataSource를 이용하십시오.
class CustomHeaderRxTableViewSectionedReloadDataSource<S: SectionModelType>: RxTableViewSectionedReloadDataSource<S>, UITableViewDelegate {
    
    /// 헤더 커스터마이징을 도와줄 설정 타입 정의
    public typealias ConfigureHeaderView = (TableViewSectionedDataSource<S>, UITableView, Int, S) -> UIView?
    
    init(
        configureCell: @escaping ConfigureCell,
        titleForHeaderInSection: @escaping  TitleForHeaderInSection = { _, _ in nil },
        titleForFooterInSection: @escaping TitleForFooterInSection = { _, _ in nil },
        canEditRowAtIndexPath: @escaping CanEditRowAtIndexPath = { _, _ in false },
        canMoveRowAtIndexPath: @escaping CanMoveRowAtIndexPath = { _, _ in false },
        sectionIndexTitles: @escaping SectionIndexTitles = { _ in nil },
        sectionForSectionIndexTitle: @escaping SectionForSectionIndexTitle = { _, _, index in index },
        configureHeaderView: @escaping ConfigureHeaderView
        ) {
        
        self.configureHeaderView = configureHeaderView
        
        super.init(
            configureCell: configureCell,
            titleForHeaderInSection: titleForHeaderInSection,
            titleForFooterInSection: titleForFooterInSection,
            canEditRowAtIndexPath: canEditRowAtIndexPath,
            canMoveRowAtIndexPath: canMoveRowAtIndexPath,
            sectionIndexTitles: sectionIndexTitles,
            sectionForSectionIndexTitle: sectionForSectionIndexTitle
        )
    }
    
    
    /// 헤더 설정 값
    ///
    /// configureHeaderView에 설정된 값 따라 헤더의 디자인이 바뀝니다.
    open var configureHeaderView: ConfigureHeaderView {
        didSet {
            #if DEBUG
            #endif
        }
    }
    
    
    // UITableViewDelegate에서 재정의된 메서드
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        return configureHeaderView(self, tableView, section, sectionModels[section])
    }
}
#endif
