import express from "express";
import cors from "cors";
import { dirname } from "path";
import { fileURLToPath } from "url";
import pg from "pg";
import bcrypt from "bcrypt";
import passport from "passport";
import { Strategy } from "passport-local";
import session from "express-session";
import env from "dotenv";
import cron from 'node-cron';
import { IgApiClient } from 'instagram-private-api';
import requestPromise from 'request-promise';
const { get } = requestPromise;


// Import GoogleGenerativeAI using ES module syntax
import { GoogleGenerativeAI } from "@google/generative-ai";
const key = "AIzaSyAKqGJ4jafzPUfaBfwg-VggYMcTlXaktg4";
const genAI = new GoogleGenerativeAI(key);
const model = genAI.getGenerativeModel({ model: "gemini-1.5-flash" });
var API_KEY = "bb_pr_02d0d3eeb8fed32afb8c365d0e7b4a";      //bannerbear

const app = express();
app.use(cors());
app.use(express.urlencoded({ extended: true })); 
const __dirname = dirname(fileURLToPath(import.meta.url));
app.use(express.json());
app.set('view engine', 'ejs');
app.set('views', __dirname + '/views');
app.use(express.static(__dirname + '/public'));
app.use(
  session({
    secret: "TOPSECRETWORD",
    resave: false,
    saveUninitialized: true,
  })
);

app.use(passport.initialize());
app.use(passport.session());


const db = new pg.Client({
    user: "technicalclipper",
    host: "dpg-crrdef52ng1s7390oiog-a",
    database: "hotelbooking_4jd2",
    password: "hviAxR637dgn1tQ94wslmHq8c9lQLDjz",
    port: 5432,
    ssl: {
      rejectUnauthorized: false, // Necessary for external connections
    },
  });
  db.connect();

var campaign="";
app.listen(3000, () => {
    console.log("Server is running on port 3000");
});

app.get("/login",(req,res)=>{
    res.render("login.ejs");
})

app.get("/register",(req,res)=>{
    res.render("register.ejs");
})
app.get("/home",(req,res)=>{
    if (req.isAuthenticated()) {
      res.render("landing.ejs", { user: req.user});
    } else {
      res.render("landing.ejs");
    }
})

app.get("/rooms",async(req,res)=>{
    const rooms=await getRooms();
    const no_of_rooms= await retrieve_no_of_rooms_db(); 
    if (req.isAuthenticated()) {
      res.render("room.ejs", {room:rooms,no:no_of_rooms, user: req.user});
    } else {
      res.render("room.ejs",{room:rooms,no:no_of_rooms});
    }
})

app.get("/getroomdetails/:rno",async(req,res)=>{
    if (req.isAuthenticated()) {
      const rno=parseInt(req.params.rno);
  const data=await get_rowfrom_roomstable(rno);
  res.render("room_details.ejs",{data:data});
    } else {
      res.redirect("/login");
    }
})

app.get("/contact",(req,res)=>{
  const data=req.user;
  res.render("contact.ejs",{user:data});
})

app.post("/addbooking",async(req,res)=>{
  const rno=req.body.rno;
  const date=req.body.date;
  const username=req.user.username;
  const sno=req.user.sno;
  const roomdetails= await get_rowfrom_roomstable(rno);
  const roomname=roomdetails.roomname;
  const price=roomdetails.price;
  add_booking_to_db(sno,username,date,rno,roomname,price);
  return res.status(200).json({ message: "Sucessfully booked room" });
  
})

app.get("/pastbooking",async(req,res)=>{
  const sno=req.user.sno;
  const data= await retreive_order_of_user_from_db(sno);
  const no=await retrieve_no_of_orders_of_user(sno);
  console.log(no);
  res.render("pastbooking.ejs",{no:no,data:data,user:req.user});
})

app.get("/profile",(req,res)=>{
  const data=req.user;
  res.render("userdetails.ejs",{user:data});
})

app.get("/adminlogin",(req,res)=>{
  res.render("adminlogin.ejs");
})

