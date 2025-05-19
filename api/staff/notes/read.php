<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");

include '../../db.php';  // This creates $conn directly

// Remove this line because it calls an undefined function
// $conn = getDatabaseConnection();

$sql = "SELECT id, title, description, subject, uploaded_by, upload_date FROM notes ORDER BY upload_date DESC";
$result = $conn->query($sql);

$notes = [];

if ($result && $result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $notes[] = $row;
    }
}

echo json_encode(['success' => true, 'notes' => $notes]);

$conn->close();
?>
