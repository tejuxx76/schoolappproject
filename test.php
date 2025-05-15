<?php
// Include the config.php to connect to the database
require_once 'config/config.php';

// Check if the connection is successful
if ($conn) {
    echo "Database connected successfully!";
} else {
    echo "Database connection failed!";
}
?>
