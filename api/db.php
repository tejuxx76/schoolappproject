<?php
$servername = "localhost";
$username = "root";      // default XAMPP username
$password = "";          // default XAMPP password is empty
$dbname = "school_app";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname,3307);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
?>
