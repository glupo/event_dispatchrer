# Event dispatcher

**Uses**

 - **SQL db** (PostgreSQL) to ensure event uniqueness
 - **Redis** to store events set
 - **Sidekiq** to schedule event batch sending

 Receiver is implemented using rack server and outputs incoming events to stdout
