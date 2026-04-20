-- =========================================================================
-- MUSIC LIBRARY MANAGEMENT SYSTEM
-- =========================================================================
-- Contributed By: 
-- 1. Adit Ghosh (60%) - Database Architect, Analytics & Performance
-- 2. Prasun Debnath (40%) - Data Engineering & CRUD Operations
-- =========================================================================

CREATE DATABASE IF NOT EXISTS MusicLibraryDB;
USE MusicLibraryDB;

-- ---------------------------------------------------------
-- 1. SCHEMA DEFINITION [Developed by Adit Ghosh]
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
    Duration TIME,
    AlbumID INT,
    GenreID INT,
    ReleaseDate DATE,
    Bitrate INT DEFAULT 320,
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

-- Playlist_Tracks Mapping
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

-- Listening History
CREATE TABLE IF NOT EXISTS ListeningHistory (
    HistoryID BIGINT PRIMARY KEY AUTO_INCREMENT,
    UserID INT,
    TrackID INT,
    PlayedAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE,
    FOREIGN KEY (TrackID) REFERENCES Tracks(TrackID) ON DELETE CASCADE
);

-- ---------------------------------------------------------
-- 2. DATA POPULATION [Implemented by Prasun Debnath]
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

-- Setup Playlists & Favorites
INSERT INTO Playlists (UserID, Title, Description) VALUES (1, 'Late Night Vibes', 'Driving vibes'), (3, 'Rock Classics', 'Early 2000s');
INSERT INTO PlaylistTracks (PlaylistID, TrackID) VALUES (1, 1), (1, 2), (1, 8), (2, 6), (2, 7);
INSERT INTO Favorites (UserID, TrackID) VALUES (1, 1), (1, 3), (1, 5), (2, 5), (2, 8);

-- ---------------------------------------------------------
-- 3. CRUD & SEARCH OPERATIONS
-- ---------------------------------------------------------

-- Basic Operations [Prasun Debnath]
UPDATE Users SET SubscriptionType = 'Premium' WHERE Username = 'Prasun_Debnath';
DELETE FROM PlaylistTracks WHERE PlaylistID = 1 AND TrackID = 8;
SELECT * FROM Tracks WHERE Title LIKE '%Lights%';

-- COMPLEX QUERY: Multi-table Search [Adit Ghosh]
SELECT t.Title AS Song, a.Name AS Artist, al.Title AS Album
FROM Tracks t
JOIN Albums al ON t.AlbumID = al.AlbumID
JOIN Artists a ON al.ArtistID = a.ArtistID
WHERE a.Name = 'Taylor Swift';

-- COMPLEX QUERY: Genre-based Search [Adit Ghosh]
SELECT t.Title, g.GenreName 
FROM Tracks t
JOIN Genres g ON t.GenreID = g.GenreID
WHERE g.GenreName = 'Rock';

-- ---------------------------------------------------------
-- 4. ANALYTICS & COMPLEX ANALYSIS [Architected by Adit Ghosh]
-- ---------------------------------------------------------

-- A. Top 5 Most Played Tracks
SELECT Title, PlayCount FROM Tracks ORDER BY PlayCount DESC LIMIT 5;

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
JOIN Albums al ON a.ArtistID = al.AlbumID
JOIN Tracks t ON al.AlbumID = t.AlbumID
GROUP BY a.Name;

-- E. Complex Join: User Sentiment Analysis
SELECT DISTINCT u.Username
FROM Users u
JOIN Favorites f ON u.UserID = f.UserID
JOIN Tracks t ON f.TrackID = t.TrackID
JOIN Albums al ON t.AlbumID = al.AlbumID
JOIN Artists a ON al.ArtistID = a.ArtistID
WHERE a.Name = 'Arijit Singh';

-- ---------------------------------------------------------
-- 5. ADVANCED FEATURES & OPTIMIZATION [Designed by Adit Ghosh]
-- ---------------------------------------------------------

-- Performance Indexes
CREATE INDEX idx_track_title ON Tracks(Title);
CREATE INDEX idx_artist_name ON Artists(Name);

-- Automation Trigger
DELIMITER //
CREATE TRIGGER AfterPlaybackInserted AFTER INSERT ON ListeningHistory FOR EACH ROW
BEGIN
    UPDATE Tracks SET PlayCount = PlayCount + 1 WHERE TrackID = NEW.TrackID;
END; //
DELIMITER ;

-- Business Intelligence View
CREATE OR REPLACE VIEW ArtistPerformance AS
SELECT a.Name AS Artist, COUNT(DISTINCT al.AlbumID) AS TotalAlbums, COUNT(t.TrackID) AS TotalSongs, SUM(t.PlayCount) AS TotalStreams
FROM Artists a
LEFT JOIN Albums al ON a.ArtistID = al.AlbumID
LEFT JOIN Tracks t ON al.AlbumID = t.AlbumID
GROUP BY a.ArtistID;

-- Final Verification
SELECT * FROM ArtistPerformance;
SELECT 'DATABASE READY' AS Status;
