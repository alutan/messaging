# Messaging
Enterprise Java Bean (*EJB*) Message Driven Bean (*MDB*) that consumes from **MQ** and passes the contents of the message to a notification service.

This *MDB* responds to the **JMS** *TextMessage*s that the *portfolio* microservice delivers to **MQ** whenever a portfolio changes levels, such as from *Silver* to *Gold*.

Note that this is the only microservice in the **Stock Trader** sample that uses the traditional **Java EE** programming model (*EJB*s, *JMS*, *JNDI*, etc.).

This *MDB* expects to receive a *TextMessage* containing a *JSON* object with four fields: `id`, `owner`, `old`, and `new`.  For example, you could post a message like `{"id": "jalcorn@us.ibm.com", "owner": "John", "old": "Silver", "new": "Gold"}` to its **MQ** queue, and it will pass that JSON object to the *notification* microservice.  There are multiple versions of the *notification* service; one posts a message to **Slack** (the *#stock-trader-messages* channel on *ibm-cloud.slack.com*), and another sends a tweet to **Twitter** (the *@IBMStockTrader* account).

 ### Prerequisites for OCP Deployment
 This project requires three secrets: `jwt`, `mq`, and `urls`.
 
 ### Build and Deploy to OCP
To build `messaging` clone this repo and run:
```
cd templates

oc create -f messaging-liberty-deploy.yaml -n messaging-liberty-dev
oc create -f messaging-liberty-deploy.yaml -n messaging-liberty-stage
oc create -f messaging-liberty-deploy.yaml -n messaging-liberty-prod

oc new-app messaging-liberty-deploy -n messaging-liberty-dev
oc new-app messaging-liberty-deploy -n messaging-liberty-stage
oc new-app messaging-liberty-deploy -n messaging-liberty-prod

oc create -f messaging-liberty-build.yaml -n messaging-liberty-build

oc new-app messaging-liberty-build -n messaging-liberty-build

```
