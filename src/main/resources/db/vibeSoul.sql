use vibeSoul_db;
CREATE TABLE contact (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    subject VARCHAR(150) NOT NULL,
    message TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
INSERT INTO contact(name, email, subject, message)
VALUES (
        "Ammar",
        "abuzerali8813@gmail.com",
        "testing",
        "This is only for testing so dont mind"
    )

