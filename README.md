# url-shortener
##Startup instructions 
Frontend: 
```
npm start
```
Backend: 
```
api_root='localhost:3001' client_root='localhost:3000' rails s -p 3001
```
```
sidekiq -q Events
```

##Retrospective
What went well?

* I think I did a good job with link generating and avoiding collisions
* I made a good base for collecting statistics

What didn’t go well?

* I had some trouble with geocoding because the gem responsible for this didn't work well (default workers were executing without necessary parameters)

Also, I added B-tree indexes and tested database performance with 'explain analyze'. It works great with 1000000+ rows (search query takes about 0.2ms).   

If I had more time to work on this, I would go into a report with more detailed statistics (with charts, maps, etc.).
