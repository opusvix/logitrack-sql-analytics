<p align="right">
  <a href="README.md">🇺🇸 English Version</a>
</p>

# 🚀 LogiTrack Analytics – Projeto de Engenharia de Dados e BI

## 📌 Visão Geral

Este projeto demonstra como a arquitetura do banco de dados impacta diretamente a performance analítica.

Uma tabela com 2,1 milhões de registros foi otimizada utilizando particionamento no PostgreSQL, seguida da construção de um dashboard executivo no Power BI.

O projeto contempla:

- Otimização de performance em banco de dados
- Validação de Partition Pruning
- Modelagem analítica
- Desenvolvimento de dashboard executivo
- Comparação de performance (antes vs depois)

---

# 🗄 Fonte de Dados

| Item | Descrição |
|------|------------|
| Banco de Dados | PostgreSQL |
| Tabela | `orders_partitioned` |
| Registros | 2.100.000 |
| Estratégia | `PARTITION BY RANGE (order_date)` |
| Ambiente | Docker |

---

# ⚙ Otimização do Banco

## Antes do Particionamento

```sql
SELECT COUNT(*) FROM orders;
```

Tempo de execução: **551 ms**  
Leitura completa da tabela (Seq Scan)

---

## Depois do Particionamento

```sql
SELECT COUNT(*)
FROM orders_partitioned
WHERE order_date >= '2025-01-01'
AND order_date < '2026-01-01';
```

Tempo de execução: **0.034 ms**

Apenas a partição relevante foi consultada.

---

## Comparativo de Performance

| Cenário | Linhas Lidas | Tempo Execução | Método |
|----------|--------------|----------------|--------|
| Antes | 2.100.000 | 551 ms | Seq Scan |
| Depois | Uma única partição | 0.034 ms | Partition Pruning |

Melhoria estimada: ~16.000x mais rápido.

---

# 📊 Dashboard Power BI

Modo de conexão: Import  
Fonte: PostgreSQL (Docker)

---

# 📈 Métricas Implementadas

| Métrica | Descrição |
|----------|------------|
| Total de Pedidos | Quantidade total de pedidos |
| Faturamento Total | Soma do valor total |
| Ticket Médio | Receita por pedido |
| Receita Mensal | Evolução temporal |
| Pedidos Mensais | Volume ao longo do tempo |
| Crescimento % | Crescimento mês a mês |
| Receita por Tipo de Veículo | Distribuição operacional |
| Ranking por Total de Pedidos | Performance por tipo |

---

# 🏗 Arquitetura

```text
┌──────────────────────────┐
│   PostgreSQL (Docker)    │
│   Tabelas Particionadas  │
└──────────────┬───────────┘
               │
               ▼
┌──────────────────────────┐
│     Power BI (Import)    │
│   Modelagem com DAX      │
└──────────────┬───────────┘
               │
               ▼
┌──────────────────────────┐
│   Dashboard Executivo    │
│   KPIs e Análises        │
└──────────────────────────┘
```

---

# 🎯 Conclusão

Este projeto demonstra:

- Como design de banco impacta BI
- Ganhos reais com particionamento
- Boas práticas de modelagem analítica
- Pipeline completo: Engenharia → Análise → Visualização

---

# 📌 Tecnologias Utilizadas

- PostgreSQL
- Docker
- Power BI
- SQL
- DAX
