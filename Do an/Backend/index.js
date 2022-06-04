const express=require("express")
const bodyParse=require("body-parser")
const cors =require('cors')
const app=express()
const mysql=require("mysql")


const db=mysql.createPool({
    host:"localhost",
    user:"root",
    password:"",
    database:"cruddatabase"
});
app.use(cors())
app.use(express.json())
app.use(bodyParse.urlencoded({extended:true}))
// app.get('/',(req,res)=>{
//     const sqlInsrert="insert into movie_reviews (movieName,movieReview) values ('inception', 'good movie')"
//     db.query(sqlInsrert,(err,result)=>{
//         res.send("hello pro")
//     });
// });

app.get('/api/get',(req,res)=>{
    const sqlSelect="select * from movie_reviews"
    db.query(sqlSelect,(err,result)=>{
    //    console.log(result);
       res.send(result)
    });
})

app.post('/api/insert',(req,res)=>{
    const movieName=req.body.movieName
    const movieReview=req.body.movieReview
    // console.log(movieName)
    // console.log(movieReview)

    const sqlInsrert="insert into movie_reviews (movieName,movieReview) values (?, ?)"
    db.query(sqlInsrert,[movieName,movieReview],(err,result)=>{
    //    console.log(result);
    });
})

app.delete('/apt/delete/:movieName',(req,res)=>{
  const name=req.params.movieName;
  console.log(req)
  const sqlInsrert="delete from movie_reviews where movieName =?"
  db.query(sqlInsrert,name,(err,result)=>{
    //  console.log(err);
  });
})
app.listen(3001,()=>{
    console.log("running on port 3001")
}) 