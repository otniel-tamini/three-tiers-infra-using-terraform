# Architecture détaillée de l'infrastructure AWS (Three-Tier)



```
Région AWS : us-east-1

                                 +-------------------+
                                 |   CloudFront      |
                                 +-------------------+
                                         : :
                                         : :
                                 +-------------------+
                                 |      S3 Bucket    |
                                 +-------------------+
                                         : :
                                         : :
                                 +-------------------+
                                 |       ALB         |
                                 +-------------------+
                                         : :
                                         : :
    +-----------------------------------------------------------------------+
    | VPC : three-tier-app-vpc                                              |
    |                                                                       |
    |   +-------------------+        +-------------------+                  |
    |   |  AZ-1 (us-east-1a)|        |  AZ-2 (us-east-1b)|                  |
    |   |                   |        |                   |                  |
    |   | +-------------+   |        | +-------------+   |                  |
    |   | | Subnet Pub1|   |        | | Subnet Pub2|   |                  |
    |   | +-------------+   |        | +-------------+   |                  |
    |   | +-------------+   |        | +-------------+   |                  |
    |   | |Subnet Priv1|   |        | |Subnet Priv2|   |                  |
    |   | +-------------+   |        | +-------------+   |                  |
    |   |      |            |        |      |            |                  |
    |   |      |            |        |      |            |                  |
    |   |  +--------+       |        |  +--------+       |                  |
    |   |  | EC2-1  |       |        |  | EC2-2  |       |                  |
    |   |  +--------+       |        |  +--------+       |                  |
    |   +-------------------+        +-------------------+                  |
    |         |                               |                             |
    |         |                               |                             |
    |         +-----------+   +---------------+                             |
    |                     |   |                                             |
    |                 +-------------------+                                 |
    |                 |       RDS         |<-------------------+            |
    |                 +-------------------+                    |            |
    |                         ^                                 |            |
    |                         |                                 |            |
    |                 +-------------------+                     |            |
    |                 | Secrets Manager   |---------------------+            |
    |                 +-------------------+                                  |
    +-----------------------------------------------------------------------+
```

Liaisons en pointillé (`: :`) = flux principaux et dépendances.
- CloudFront distribue le contenu du bucket S3 (statique) et peut aussi pointer vers l’ALB.
- L’ALB distribue le trafic vers les instances EC2 dans les subnets privés de chaque AZ.
- Les EC2 accèdent à RDS (DB) dans le privé.
- Secrets Manager fournit les credentials à RDS.
- Les deux AZ sont séparées, chaque AZ a un subnet public et un privé, et une instance EC2 dans le privé.
