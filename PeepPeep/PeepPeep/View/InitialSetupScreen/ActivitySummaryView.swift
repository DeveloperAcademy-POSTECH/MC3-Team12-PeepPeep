//
//  ActivitySummaryView.swift
//  PeepPeep
//
//  Created by Ha Jong Myeong on 2023/07/12.
//

import DeviceActivity
import SwiftUI

struct ActivitySummaryView: View {
    @State private var totalActivityContext: DeviceActivityReport.Context = .init(rawValue: "Total Activity")
    @State private var filter: DeviceActivityFilter = {
        // 현재날짜를 불러올수 없다면 이전 24시간의 기준으로 날짜의 사용시간 데이터를 받아올 수 있도록 설정
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        let endOfDay = Calendar.current.date(byAdding: .day, value: 1, to: startOfDay) ?? now
        let dateInterval = DateInterval(start: startOfDay, end: endOfDay)

        return DeviceActivityFilter(
            segment: .daily(during: dateInterval),
            users: .all,
            devices: .init([.iPhone, .iPad])
        )
    }()

    var body: some View {
        ZStack {
            STProgressView()
            DeviceActivityReport(totalActivityContext, filter: filter)
        }
    }
}