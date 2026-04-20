-- =========================================================================
-- MUSIC LIBRARY MANAGEMENT SYSTEM
-- =========================================================================
-- This script implements a comprehensive Music Management System schema
-- covering Artists, Albums, Tracks, Genres, Users, Playlists, and Analytics.

CREATE DATABASE IF NOT EXISTS MusicLibraryDB;
USE MusicLibraryDB;

-- ---------------------------------------------------------
-- 1. SCHEMA DEFINITION (ENTITIES & RELATIONSHIPS)
-- ---------------------------------------------------------

-- Artists Table
CREATE TABLE IF NOT EXISTS Artists (
    ArtistID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    Bio TEXT,
    Country VARCHAR(50),
    Website VARCHAR(255)
);

-- Genres Table
CREATE TABLE IF NOT EXISTS Genres (
    GenreID INT PRIMARY KEY AUTO_INCREMENT,
    GenreName VARCHAR(50) UNIQUE NOT NULL
);

-- Albums Table
CREATE TABLE IF NOT EXISTS Albums (
    AlbumID INT PRIMARY KEY AUTO_INCREMENT,
    Title VARCHAR(150) NOT NULL,
    ReleaseYear INT,
    ArtistID INT,
    GenreID INT,
    FOREIGN KEY (ArtistID) REFERENCES Artists(ArtistID) ON DELETE CASCADE,
    FOREIGN KEY (GenreID) REFERENCES Genres(GenreID) ON DELETE SET NULL
);

-- Tracks Table
CREATE TABLE IF NOT EXISTS Tracks (
    TrackID INT PRIMARY KEY AUTO_INCREMENT,
    Title VARCHAR(150) NOT NULL,
    Duration TIME, -- HH:MM:SS
    AlbumID INT,
    GenreID INT,
    ReleaseDate DATE,
    Bitrate INT DEFAULT 320, -- kbps
    PlayCount INT DEFAULT 0,
    FOREIGN KEY (AlbumID) REFERENCES Albums(AlbumID) ON DELETE CASCADE,
    FOREIGN KEY (GenreID) REFERENCES Genres(GenreID) ON DELETE SET NULL
);

-- Users Table
CREATE TABLE IF NOT EXISTS Users (
    UserID INT PRIMARY KEY AUTO_INCREMENT,
    Username VARCHAR(50) UNIQUE NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    JoinDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    SubscriptionType ENUM('Free', 'Premium', 'Family') DEFAULT 'Free'
);

-- Playlists Table
CREATE TABLE IF NOT EXISTS Playlists (
    PlaylistID INT PRIMARY KEY AUTO_INCREMENT,
    UserID INT,
    Title VARCHAR(100) NOT NULL,
    Description TEXT,
    IsPublic BOOLEAN DEFAULT TRUE,
    CreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE
);

-- Playlist_Tracks Mapping (Many-to-Many)
CREATE TABLE IF NOT EXISTS PlaylistTracks (
    PlaylistID INT,
    TrackID INT,
    AddedAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (PlaylistID, TrackID),
    FOREIGN KEY (PlaylistID) REFERENCES Playlists(PlaylistID) ON DELETE CASCADE,
    FOREIGN KEY (TrackID) REFERENCES Tracks(TrackID) ON DELETE CASCADE
);

