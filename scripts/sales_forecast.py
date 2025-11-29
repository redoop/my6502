#!/usr/bin/env python3
"""销售和回款计划预测工具"""

from datetime import datetime, timedelta
from typing import List, Dict
import json

class SalesForecast:
    def __init__(self, base_amount: float, growth_rate: float = 0.1):
        self.base_amount = base_amount
        self.growth_rate = growth_rate
    
    def predict_monthly(self, months: int) -> List[Dict]:
        """预测月度销售"""
        results = []
        current = datetime.now()
        
        for i in range(months):
            month_date = current + timedelta(days=30*i)
            amount = self.base_amount * (1 + self.growth_rate) ** i
            results.append({
                "month": month_date.strftime("%Y-%m"),
                "sales": round(amount, 2),
                "growth": f"{self.growth_rate*100}%"
            })
        return results
    
    def predict_payment(self, sales: List[Dict], 
                       payment_terms: Dict[str, float]) -> List[Dict]:
        """预测回款 (payment_terms: {"immediate": 0.3, "30days": 0.5, "60days": 0.2})"""
        results = []
        
        for i, sale in enumerate(sales):
            payments = {
                "month": sale["month"],
                "total_sales": sale["sales"],
                "payments": {}
            }
            
            for term, ratio in payment_terms.items():
                payments["payments"][term] = round(sale["sales"] * ratio, 2)
            
            results.append(payments)
        return results

# 使用示例
if __name__ == "__main__":
    # 配置
    forecast = SalesForecast(base_amount=100000, growth_rate=0.15)
    
    # 预测6个月销售
    sales = forecast.predict_monthly(6)
    
    # 预测回款 (30%即时, 50%30天, 20%60天)
    payments = forecast.predict_payment(sales, {
        "immediate": 0.3,
        "30days": 0.5,
        "60days": 0.2
    })
    
    # 输出
    print("=== 销售预测 ===")
    for s in sales:
        print(f"{s['month']}: ¥{s['sales']:,.2f} (增长率: {s['growth']})")
    
    print("\n=== 回款预测 ===")
    for p in payments:
        print(f"\n{p['month']} - 销售额: ¥{p['total_sales']:,.2f}")
        for term, amount in p['payments'].items():
            print(f"  {term}: ¥{amount:,.2f}")
    
    # 保存JSON
    with open("sales_forecast.json", "w") as f:
        json.dump({"sales": sales, "payments": payments}, f, indent=2)
    
    print("\n✅ 已保存到 sales_forecast.json")
