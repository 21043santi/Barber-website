<?php
// --- DATABASE CONNECTION ---
$host = 'localhost';
$db   = 'your_database_name';
$user = 'your_username';
$pass = 'your_password';

$conn = new mysqli($host, $user, $pass, $db);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// --- LOGIC: DELETE A REVIEW ---
if (isset($_GET['delete_id'])) {
    $id = intval($_GET['delete_id']);
    $conn->query("DELETE FROM reviews WHERE id = $id");
    header("Location: manage_reviews.php"); // Refresh the page after deleting
}

// --- LOGIC: FETCH ALL REVIEWS ---
$result = $conn->query("SELECT * FROM reviews ORDER BY created_at DESC");
?>

<!DOCTYPE html>
<html>
<head>
    <title>Barber Shop | Manage Reviews</title>
    <style>
        body { font-family: sans-serif; background: #f4f4f4; padding: 20px; }
        table { width: 100%; border-collapse: collapse; background: white; }
        th, td { padding: 12px; border: 1px solid #ddd; text-align: left; }
        th { background: #333; color: white; }
        .delete-btn { color: white; background: #ff4d4d; padding: 5px 10px; text-decoration: none; border-radius: 4px; }
        .delete-btn:hover { background: #cc0000; }
    </style>
</head>
<body>

    <h2>Barber Shop Reviews Management</h2>

    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Customer</th>
                <th>Rating</th>
                <th>Comment</th>
                <th>Date</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <?php while($row = $result->fetch_assoc()): ?>
            <tr>
                <td>#<?php echo $row['id']; ?></td>
                <td><strong><?php echo $row['customer_name']; ?></strong></td>
                <td><?php echo $row['rating']; ?>/5 Stars</td>
                <td><?php echo $row['comment']; ?></td>
                <td><?php echo $row['created_at']; ?></td>
                <td>
                    <a href="?delete_id=<?php echo $row['id']; ?>" 
                       class="delete-btn" 
                       onclick="return confirm('Are you sure you want to delete this review?')">Delete</a>
                </td>
            </tr>
            <?php endwhile; ?>
        </tbody>
    </table>

</body>
</html>