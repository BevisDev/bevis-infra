# Kafka Topics

GitOps Kafka topics

### Convention Topci: `domain.entity[.variant]`

| Phần      | Ví dụ                    | Ghi chú              |
|-----------|--------------------------|----------------------|
| `domain`  | `cdc`                    | Business             |
| `entity`  | `orders`, `customers`    | Entity / Table       |
| `variant` | `v1`, `raw`, `prod`      | Optional             |

**Ví dụ:** `cdc.orders`, `cdc.customers.v1`

## Config

| Key | required | Default | description |
|-----|----------|---------|-------|
| `name` | x  | — | K8s resource name |
| `topicName` | | = `name` | topic name|
| `partitions` | | `3` | num partitions (just increse after created) |
| `replicas` | | `3` | Replication factor |
| `config` | | — | Kafka topic config |

### `config`

| Key | example | description |
|-----|-------|-------|
| `retention.ms` | `604800000` | time keep message (ms) |
| `max.message.bytes` | `1048576` | max message size |

# Document
- [Config](https://kafka.apache.org/43/configuration/topic-configs/)