app.get("/admin/dashboard",(req,res)=>{                      //display dashboard  
  if (req.isAuthenticated()) {
    if (req.user.role === 'admin') { // Adjust this based on your actual role property
      res.render("admindashboard.ejs", { user: req.user,campaign:campaign });
    } else {
      return res.status(403).send("Forbidden: You do not have access to this page.");
    }
  } else {
    res.redirect("/adminlogin");
  }
  
})

app.get("/getbookingdetails/:date",async(req,res)=>{
  if (req.isAuthenticated()) {
    if (req.user.role === 'admin') { // Adjust this based on your actual role property
      const date=req.params.date;
      const no= await get_no_of_booking_on_date(date);
      const data=await get_booking_details(date);
      const userdetails=await get_userdetails_onbooked_date(date);
      res.render("admindashboard.ejs",{no:no,data:data,userdetails:userdetails,campaign:campaign});
    } else {
      return res.status(403).send("Forbidden: You do not have access to this page.");
    }
  } else {
    res.redirect("/adminlogin");
  }
})






app.post("/register", async (req, res) => {
  const { username, password, name, age, phone_no } = req.body;
  try {
      const checkResult = await db.query("SELECT * FROM users WHERE username = $1", [username]);
      if (checkResult.rows.length > 0) {
          // If the user already exists, send a conflict status (409)
          console.log("User already registered");
          return res.status(409).json({ message: "User already registered" });
      }
      const hashedPassword = await bcrypt.hash(password, 10);
      const result = await db.query(
          "INSERT INTO users (username, password, name, age, phoneno) VALUES ($1, $2, $3, $4, $5) RETURNING *",
          [username, hashedPassword, name, age, phone_no]
      );

      const user = result.rows[0];
      req.login(user, (err) => {
          if (err) {
              console.error("Login error:", err);
              return res.status(500).json({ message: "Error logging in after registration" });
          }
          console.log("Successfully registered and logged in");
          // Redirect to home page after successful registration and login
          return res.status(200).json({ message: "User logged in" });
      });
  } catch (err) {
      console.error("Error during registration:", err);
      res.status(500).json({ message: "Internal server error" });
  }
});

app.post("/login", (req, res, next) => {
  passport.authenticate("local", (err, user, info) => {
    if (err) {
      console.error("Authentication error:", err);
      return next(err);
    }
    if (!user) {
      console.log("Authentication failed:", info);
      return res.redirect("/login"); 
    }
    req.logIn(user, (err) => {
      if (err) {
        console.error("Login error:", err);
        return next(err);
      }
      console.log("Successfully logged in");
      return res.redirect("/home");
    });
  })(req, res, next); 
});

app.post("/adminlogin", (req, res, next) => {
  passport.authenticate("adminlogin", (err, admin, info) => {
    if (err) {
      console.error("Authentication error:", err);
      return next(err);
    }
    if (!admin) {
      console.log("Authentication failed:", info);
      return res.redirect("/adminlogin"); 
    }
    req.logIn(admin, (err) => {
      if (err) {
        console.error("Login error:", err);
        return next(err);
      }
      console.log("Successfully logged in");
      return res.redirect("/admin/dashboard");
    });
  })(req, res, next); 
});



app.get("/logout", (req, res) => {
  req.logout(function (err) {
    if (err) {
      return next(err);
    }
    res.redirect("/home");
  });
});





passport.use(
  new Strategy(async function verify(username, password, cb) {
    try {
      const result = await db.query("SELECT * FROM users WHERE username = $1", [username]);
      if (result.rows.length > 0) {
        const user = result.rows[0];
        const storedHashedPassword = user.password;
        bcrypt.compare(password, storedHashedPassword, (err, valid) => {
          if (err) {
            console.error("Error comparing passwords:", err);
            return cb(err);
          } else {
            if (valid) {
              return cb(null, user);
            } else {
              return cb(null, false);
            }
          }
        });
      } else {
        return cb("User not found");
      }
    } catch (err) {
      console.log(err);
    }
  })
);

