README
--------------------------------------------------------------------------------
API CALLS FOR AUTHORS
--------------------------------------------------------------------------------
1) To get list of authors present
   GET /authors

2) To get list of particular authors present
   GET /authors/id

3) To create new authors 
   POST /authors

   Input Format: hash of hash
   Example Format: 
   {
	 "author":
	 {
		"name": "xxx",
		"category": "novel"
	 }
   }
4) To update author
    PUT /authors/id

    Input Format: hash of hash
    Example Format: 
    {
	 "author":
	  {
		"name": "yyy",
		"category": "novel"
	  }
    }
5) To delete an author
    DELETE /authors/id
--------------------------------------------------------------------------------
API CALLS FOR BOOKS
--------------------------------------------------------------------------------
1) To get list of books present
   GET /books

2) To get list of particular book present
   GET /books/id

3) To create new books
   POST /books

   Input Format: hash of hash
   Example Format: 
   {
       "book":{  "count":"10", 
              	 "category":"novel",
                 "onloan":"1", 
                 "title":"novel1",
                 "author_name":"zz"
              }
    }

4) To update book
    PUT /books/id

    Input Format: hash of hash
   Input Format: hash of hash with update values
   Example Format: 
   {
       "book":
           {  "count":"20", 
           }
    }

5) To delete an author
    DELETE /books/id
--------------------------------------------------------------------------------
API CALLS FOR BORROWERS(USER)
--------------------------------------------------------------------------------
1) To get list of authors present
   GET /borrowers

2) To get list of particular authors present
   GET /borrowers/id

3) To create new authors 
   POST /borrowers

   Input Format: hash of hash
   Example Format: 
   {
      "borrower":{
                   "email":"xx.com",
                   "name" : "yy"
                 }
    }
4) To update author
    PUT /borrowers/id

   Input Format: hash of hash
   Example Format: 
   {
      "borrower":{
                   "email":"yy.com",
                   "name" : "yy"
                 }
    }
5) To delete an author
    DELETE /borrowers/id
--------------------------------------------------------------------------------
API CALLS FOR BOOKINGS
--------------------------------------------------------------------------------

1) To get list of books loaned present
   GET /books_on_loans

2) To get list of particular authors present
   GET /books_on_loans.id

3) To create new booking 
   POST /books_on_loans/checkout

   Input Format: hash of hash with book name and borrower id
   Example Format: 
   {
      "detail":
      {
          "book_name":"novel1",
           "borrower_id":"1"
      }
   }
4) To return the book loaned
    POST /books_on_loans/checkin

   Input Format: hash of hash with booking id
   Example Format: 
   {
     "detail":
     {
        "booking_id":"2"
      }
   }



