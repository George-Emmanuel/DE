### Real PySpark Examples (Mapped to Concepts)

---

### 2.1 Spark Session → Start Engine

```python
spark = SparkSession.builder.appName("Example").getOrCreate()
```

* Triggers creation of:

  * Driver
  * Cluster communication

---

### 2.2 Lazy Evaluation

```python
df = spark.read.csv("data.csv", header=True)

filtered = df.filter(df.age > 25)
grouped = filtered.groupBy("country").count()
```

* Nothing executes yet
* Spark builds a **logical plan**

---

### 2.3 Action → Execution Starts

```python
grouped.show()
```

* Now Spark:

  * Optimizes plan
  * Executes tasks

---

### 2.4 Partitions → Parallelism

```python
df.rdd.getNumPartitions()
df = df.repartition(4)
```

* Data split into partitions
* Each partition = one task

---

### 2.5 Driver vs Executors

```python
df.show()
```

Behind the scenes:

* Driver:

  * Plans execution
* Executors:

  * Process partitions

---

### 2.6 Transformations Pipeline

```python
df = spark.read.csv("sales.csv", header=True)

result = (
    df.filter(df.amount > 100)
      .groupBy("country")
      .sum("amount")
)
```

* Chain of transformations
* Still lazy

---

### 2.7 Shuffle Example

```python
df.groupBy("country").count()
```

* Causes shuffle:

  * Data redistributed across nodes
  * Same keys grouped together

---

### 2.8 SQL Equivalent

```python
df.createOrReplaceTempView("sales")

spark.sql("""
SELECT country, SUM(amount)
FROM sales
GROUP BY country
""").show()
```

---

### 2.9 Caching (Optimization)

```python
df.cache()
df.count()
```

* Stores data in memory
* Avoids recomputation

---

### 2.10 Writing Output

```python
result.write.mode("overwrite").parquet("output/")
```

* Final result saved
* Action triggers execution if not already run

---

## 3. Concept → Code Mapping (Quick Table)

| Concept        | Code Example                         |
| -------------- | ------------------------------------ |
| Spark Session  | `SparkSession.builder.getOrCreate()` |
| Lazy Eval      | `df.filter(...).select(...)`         |
| Action         | `df.show()`                          |
| Partition      | `df.repartition(4)`                  |
| Transformation | `filter`, `select`, `groupBy`        |
| Shuffle        | `groupBy`, `join`                    |
| Executor Work  | Happens during `.show()`             |
| SQL            | `spark.sql()`                        |
| Cache          | `df.cache()`                         |

---

## 4. Minimal End-to-End Example

```python
from pyspark.sql import SparkSession
from pyspark.sql.functions import col

spark = SparkSession.builder.appName("EndToEnd").getOrCreate()

df = spark.read.csv("sales.csv", header=True, inferSchema=True)

result = (
    df.filter(col("amount") > 100)
      .groupBy("country")
      .sum("amount")
)

result.show()
```

**What happens internally:**

1. Spark session starts
2. Transformations recorded (lazy)
3. `.show()` triggers execution
4. Data split into partitions
5. Executors process in parallel
6. Shuffle occurs (groupBy)
7. Result returned to driver

---

If needed, next step can be:

* Interview Q&A based on this
* Hands-on mini project to solidify concepts
* Internal execution plan (`explain()`) breakdown