passport.use("adminlogin",                                 //strategy for admin login
  new Strategy(async function verify(username, password, cb) {
    try {
      console.log(username);
      const result = await db.query("SELECT * FROM admin WHERE username = $1", [username]);
      if (result.rows.length > 0) {
        const user = result.rows[0];
        const storedpassword = user.password;
        
        if(password==storedpassword){
          user.role='admin';
          return cb(null,user);
        }
        else{
          
          return cb(null,false);
        }
      } else {
        return cb("admin not found");
      }
    } catch (err) {
      console.log(err);
    }
  })
);

passport.serializeUser((user, cb) => {
  cb(null, user);
});
passport.deserializeUser((user, cb) => {
  cb(null, user);
});

function retrieve_rooms_from_db(){                            //retrieve rooms from db for rroms page
    return new Promise((resolve, reject) => {
        db.query("SELECT * FROM rooms order by rno",(err, res) => {
          if (err) {
            reject(err); 
          } else {
            resolve(res.rows); 
          }
        });
      });
    }


    async function getRooms() {                                   // to call retrive rooms from db
        try {
            const rooms = await retrieve_rooms_from_db();
            return(rooms);
        } catch (error) {
            console.error("Error retrieving rooms:", error);
        }
    }

    function retrieve_no_of_rooms_db(){                                //to retrive no of rows in rooms table
        return new Promise((resolve, reject) => {
            db.query("SELECT COUNT(*) FROM rooms", (err, res) => {
              if (err) {
                reject(err); 
              } else {
                resolve(res.rows[0].count); 
              }
            });
          });
    }
    
    function get_rowfrom_roomstable(rno){                                //to retreive room detail of a particular room
      return new Promise((resolve,reject)=>{
        db.query("select * from rooms where rno=$1", [rno],(err,res)=>{
          if (err){
            reject(err);
          }
          else{
            resolve(res.rows[0])
          }
        })
      })
      } 
    
function add_booking_to_db(sno,username,date,rno,roomname,price){
  db.query("insert into orders (sno,username,rno,roomname,date,price) VALUES ($1, $2, $3, $4, $5,$6)",[sno,username,rno,roomname,date,price]);
}
    
async function retreive_order_of_user_from_db(sno){
  return new Promise((resolve,reject)=>{
    db.query("select * from orders where sno=$1", [sno],(err,res)=>{
      if (err){
        reject(err);
      }
      else{
        resolve(res.rows)
      }
    })
  })
}

async function retrieve_no_of_orders_of_user(sno){
  return new Promise((resolve, reject) => {
    db.query("SELECT COUNT(*) FROM orders where sno=$1",[sno],(err, res) => {
      if (err) {
        reject(err); 
      } else {
        resolve(res.rows[0].count); 
      }
    });
  });
}

function get_no_of_booking_on_date(date){
  return new Promise((resolve, reject) => {
    db.query("SELECT COUNT(*) FROM orders where date=$1",[date], (err, res) => {
      if (err) {
        reject(err); 
      } else {
        resolve(res.rows[0].count); 
      }
    });
  });
}

function get_booking_details(date) {
  return new Promise((resolve, reject) => {
    db.query("SELECT username, roomname, date, price FROM orders WHERE date=$1 order by sno", [date], (err, res) => {
      if (err) {
        reject(err);
      } else {
        // Format the date to the local timezone
        const formattedResults = res.rows.map(row => ({
          username: row.username,
          roomname: row.roomname,
          // Converting the date to local timezone
          date: new Date(row.date).toLocaleDateString('en-CA'), // YYYY-MM-DD format
          price: row.price
        }));
        resolve(formattedResults);
      }
    });
  });
}

function get_userdetails_onbooked_date(date){
  return new Promise((resolve,reject)=>{
    db.query("SELECT users.name, users.phoneno FROM orders INNER JOIN users ON orders.sno = users.sno WHERE orders.date =$1 order by users.sno",[date],(err,res)=>{
        if(err){
          reject(err);
        }
        else{
          resolve(res.rows);
        }
      })
  })
}