-- Favorites (Liked Songs)
CREATE TABLE IF NOT EXISTS Favorites (
    UserID INT,
    TrackID INT,
    LikedAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (UserID, TrackID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE,
    FOREIGN KEY (TrackID) REFERENCES Tracks(TrackID) ON DELETE CASCADE
);

-- Listening History (Logs)
CREATE TABLE IF NOT EXISTS ListeningHistory (
    HistoryID BIGINT PRIMARY KEY AUTO_INCREMENT,
    UserID INT,
    TrackID INT,
    PlayedAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE,
    FOREIGN KEY (TrackID) REFERENCES Tracks(TrackID) ON DELETE CASCADE
);

-- ---------------------------------------------------------
-- 2. DATA POPULATION (REAL-WORLD EXAMPLES)
-- ---------------------------------------------------------

-- Insert Genres
INSERT INTO Genres (GenreName) VALUES 
('Synthwave'), ('Pop'), ('Rock'), ('Soul'), ('Electronic'), ('Hindi Pop'), ('Alternative');

-- Insert Artists
INSERT INTO Artists (Name, Bio, Country) VALUES 
('The Weeknd', 'Abel Makkonen Tesfaye, known as the Weeknd, is a Canadian singer-songwriter and actor.', 'Canada'),
('Taylor Swift', 'American singer-songwriter known for her narrative songwriting.', 'USA'),
('Arijit Singh', 'Indian playback singer and music composer.', 'India'),
('Linkin Park', 'American rock band from Agoura Hills, California.', 'USA'),
('Daft Punk', 'French electronic music duo formed in Paris.', 'France');

-- Insert Albums
INSERT INTO Albums (Title, ReleaseYear, ArtistID, GenreID) VALUES 
('After Hours', 2020, 1, 1),
('Midnights', 2022, 2, 2),
('Aashiqui 2', 2013, 3, 6),
('Hybrid Theory', 2000, 4, 3),
('Random Access Memories', 2013, 5, 5);

-- Insert Tracks
INSERT INTO Tracks (Title, Duration, AlbumID, GenreID, PlayCount) VALUES 
('Blinding Lights', '00:03:20', 1, 1, 50000),
('Save Your Tears', '00:03:35', 1, 1, 45000),
('Anti-Hero', '00:03:21', 2, 2, 60000),
('Lavender Haze', '00:03:22', 2, 2, 35000),
('Tum Hi Ho', '00:04:22', 3, 6, 80000),
('In the End', '00:03:36', 4, 3, 95000),
('Numb', '00:03:07', 4, 3, 92000),
('Get Lucky', '00:06:09', 5, 5, 70000),
('Instant Crush', '00:05:37', 5, 5, 55000);

-- Insert Users
INSERT INTO Users (Username, Email, SubscriptionType) VALUES 
('Adit_Ghosh', 'adit@example.com', 'Premium'),
('Prasun_Debnath', 'prasun@example.com', 'Free'),
('RockFanatic', 'rock@example.com', 'Family');

-- Create a Playlist
INSERT INTO Playlists (UserID, Title, Description) VALUES 
(1, 'Late Night Vibes', 'Driving through the city at midnight.'),
(3, 'Rock Classics', 'The best of early 2000s rock.');

-- Add Tracks to Playlist
INSERT INTO PlaylistTracks (PlaylistID, TrackID) VALUES 
(1, 1), (1, 2), (1, 8), -- Blinding Lights, Save Your Tears, Get Lucky in Late Night
(2, 6), (2, 7);         -- In the End, Numb in Rock Classics

-- Add Favorites
INSERT INTO Favorites (UserID, TrackID) VALUES 
(1, 1), (1, 3), (1, 5),
(2, 5), (2, 8);

-- ---------------------------------------------------------
-- 3. CRUD OPERATIONS & ADVANCED QUERIES
-- ---------------------------------------------------------

-- UPDATE: Update User subscription
UPDATE Users SET SubscriptionType = 'Premium' WHERE Username = 'Prasun_Debnath';

-- DELETE: Remove a specific track from a playlist
DELETE FROM PlaylistTracks WHERE PlaylistID = 1 AND TrackID = 8;

-- READ: Simple search for songs by title
SELECT * FROM Tracks WHERE Title LIKE '%Lights%';

-- READ: Multi-table join to search songs by Artist Name
SELECT t.Title AS Song, a.Name AS Artist, al.Title AS Album
FROM Tracks t
JOIN Albums al ON t.AlbumID = al.AlbumID
JOIN Artists a ON al.ArtistID = a.ArtistID
WHERE a.Name = 'Taylor Swift';

-- READ: Search by Genre
SELECT t.Title, g.GenreName 
FROM Tracks t
JOIN Genres g ON t.GenreID = g.GenreID
WHERE g.GenreName = 'Rock';

-- ---------------------------------------------------------
-- 4. ANALYTICS & COMPLEX ANALYSIS
-- ---------------------------------------------------------

-- A. Top 5 Most Played Tracks
SELECT Title, PlayCount 
FROM Tracks 
ORDER BY PlayCount DESC 
LIMIT 5;

-- B. Total Duration of a Playlist (Calculated)
SELECT p.Title AS Playlist, SEC_TO_TIME(SUM(TIME_TO_SEC(t.Duration))) AS TotalDuration
FROM Playlists p
JOIN PlaylistTracks pt ON p.PlaylistID = pt.PlaylistID
JOIN Tracks t ON pt.TrackID = t.TrackID
GROUP BY p.PlaylistID;

-- C. Most Popular Genre based on User Favorites
SELECT g.GenreName, COUNT(f.TrackID) AS LikeCount
FROM Genres g
JOIN Tracks t ON g.GenreID = t.GenreID
JOIN Favorites f ON t.TrackID = f.TrackID
GROUP BY g.GenreName
ORDER BY LikeCount DESC;

-- D. Count of Tracks per Artist
SELECT a.Name, COUNT(t.TrackID) AS TotalSongs
FROM Artists a
JOIN Albums al ON a.ArtistID = al.ArtistID
JOIN Tracks t ON al.AlbumID = t.AlbumID
GROUP BY a.Name;

-- E. Find Users who have added 'Arijit Singh' songs to their Favorites
SELECT DISTINCT u.Username
FROM Users u
JOIN Favorites f ON u.UserID = f.UserID
JOIN Tracks t ON f.TrackID = t.TrackID
JOIN Albums al ON t.AlbumID = al.AlbumID
JOIN Artists a ON al.ArtistID = a.ArtistID
WHERE a.Name = 'Arijit Singh';

-- ---------------------------------------------------------
-- 5. ADVANCED FEATURES (TRIGGERS, INDEXES, VIEWS)
-- ---------------------------------------------------------

-- A. INDEXES for Performance (Fast Search)
CREATE INDEX idx_track_title ON Tracks(Title);
CREATE INDEX idx_artist_name ON Artists(Name);
CREATE INDEX idx_album_title ON Albums(Title);

-- B. TRIGGER: Auto-increment PlayCount when a song is listened to
DELIMITER //
CREATE TRIGGER AfterPlaybackInserted
AFTER INSERT ON ListeningHistory
FOR EACH ROW
BEGIN
    UPDATE Tracks 
    SET PlayCount = PlayCount + 1 
    WHERE TrackID = NEW.TrackID;
END;
//
DELIMITER ;

-- C. VIEW: Comprehensive Artist Dashboard
CREATE OR REPLACE VIEW ArtistPerformance AS
SELECT 
    a.Name AS Artist,
    COUNT(DISTINCT al.AlbumID) AS TotalAlbums,
    COUNT(t.TrackID) AS TotalSongs,
    SUM(t.PlayCount) AS TotalStreams
FROM Artists a
LEFT JOIN Albums al ON a.ArtistID = al.AlbumID
LEFT JOIN Tracks t ON al.AlbumID = t.AlbumID
GROUP BY a.ArtistID;

-- D. Testing the Trigger (Prasun listens to 'Blinding Lights')
INSERT INTO ListeningHistory (UserID, TrackID) VALUES (2, 1);

-- E. Check the Analytics View
SELECT * FROM ArtistPerformance;

-- Final view for current library state
SELECT 'DATABASE READY WITH ADVANCED FEATURES' AS Status;
