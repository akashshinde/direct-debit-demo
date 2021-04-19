# Direct debit payment collection

This is a GoCardless API integrated application which demonstrates Create a user, Receive a one time payment from customers.
This also demonstrate how webhook events can be captured and stored in the database for auditing.

### How to Use

#### Setup
1. Setup GoCardless account [GoCardless Dashboard](http://manage.gocardless.com/)
2. Create access token using Developer tab.

#### Set up environment variables and start the server
```shell
export GC_ACCESS_TOKEN=''
export GC_WEBHOOK_SECRET=''

rails server 
```

Now you can access the application using [Application link](http://127.0.0.1/customers) 


### Demo

<img src="./demo.gif" alt="Preview of sample" style="max-width:25%;">