function get_no_of_bookings_on_daterange(date1,date2){
  return new Promise((resolve, reject) => {
    db.query("select count(*) from orders where date between $1 and $2",[date1,date2], (err, res) => {
      if (err) {
        reject(err); 
      } else {
        resolve(res.rows[0].count); 
      }
    });
  });
}

function get_no_of_bookings_for_room_on_daterange(date1,date2,roomname){
  return new Promise((resolve, reject) => {
    db.query("SELECT COUNT(*) FROM orders WHERE date BETWEEN $1 AND $2 AND roomname = $3",[date1,date2,roomname], (err, res) => {
      if (err) {
        reject(err); 
      } else {
        resolve(res.rows[0].count); 
      }
    });
  });
}

function get_price_from_db(roomname){
  return new Promise((resolve,reject)=>{
    db.query("select price from rooms where roomname = $1",[roomname],(err,res)=>{
      if(err){
        console.log(err);
      }
      else{
        resolve(res.rows[0].price);
      }
    })
  })
}




function formatDateToISO(date) {
    var year = date.getFullYear();
    var month = ('0' + (date.getMonth() + 1)).slice(-2); // Ensures 2 digits for month
    var day = ('0' + date.getDate()).slice(-2); // Ensures 2 digits for day
    return year + '-' + month + '-' + day;
}

async function checkbookingrate(lt,tt,ld,lsd,ls,ll,lb,td,tsd,ts,tl,tb) { // Wrap your code in an async function                  //check if there is loss in booking rate by ai
  const prompt = `Analyze the provided booking data and calculate the following:

1. **Total Booking Change:**
   - Calculate the percentage change in total bookings for the current week compared to the previous week.
   - Express the change as "increased: [percentage]" if bookings increased or "decreased: [percentage]" if bookings decreased.

2. **Room Type Breakdown:**
   - For each room type, calculate the percentage change in bookings for the current week compared to the previous week.
   - Express the change as "increased: [percentage]" if bookings increased or "decreased: [percentage]" if bookings decreased.
   return which type of room that has been booked less compared to past week

**Example Input 1:**

json
{
  "current_week": {
    "total_rooms_booked": 100, 
    "Deluxe room": 0, 
    "Super Deluxe room": 50, 
    "Suite room": 20,
    "Lounge room": 10,
    "Beach view room": 20
  },
  "previous_week": {
    "total_rooms_booked": 120,
    "Deluxe room": 30, 
    "Super Deluxe room": 50, 
    "Suite room": 20,
    "Lounge room": 10,
    "Beach view room": 10
  }
}

Output Format for Example Input 1:
{"decreased":20,"decreasedroom":"Deluxe room"}

**Example Input 2:**
{
  "current_week": {
    "total_rooms_booked": 200,
    "Deluxe room": 70, 
    "Super Deluxe room": 60, 
    "Suite room": 20,
    "Lounge room": 30,
    "Beach view room": 20
  },
  "previous_week": {
   "total_rooms_booked": 100,
    "Deluxe room": 10, 
    "Super Deluxe room": 50, 
    "Suite room": 20,
    "Lounge room": 10,
    "Beach view room": 10
  }
}

sample output for example input 2
Output Format:
{"increased":100,"increasedroom":"Deluxe room"}


**Example Input 3:**
{
  "current_week": {
    "total_rooms_booked": 350, 
    "Deluxe room": 150, 
    "Super Deluxe room": 50, 
    "Suite room": 50,
    "Lounge room": 50,
    "Beach view room": 50
  },
  "previous_week": {
    "total_rooms_booked": 200,
    "Deluxe room": 50, 
    "Super Deluxe room": 50, 
    "Suite room": 20,
    "Lounge room": 20,
    "Beach view room": 10
  }
}

sample output for example input 3
Output Format:
{"increased":75,"increasedroom":"Deluxe room"}


example input 4

{
  "current_week": {
    "total_rooms_booked": 40, 
    "Deluxe room": 10, 
    "Super Deluxe room": 10, 
    "Suite room": 9,
    "Lounge room": 9,
    "Beach view room": 2
  },
  "previous_week": {
    "total_rooms_booked": 50,
    ""Deluxe room": 12, 
    "Super Deluxe room": 12, 
    "Suite room": 9,
    "Lounge room": 10,
    "Beach view room": 7
  }
}

sample output for example input 4
Output Format:
{"decreased":20,"decreasedroom":"Beach view room"}

example input 5

{
  "current_week": {
    "total_rooms_booked": 80, 
    "Deluxe room": 25, 
    "Super Deluxe room": 25, 
    "Suite room": 20,
    "Lounge room": 7,
    "Beach view room": 3
  },
  "previous_week": {
    "total_rooms_booked": 100,
    ""Deluxe room": 30, 
    "Super Deluxe room": 30, 
    "Suite room": 20,
    "Lounge room": 10,
    "Beach view room": 10
  }
}

sample output for example input 5
Output Format:
{"decreased":20,"decreasedroom":"Beach view room"}



actual input to find inference in the format of sample output,only sample output format no unecessary data
{
  "current_week": {
    "total_rooms_booked": ${tt}, 
    "Deluxe room": ${td}, 
    "Super Deluxe room": ${tsd},                
    "Suite room": ${ts},
    "Lounge room": ${tl},
    "Beach view room": ${tb}
  },
  "previous_week": {
    "total_rooms_booked": ${lt},
    ""Deluxe room": ${ld}, 
    "Super Deluxe room": ${lsd}, 
    "Suite room": ${ls},
    "Lounge room": ${ll},
    "Beach view room": ${lb} 
  }
}
**Provide me the output in a pure JSON format, without any backticks or unnecessary characters.  Make sure the response is a proper JSON object.**
follow my output format,give  increased or decreased value and another key value pair which i specified in example sample outputs above
dont give backticks please.
Return in the json which type of room is less booked for example check which room has higher difference in booking rate of this week to past week bookings


`;
  const result = await model.generateContent(prompt);
  const data=result.response.text()
  //const datas=JSON.parse(data);
  return data;
}

