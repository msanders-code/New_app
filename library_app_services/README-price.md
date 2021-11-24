This service is a locally hosted service that will provide prices of books from different sellers. This is a HTTP Request formatted service. It scrapes bookfinder.com website and returns a JSON object that list the seller, price, and Buy Now link.

To Use, run the service:
If you know the title and author:
http://127.0.0.1:5000/?title=<title>&author=<author>
(ex: http://127.0.0.1:5000/?title=to%kill%a%mockingbird&author=harper%lee)
If you know just the title:
http://127.0.0.1:5000/?title=to%kill%a%mockingbird

Returns a JSON

[{"seller": "AbeBooks", "price": "$10.99", "Buy Now Link": "https://www.bookfinder.com/search/?st=rs&ac=dp&qi=U7cagBxT2J62A71wDofQbS7cRdo_1497963026_1:53:7&bs=abebooks_new&bu=https%3A%2F%2Faffiliates%2Eabebooks%2Ecom%2Fc%2F59145%2F212653%2F2029%3Fu%3Dhttps%253A%252F%252Fwww%2Eabebooks%2Ecom%252Fservlet%252FShopBasket%253Fac%253Da%2526ik%253D31019295985%2526ir&uh=Gbm6Ji5gsifBgg_JLhLT"}, ...]
