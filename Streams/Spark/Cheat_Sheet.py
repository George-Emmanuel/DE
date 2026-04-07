## 1. PySpark Cheat Sheet

### 1.1 Setup & Session

from pyspark.sql import SparkSession

spark = SparkSession.builder \
    .appName("MyApp") \
    .getOrCreate()

### 1.2 Reading Data

df = spark.read.csv("file.csv", header=True, inferSchema=True)
df = spark.read.parquet("file.parquet")
df = spark.read.json("file.json")


### 1.3 Basic DataFrame Operations

df.show()
df.printSchema()
df.columns
df.describe().show()


### 1.4 Select / Filter

df.select("name", "age")

df.filter(df.age > 25)
df.where("age > 25")

### 1.5 Column Operations

from pyspark.sql.functions import col

df.select(col("name"), col("age") + 1)
df.withColumn("age_plus_one", col("age") + 1)

### 1.6 GroupBy & Aggregations

df.groupBy("country").count()

from pyspark.sql.functions import avg
df.groupBy("country").agg(avg("salary"))

### 1.7 Sorting

'''python
df.orderBy("age")
df.orderBy(col("age").desc())
'''

---

### 1.8 Joins

'''python
df1.join(df2, on="id", how="inner")
df1.join(df2, on="id", how="left")
'''

---

### 1.9 Writing Data

'''python
df.write.csv("output/")
df.write.parquet("output/")
df.write.mode("overwrite").save("output/")
'''

---

### 1.10 SQL Usage

'''python
df.createOrReplaceTempView("people")

spark.sql("SELECT * FROM people WHERE age > 25").show()
'''

---

### 1.11 Actions vs Transformations

**Transformations (Lazy):**

'''python
df.filter(df.age > 25)
df.select("name")
'''

**Actions (Trigger Execution):**

'''python
df.show()
df.collect()
df.count()
'''

---

