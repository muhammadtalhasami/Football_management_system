USE sys;

create table team_rank (
       TEAM_ID INT ,
	   win int, 
	   draw int,
       lose int,
       points int

);

create table matches (
       match_id INT PRIMARY KEY,
	   date_ char(20), 
	   venue char(20),
       result char(20),
       hometeam_id int,
       awayteam_id int	
);

Create the table within the selected database
CREATE TABLE team_bar (
    TEAM_ID INT PRIMARY KEY,
    TEAM_NAME CHAR(20)
);

Inserting data into the team_bar table
INSERT INTO players (player_id, team_id,fname,lname,position,jerseyno)
VALUES
	('ZI17',3,'Zlatan','Ibrahimović','CENTER FORWARD',17 );

CREATE TABLE players (
    player_id INT PRIMARY KEY,
    team_id int,
    fname CHAR(20),
    lname char(20),
    position char(20),
    jerseyno int
);

ALTER TABLE players
ADD CONSTRAINT fk_team_id
FOREIGN KEY (team_id)
REFERENCES team_bar(TEAM_ID);

ALTER TABLE matches
ADD CONSTRAINT fk_h_id
FOREIGN KEY (hometeam_id)
REFERENCES team_bar(TEAM_ID);

ALTER TABLE matches
ADD CONSTRAINT fk_a_id
FOREIGN KEY (awayteam_id)
REFERENCES team_bar(TEAM_ID);

ALTER TABLE team_rank
ADD CONSTRAINT fk_tr_id
FOREIGN KEY (TEAM_ID)
REFERENCES team_bar(TEAM_ID);

DELIMITER //
CREATE TRIGGER check_player_count
BEFORE INSERT ON players
FOR EACH ROW
BEGIN
    DECLARE player_count INT;

    SELECT COUNT(*) INTO player_count
    FROM players
    WHERE player_id = NEW.player_id;

    IF player_count >= 11 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot insert more than 11 players with the same player_id in a team.';
    END IF;
END;
//
DELIMITER ;

