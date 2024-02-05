//
//  SecondViewController.swift
//  stinger
//
//  Created by 안춘모 on 2/1/24.
//

import UIKit
import DGCharts

class SecondViewController: BaseViewController {
    @IBOutlet var barChartView: BarChartView!
    
    var rate = [[10.0, 20.0, 30.0], [20.0, 30.0, 40.0], [30.0, 40.0, 50.0], [40.0, 50.0, 60.0], [50.0, 60.0, 70.0], [60.0, 70.0, 80.0]]

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "2"
        // Do any additional setup after loading the view.
        
        self.barChartView.noDataText = "데이터 없음"
        
        self.setChart(data: self.rate)
    }
    
    func setChart(data: [[Double]]) {
        var firstDataEntries: [BarChartDataEntry] = []
        var secondDataEntries: [BarChartDataEntry] = []
        var thirdDataEntries: [BarChartDataEntry] = []
        for i in 0..<data.count {
            firstDataEntries.append(BarChartDataEntry(x: Double(i), y: data[i][0]))
            secondDataEntries.append(BarChartDataEntry(x: Double(i), y: data[i][1]))
            thirdDataEntries.append(BarChartDataEntry(x: Double(i), y: data[i][2]))
        }
        
        let firstBarDataSet = BarChartDataSet(entries: firstDataEntries)
        firstBarDataSet.colors = [.red]
        firstBarDataSet.highlightEnabled = false
        
        let secondBarDataSet = BarChartDataSet(entries: secondDataEntries)
        secondBarDataSet.colors = [.orange]
        secondBarDataSet.highlightEnabled = false
        
        let thirdBarDataSet = BarChartDataSet(entries: thirdDataEntries)
        thirdBarDataSet.colors = [.yellow]
        thirdBarDataSet.highlightEnabled = false
        
        let barChartData = BarChartData(dataSets: [firstBarDataSet, secondBarDataSet, thirdBarDataSet])
        barChartData.barWidth = 0.3
        barChartData.groupBars(fromX: -0.5, groupSpace: 0.3, barSpace: 0.0)
        
        self.barChartView.doubleTapToZoomEnabled = false
        self.barChartView.xAxis.labelPosition = .bottom
        self.barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: ["45세~55세", "45세~55세", "45세~55세", "45세~55세", "45세~55세", "45세~55세"])
        self.barChartView.xAxis.gridLineWidth = 0.0
        self.barChartView.rightAxis.enabled = false
        self.barChartView.leftAxis.enabled = false
        self.barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        self.barChartView.data = barChartData
        
//        let ll = ChartLimitLine(limit: 50.0)
//        ll.lineColor = .blue
//        self.barChartView.leftAxis.addLimitLine(ll)
    }
}
