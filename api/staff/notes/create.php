<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");

// Include your DB connection file
include '../../db.php';

// Hardcode a valid user ID that exists in your users table
$uploaded_by = 1;  // Change this to an actual valid user ID from your users table

// Get POST data (make sure to send these fields in your POST request)
$title = $_POST['title'] ?? null;
$description = $_POST['description'] ?? null;
$subject = $_POST['subject'] ?? null;

// Validate required fields
if (!$title || !$description || !$subject) {
    http_response_code(400);
    echo json_encode([
        'success' => false,
        'message' => 'Please provide title, description and subject.'
    ]);
    exit;
}

// Prepare and bind SQL statement to prevent SQL injection
$stmt = $conn->prepare("INSERT INTO notes (title, description, subject, uploaded_by, upload_date) VALUES (?, ?, ?, ?, NOW())");
$stmt->bind_param("sssi", $title, $description, $subject, $uploaded_by);

// Execute the statement and check result
if ($stmt->execute()) {
    echo json_encode([
        'success' => true,
        'message' => 'Note uploaded successfully.'
    ]);
} else {
    http_response_code(500);
    echo json_encode([
        'success' => false,
        'message' => 'Failed to upload note. Error: ' . $stmt->error
    ]);
}

// Close connections
$stmt->close();
$conn->close();
?>
