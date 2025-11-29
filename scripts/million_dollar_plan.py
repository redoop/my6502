#!/usr/bin/env python3
"""100万美元销售方案生成器"""

def generate_sales_plan(target_usd: int = 1000000):
    """生成达成目标的销售方案"""
    
    # 汇率
    usd_to_cny = 7.2
    target_cny = target_usd * usd_to_cny
    
    print(f"=== 100万美元销售方案 ===")
    print(f"目标: ${target_usd:,} (¥{target_cny:,})\n")
    
    # 方案1: 12个月达成
    print("【方案1】12个月达成 (稳健型)")
    monthly_12 = target_cny / 12
    print(f"  月均销售: ¥{monthly_12:,.0f}")
    print(f"  周均销售: ¥{monthly_12/4:,.0f}")
    print(f"  日均销售: ¥{monthly_12/30:,.0f}")
    
    # 方案2: 6个月达成
    print("\n【方案2】6个月达成 (激进型)")
    monthly_6 = target_cny / 6
    print(f"  月均销售: ¥{monthly_6:,.0f}")
    print(f"  周均销售: ¥{monthly_6/4:,.0f}")
    print(f"  日均销售: ¥{monthly_6/30:,.0f}")
    
    # 方案3: 增长型
    print("\n【方案3】增长型 (6个月, 20%月增长)")
    base = 80000
    total = 0
    for i in range(6):
        amount = base * (1.2 ** i)
        total += amount
        print(f"  月{i+1}: ¥{amount:,.0f}")
    print(f"  总计: ¥{total:,.0f}")
    print(f"  达成率: {total/target_cny*100:.1f}%")
    
    # 方案4: 客户分层
    print("\n【方案4】客户分层策略")
    scenarios = [
        ("大客户 (10万+)", 10, 150000),
        ("中客户 (5-10万)", 30, 70000),
        ("小客户 (<5万)", 100, 30000)
    ]
    total = 0
    for name, count, avg in scenarios:
        subtotal = count * avg
        total += subtotal
        print(f"  {name}: {count}个 × ¥{avg:,} = ¥{subtotal:,}")
    print(f"  总计: ¥{total:,}")
    print(f"  达成率: {total/target_cny*100:.1f}%")
    
    # 方案5: 产品组合
    print("\n【方案5】产品组合策略")
    products = [
        ("旗舰产品", 50, 80000),
        ("标准产品", 150, 25000),
        ("入门产品", 300, 8000)
    ]
    total = 0
    for name, units, price in products:
        subtotal = units * price
        total += subtotal
        print(f"  {name}: {units}单 × ¥{price:,} = ¥{subtotal:,}")
    print(f"  总计: ¥{total:,}")
    print(f"  达成率: {total/target_cny*100:.1f}%")
    
    # 关键指标
    print("\n=== 关键指标 ===")
    print(f"转化率 3%: 需要 {int(target_cny/30000/0.03):,} 个潜在客户")
    print(f"转化率 5%: 需要 {int(target_cny/30000/0.05):,} 个潜在客户")
    print(f"转化率 10%: 需要 {int(target_cny/30000/0.1):,} 个潜在客户")
    
    # 行动计划
    print("\n=== 行动计划 ===")
    actions = [
        "1. 客户开发: 每周新增50+潜在客户",
        "2. 销售跟进: 每天拜访5个客户",
        "3. 方案演示: 每周完成10次产品演示",
        "4. 合同签订: 每月签约20+客户",
        "5. 客户维护: 每月回访老客户",
        "6. 团队协作: 销售+技术+售后配合",
        "7. 数据分析: 每周复盘销售数据",
        "8. 激励机制: 完成目标奖励方案"
    ]
    for action in actions:
        print(f"  {action}")

if __name__ == "__main__":
    generate_sales_plan()
