const express = require("express");
const { resolveInclude } = require("ejs");
const bodyParser = require("body-parser");
const mysql = require("mysql");
const app = express();

app.use(express.static("public"));
app.set('view engine', 'ejs');
app.use(bodyParser.urlencoded({extended:true}));
app.use(bodyParser.json())

var customer, typeuser;
var tickets;
var tic_id;
var cust_id = "";
const pool = mysql.createPool({
    connectionLimit : 10,
    host            : 'localhost',
    user            : 'root',
    password        : '',
    database        : 'nodejs_airport'
});

app.get('', function(req, res){
    pool.getConnection((err, connection) => {
        connection.query('SELECT * FROM tickets', (err, rows) => {
            res.render("index", {Tickets : rows});
        })
    })
})

app.get('/login', function(req, res){
    res.render("login");
})

app.get('/booking', function(req, res) {
    res.render("booking");
})

app.get('/home', function(req, res){
    if(cust_id.length > 0)
    {
        pool.getConnection((err, connection) => {
            connection.query(`SELECT * FROM customer WHERE cust_id = '${cust_id}'`, (err, results) => {
                customer = results;
            })
            pool.getConnection((err, connection) => {
                connection.query('SELECT * FROM tickets', (err, rows) => {
                    tickets = rows;
                    res.render("index_cus", {Customer : customer, Tickets : tickets});
                })
            })
        })
    }
    else{
        console.log("failed");
    }
})

app.get('/balance', function(req, res){
    if(cust_id.length > 0 && typeuser == "admin"){
        pool.getConnection((err, connection)=>{
            connection.query('SELECT MONTH(booking_date), SUM(t.tic_price) monthly_balance FROM booking_tickets b JOIN tickets t ON b.tic_id = t.tic_id GROUP BY MONTH(booking_date)', function(err, rows){
                if(err) throw err;
                connection.query('SELECT SUM(t.tic_price) total_balance FROM booking_tickets b JOIN tickets t ON b.tic_id = t.tic_id', function(err, all){
                    if(err) throw err;
                    res.render("index_admin", {Monthly : rows, Total: all});
                })
            })
        })
    }
    else{
        res.render('login')
    }
})

app.post('/home', function(req, res){
    var username = req.body.username;
    var password = req.body.password;
    pool.getConnection((err, connection) => {
        connection.query('SELECT * FROM accounts WHERE acc_name = ? AND password = ?', [username, password], (err, result) => {
            if(err) throw err;
            typeuser = result[0].acc_type;
            if(result.length > 0 && typeuser == "customer"){
                cust_id = result[0].acc_id;
                res.redirect('/home');
            }
            else if(result.length > 0 && typeuser == "admin"){
                cust_id = result[0].acc_id;
                res.redirect('/balance');

            }
            else{
                cust_id = "";
                res.redirect('/login');
            }
        })
    })
})

app.post('/ticket_des', function(req, res){
    var ticket_des = req.body.btn_flight;
    ticket_des = ticket_des.split(" to ");
    pool.getConnection((err, connection) => {
        connection.query('SELECT * FROM tickets WHERE tic_start = ? AND tic_destination = ?', [ticket_des[0], ticket_des[1]], (err, result) => {
            if (err) throw err;
            if(result.length > 0){
                connection.query(`SELECT * FROM customer WHERE cust_id = '${cust_id}'`, (err, row)=>
                {
                    res.render("ticket_book", {Tickets : result, Customer: row});
                    app.post('/payment', function(req, res){ 
                        var button_value = req.body.btn_price;
                        button_value = button_value.split(" to ");
                        var price = button_value[0];
                        tic_id = button_value[1];
                        res.render("payment", {Price : price});
                    })
                })
            }
            else{
                console.log("failed");
            }
        })
    })
})

app.get('/successfulpayment', function(req, res){
    pool.getConnection((err, connection) =>{
        connection.query(`INSERT INTO booking_tickets (cust_id, tic_id) VALUES ('${cust_id}', '${tic_id}')`);
        res.render("successfulpayment");
    })
})

app.get('/bookingadmin', function(req, res){
    pool.getConnection((err, connection) => {
        connection.query('SELECT * FROM booking_tickets b JOIN tickets t ON b.tic_id = t.tic_id', function(err, rows){
            if(err) throw err;
            res.render("booking_admin", {List : rows});
        })
    })
})

app.post('/ticketshow', function(req, res){
    var start = req.body.start;
    var destination = req.body.destination;
    console.log(start + " " + destination);
    pool.getConnection((err, connection) => {
        connection.query('SELECT * FROM tickets WHERE tic_start = ? AND tic_destination = ?', [start, destination], (err, result) => {
            if (err) throw err;
            if(result.length > 0){
                res.render("showtickets", {Tickets : result});
            }
            else{
                console.log("failed");
            }
        })
    })
})

app.listen(3000 || process.env.PORT, function(){
    console.log("server is running on port 3000");
});
