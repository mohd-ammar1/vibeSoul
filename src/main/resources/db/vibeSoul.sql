create database vibeSoul_db;
use vibeSoul_db;
CREATE TABLE contact (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    subject VARCHAR(150) NOT NULL,
    message TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE IF NOT EXISTS users(id BIGINT PRIMARY key AUTO_INCREMENT ,email VARCHAR(70) unique NOT NULL , username VARCHAR(50) unique NOT NULL, passhash varchar(100) NOT NULL , type varchar(10)  NOT NULL DEFAULT 'user');  
create table onlineUsers ( user_id int primary key auto_increment , username varchar(50) not null ,session_id varchar(100) not null, last_active DATETIME );
CREATE TABLE private_messages (
    message_id BIGINT AUTO_INCREMENT PRIMARY KEY,   -- unique ID
    sender_id BIGINT NOT NULL,                      -- who sent the message
    receiver_id BIGINT NOT NULL,                    -- who received the message
    encrypted_text TEXT NOT NULL,                   -- encrypted message
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,    -- when it was sent
    status ENUM('sent','delivered','read') DEFAULT 'sent', -- message status
    FOREIGN KEY (sender_id) REFERENCES users(id),
    FOREIGN KEY (receiver_id) REFERENCES users(id)
);
create table friendlist (user  varchar(50) , friend varchar(50), sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, status varchar(25));