async function generatecampaign(airesponse,price) { // Wrap your code in an async function        //use ai to generate content
  const prompt = `i am making a hotel booking app in which my backend checks every week whether this week booking rate is lower than last week booking rate using genai and find the decrease in booking rate and the type of room which is booked less ,if it is lower ,the type of room which 
is booked less ,for it we will generate a capaign,i need text for that campaign,ill give the original price and room name for campaign in prompt,u provide a short campaign to be fitted in advertising posts 
so make it very short but catchy,ill give price in the prompt input ,reduce somewhat price according to loss in booking rate,one output alone enough,give the calculated rate in output directly
actual input:
${airesponse}  price:${price}

sample output:

**Suite Dreams are Calling! ✨**

This week only, enjoy **20% off** our luxurious Suite rooms! 🛌

**Original price: $3000**

**Now only: $2400**

Treat yourself to a relaxing getaway – book your Suite today!

dont give the text "campaign text" in output
`;
  const result = await model.generateContent(prompt);
  const data=result.response.text();
  return data;
}


async function generateimage(prompts) {        //generate image
  const data = {
      "template": "w0kdleZGOegpZorWxN",
      "modifications": [
          {
              "name": "message",
              "text": `${prompts}`,
              "color": null,
              "background": null
          }
      ],
      "webhook_url": null,
      "transparent": false,
      "metadata": null
  };

  try {
      // First fetch to initiate image generation
      const response = await fetch('https://api.bannerbear.com/v2/images', {
          method: 'POST',
          body: JSON.stringify(data),
          headers: {
              'Content-Type': 'application/json',
              'Authorization': `Bearer ${API_KEY}`
          }
      });

      // Convert the response body to JSON
      const jsonResponse = await response.json();
      console.log(jsonResponse);

      const UID = jsonResponse.uid;

      // Polling for the image generation status
      let completed = false;
      let imageUrl;

      while (!completed) {
          await new Promise(resolve => setTimeout(resolve, 5000)); // Wait 5 seconds before checking again
          const res = await fetch(`https://api.bannerbear.com/v2/images/${UID}`, {
              method: 'GET',
              headers: {
                  'Authorization': `Bearer ${API_KEY}`
              }
          });

          const res2 = await res.json();
          console.log(res2);

          if (res2.status === "completed") {
              console.log("Image URL:", res2.image_url_jpg);
              imageUrl = res2.image_url_jpg;
              completed = true; // Set completed to true to exit the loop
          } else {
              console.log("Image is still being processed.");
          }
      }

      return imageUrl; // Return the final image URL

  } catch (error) {
      console.error("Error:", error);
  }
}


