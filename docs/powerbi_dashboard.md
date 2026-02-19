# 📊 Projeto: Otimização de Performance com Particionamento e Dashboard Analítico

---

# 📌 1. Visão Geral

Este projeto demonstra como otimizações estruturais no banco de dados impactam diretamente a performance analítica e dashboards.

Foi aplicada estratégia de particionamento em uma tabela com **2.100.000 registros**, seguida da construção de dashboard analítico no Power BI.

---

# 🗄 2. Fonte de Dados

## 2.1 Banco de Dados

| Item | Descrição |
|------|------------|
| SGBD | PostgreSQL |
| Tabela original | `orders` |
| Tabela otimizada | `orders_partitioned` |
| Volume total | 2.100.000 registros |
| Estratégia aplicada | `PARTITION BY RANGE (order_date)` |

---

## 2.2 Estrutura da Tabela

| Coluna | Tipo | Descrição |
|--------|------|------------|
| id | bigint | Identificador do pedido |
| customer_id | bigint | Cliente responsável |
| order_date | timestamp | Data do pedido |
| total_amount | numeric | Valor total da venda |
| status | varchar | Status do pedido |

---

# ⚙ 3. Estratégia de Otimização

## 3.1 Antes da Otimização

- Tabela única com 2.100.000 registros
- Execução via Seq Scan
- Alto tempo de leitura

```sql
SELECT COUNT(*) FROM orders;
```

Tempo de execução: **551.393 ms**

---

## 3.2 Depois do Particionamento

Estrutura criada:

- `orders_2024`
- `orders_2025`
- `orders_2026`

Consulta otimizada:

```sql
SELECT COUNT(*)
FROM orders_partitioned
WHERE order_date >= '2025-01-01'
AND order_date < '2026-01-01';
```

Tempo de execução: **0.034 ms**

---

## 3.3 Comparativo de Performance

| Cenário | Linhas Lidas | Tempo Execução | Tipo de Scan |
|----------|--------------|----------------|--------------|
| Antes | 2.100.000 | 551 ms | Seq Scan |
| Depois | Apenas partição 2025 | 0.034 ms | Partition Pruning |

Melhoria estimada: **~16.000x mais rápido**

---

# 📊 4. Dashboard Analítico

Ferramenta utilizada: **Power BI**

---

# 📈 5. Métricas Implementadas

| Métrica | Descrição |
|----------|------------|
| Total de Pedidos | Quantidade total de pedidos |
| Faturamento Total | Soma do valor total das vendas |
| Ticket Médio | Média de valor por pedido |
| Pedidos por Mês | Evolução temporal |
| Faturamento por Mês | Receita mensal |
| Crescimento % | Comparação mês a mês |
| Pedidos por Status | Distribuição operacional |

---

# 🧠 6. Cálculos DAX

## 6.1 Total de Pedidos

```DAX
Total Pedidos = COUNT(orders[id])
```

## 6.2 Faturamento Total

```DAX
Faturamento Total = SUM(orders[total_amount])
```

## 6.3 Ticket Médio

```DAX
Ticket Médio =
DIVIDE(
    [Faturamento Total],
    [Total Pedidos]
)
```

## 6.4 Crescimento Mensal %

```DAX
Crescimento % =
VAR Atual = [Faturamento Total]
VAR MesAnterior =
    CALCULATE(
        [Faturamento Total],
        PREVIOUSMONTH(orders[order_date])
    )
RETURN
DIVIDE(Atual - MesAnterior, MesAnterior)
```

---

# 🖥 7. Estrutura do Dashboard

## Página 1 — Visão Executiva

KPIs:
- Total Pedidos
- Faturamento Total
- Ticket Médio
- Crescimento %

Gráficos:
- Linha → Faturamento por mês
- Colunas → Pedidos por mês
- Barras → Pedidos por status

Filtros:
- Ano
- Status

---

## Página 2 — Análise Temporal

- Drill-down: Ano → Trimestre → Mês → Dia
- Tabela detalhada de pedidos
- Heatmap mensal

---

# 🚀 8. Benefícios Obtidos

| Área | Benefício |
|------|------------|
| Banco de Dados | Redução massiva de I/O |
| Performance | Partition Pruning ativo |
| BI | Dashboard mais responsivo |
| Escalabilidade | Estrutura preparada para crescimento |
| Engenharia | Arquitetura otimizada |

---

# 🏗 9. Arquitetura Final

```
PostgreSQL (Particionado)
        ↓
Power BI (Import / DirectQuery)
        ↓
Dashboard Executivo e Analítico
```

---

# 🎯 10. Conclusão Técnica

A implementação de particionamento por RANGE permitiu:

- Ativação de Partition Pruning
- Redução extrema do tempo de execução
- Melhor experiência no BI
- Escalabilidade sustentável

Este projeto demonstra claramente como:

- Arquitetura de dados impacta BI
- Engenharia de dados melhora analytics
- Performance de banco influencia dashboards
