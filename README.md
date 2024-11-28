Sun Beach Resort Booking System
This project is a complete Hotel Booking System that integrates AI for campaign generation based on booking trends. The system uses Gemini GenAI to detect low booking rates, generates marketing content through Bannerbear, and posts the campaign images automatically using the Instagram API.

Features...
User and Admin Login: Separate login for users and admins with role-based access.
Room Booking: Users can view available rooms, check room details, and make bookings.
View Past Bookings: Users can track their booking history.
AI-Powered Booking Insights: Weekly detection of low booking rates using Gemini GenAI.
Automated Campaign Generation: Generates campaign content through Bannerbear and posts the images directly on Instagram.
Admin Dashboard: Admin can manage bookings and view insights about room occupancy and booking trends.

Technologies Used
Node.js: Backend framework
Express.js: Web framework for handling routes and middleware
PostgreSQL: Database to store users, bookings, and room information
Passport.js: User authentication with role-based access
Gemini GenAI: AI for detecting booking trends and generating insights
Bannerbear API: Used to generate marketing images
Instagram Graph API: Automates posting of generated images on Instagram
EJS: Templating engine for rendering dynamic HTML pages

AI Workflow
Weekly Low Booking Detection: At the end of every week (Sunday, 9 PM), the system analyzes the booking rate.
Sending Data to Gemini GenAI: Sends the current week's and previous week's booking data to Gemini GenAI to identify a booking decline.
Generating Campaign Content: Based on the insights, Gemini GenAI generates suggestions for marketing content.
Image Generation with Bannerbear: Automatically creates a campaign image using Bannerbear API.
Posting on Instagram: The generated image is posted automatically to the official Instagram account using the Instagram Graph API.

to test it locally on ur pc:
download the repository
change the host name of db in index.js to : crrdef52ng1s7390oiog-a.oregon-postgres.render.com

credentials for admin log:
username: admin@apice                                                   
password: admin123