const postToInsta = async (url) => {      //post to insta
  const ig = new IgApiClient();
  ig.state.generateDevice("sunbeachresort");
  await ig.account.login("sunbeachresort","Zingerman123");
  const imageBuffer = await get({
      url: `${url}`,
      encoding: null, 
  });
  await ig.publish.photo({
      file: imageBuffer,
      caption: 'offers from AP_ICE resorts!', // nice caption (optional)
  });
  console.log("image posted on instagram");

}



async function don(){                    //function to check booking rate and start campaign
var date = new Date();
var todayDate = formatDateToISO(date);


// Calculate 7 days before today (last Monday)
date.setDate(date.getDate() - 7);
var lastMonday = formatDateToISO(date);


// Subtract another 7 days from last Monday
date.setDate(date.getDate() - 7);
var sevenDaysBeforeLastMonday = formatDateToISO(date);


const lt=await get_no_of_bookings_on_daterange(sevenDaysBeforeLastMonday,lastMonday)

const tt=await get_no_of_bookings_on_daterange(lastMonday,todayDate)

const ld=await get_no_of_bookings_for_room_on_daterange(sevenDaysBeforeLastMonday,lastMonday,"Deluxe room")

const lsd=await get_no_of_bookings_for_room_on_daterange(sevenDaysBeforeLastMonday,lastMonday,"Super Deluxe room")

const ls=await get_no_of_bookings_for_room_on_daterange(sevenDaysBeforeLastMonday,lastMonday,"Suite room")

const ll=await get_no_of_bookings_for_room_on_daterange(sevenDaysBeforeLastMonday,lastMonday,"Lounge room")

const lb=await get_no_of_bookings_for_room_on_daterange(sevenDaysBeforeLastMonday,lastMonday,"Beach view room")


const td=await get_no_of_bookings_for_room_on_daterange(lastMonday,todayDate,"Deluxe room")

const tsd=await get_no_of_bookings_for_room_on_daterange(lastMonday,todayDate,"Super Deluxe room")

const ts=await get_no_of_bookings_for_room_on_daterange(lastMonday,todayDate,"Suite room")

const tl=await get_no_of_bookings_for_room_on_daterange(lastMonday,todayDate,"Lounge room")

const tb=await get_no_of_bookings_for_room_on_daterange(lastMonday,todayDate,"Beach view room")

//const result=await checkbookingrate(100,80,30,30,20,10,10,25,25,20,7,3);
const result=await checkbookingrate(lt,tt,ld,lsd,ls,ll,lb,td,tsd,ts,tl,tb);
const data=JSON.parse(result);
console.log(data);
  if("decreased" in data){
    console.log("low booking rate detected");
    const roomname=data.decreasedroom;
    console.log(roomname);
    const price= await get_price_from_db(roomname);
    console.log("campaign started");
    const airesponse=JSON.stringify(data);
    var prompts =await generatecampaign(airesponse,price);
    console.log(prompts);
    var url =await generateimage(prompts);
    await postToInsta(url);
    campaign=`low booking rate of ${data.decreased}% detected on ${todayDate},campaign  generated and advertising post has been posted on insta`
    
 }
  


 }

 cron.schedule('0 21 * * 0', async() => {              //scheduler
    await don();
 }, {
  scheduled: true,
  timezone: "Asia/Kolkata" // India timezone
});
