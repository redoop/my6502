# 销售和回款计划预测

## 工具说明

**脚本**: `scripts/sales_forecast.py`

预测销售额和回款计划的 Python 工具。

## 使用方法

```bash
# 运行预测
python3 scripts/sales_forecast.py

# 查看结果
cat sales_forecast.json
```

## 配置参数

### 基础配置
```python
forecast = SalesForecast(
    base_amount=100000,    # 基础销售额（元）
    growth_rate=0.15       # 月增长率 (15%)
)
```

### 回款条件
```python
payment_terms = {
    "immediate": 0.3,   # 30% 即时回款
    "30days": 0.5,      # 50% 30天回款
    "60days": 0.2       # 20% 60天回款
}
```

## 输出示例

### 销售预测
```
2025-11: ¥100,000.00 (增长率: 15%)
2025-12: ¥115,000.00 (增长率: 15%)
2026-01: ¥132,250.00 (增长率: 15%)
```

### 回款预测
```
2025-11 - 销售额: ¥100,000.00
  immediate: ¥30,000.00
  30days: ¥50,000.00
  60days: ¥20,000.00
```

## 自定义预测

### 修改预测周期
```python
# 预测12个月
sales = forecast.predict_monthly(12)
```

### 修改增长率
```python
# 保守预测 (5%)
forecast = SalesForecast(base_amount=100000, growth_rate=0.05)

# 激进预测 (25%)
forecast = SalesForecast(base_amount=100000, growth_rate=0.25)
```

### 修改回款条件
```python
# 全款即付
payment_terms = {"immediate": 1.0}

# 分期付款
payment_terms = {
    "immediate": 0.2,
    "30days": 0.3,
    "60days": 0.3,
    "90days": 0.2
}
```

## 输出文件

**sales_forecast.json**: 包含完整预测数据的 JSON 文件

```json
{
  "sales": [
    {
      "month": "2025-11",
      "sales": 100000.0,
      "growth": "15%"
    }
  ],
  "payments": [
    {
      "month": "2025-11",
      "total_sales": 100000.0,
      "payments": {
        "immediate": 30000.0,
        "30days": 50000.0,
        "60days": 20000.0
      }
    }
  ]
}
```

## 扩展功能

可以添加：
- 季度汇总
- 年度汇总
- 现金流分析
- 风险评估
- Excel 导出
- 图表生成

## 注意事项

- 预测基于简单的复合增长模型
- 实际销售受市场、季节等多种因素影响
- 建议结合历史数据和市场分析调整参数
- 定期更新预测以反映实际情况
