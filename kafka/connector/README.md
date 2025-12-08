# 🔌 Kafka Connect – Introduction

**Kafka Connect** is a scalable and reliable data integration framework built on top of Apache Kafka.  
It allows you to move large amounts of data **into** and **out of** Kafka with minimal code, using a system of pluggable components called **connectors**.

Kafka Connect is commonly used to stream data between databases, object storage, filesystems, or analytics systems.

---

## 🚀 Why Kafka Connect?

### ✔ Declarative Configuration

No need to write custom pipelines — just configure connectors through JSON or REST API.

### ✔ Distributed & Scalable

Connectors run in a distributed cluster with automatic task balancing.

### ✔ Fault Tolerant

State is stored in Kafka internal topics, ensuring failure recovery.

### ✔ Pluggable Architecture

Easily install connectors for databases, cloud storage, search engines, and more.

---

## 🧩 Core Components

### **Connector**

A logical job definition. There are two types:

- **Source Connector** → pulls data _into Kafka_
- **Sink Connector** → pushes data _out of Kafka_

### **Task**

Execution units created by a connector. Tasks run in parallel to increase throughput.

### **Worker**

A Kafka Connect process (standalone or distributed) responsible for running connectors and tasks.

### **Plugin**

A set of JAR files packaged as a connector. Plugins are loaded from `plugin.path`.

---

# 📦 HDFS Sink Connector – Introduction

The **HDFS Sink Connector** (`io.confluent.connect.hdfs.HdfsSinkConnector`) is a **sink connector** that exports data from Kafka topics into **Hadoop Distributed File System (HDFS)** or compatible storage (S3, GCS via HDFS layer).

You can download the official plugin here:

👉 **Confluent Hub – HDFS Sink Connector**  
https://www.confluent.io/hub/confluentinc/kafka-connect-hdfs

Recommended version for Kafka 3.x / Confluent Platform 7.x:  
`confluentinc-kafka-connect-hdfs:10.2.17`

---

## 🔥 What This Connector Does

### ✔ Writes Kafka records to HDFS

Data is written to HDFS directories based on:

- topic
- partition
- time or size-based file rotations

### ✔ Supports multiple formats

- **Avro**
- **JSON**
- **Parquet**
- **Delimited text**

### ✔ Handles Schema Evolution

Integrates with Confluent Schema Registry for Avro/Parquet.

### ✔ Fault Tolerant

Uses Kafka offsets & internal topics for exactly-once file delivery logic.

---

# 🛠 Managing HDFS Sink Connector via REST API

Kafka Connect exposes a REST API that lets you **create**, **update**, and **inspect** connector configurations.  
These APIs are essential for operating Kafka Connect in production.

---

## 📥 GET – Retrieve Connector Configuration

Use this to view the current configuration of a connector.

### **Example**

```bash
curl -s http://localhost:8083/connectors/hdfs-sink/config | jq
```

## ➕ POST – Create a New Connector

```sh
curl -X POST http://localhost:8083/connectors \
  -H "Content-Type: application/json" \
  --data @hdfs-sink.json
```

🔄 PUT – Update an Existing Connector Config
PUT replaces the entire config object.
You must include all fields, not only the fields you want to modify.

```sh
curl -X PUT http://localhost:8083/connectors/hdfs-sink/config \
  -H "Content-Type: application/json" \
  -d '{
    "connector.class": "io.confluent.connect.hdfs.HdfsSinkConnector",
    "tasks.max": "4",
    "topics": "payments",
    "hdfs.url": "hdfs://namenode:9000",
    "format.class": "io.confluent.connect.hdfs.parquet.ParquetFormat",
    "flush.size": "500",
    "schema.compatibility": "FULL"
  }'
```

♻️ Restarting Connector or Task

After updating configs, you may want to restart the connector.

Restart the entire connector

```sh
curl -X POST http://localhost:8083/connectors/hdfs-sink/restart
```
