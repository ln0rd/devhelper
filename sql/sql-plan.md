Sometimes we need to compare and know if some querys are performing well, so to validate it we can use:

Example in postgres:

```
EXPLAIN(FORMAT JSON)SELECT *
FROM user e
WHERE e.name = 'leo'
GROUP BY e.id, e.name
```

It will generate in pgadmin some graphical explain to you see how much each line cost to database.
