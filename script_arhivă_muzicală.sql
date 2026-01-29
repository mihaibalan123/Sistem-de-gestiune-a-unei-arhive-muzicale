drop table continut_lista;
drop table lista_piese;
drop table utilizator;
drop table piesa;
drop table album;
drop table casa_de_discuri;
drop table trupa;
drop table locatie;

create table locatie (
    id_locatie number(4),
    tara varchar2(20) not null,
    oras varchar2(20),
    primary key (id_locatie)
);

insert into locatie (id_locatie, tara, oras) values (1, 'SUA', 'Aberdeen');
insert into locatie (id_locatie, tara, oras) values (2, 'SUA', 'San Francisco');
insert into locatie (id_locatie, tara, oras) values (3, 'UK', 'Basildon');
insert into locatie (id_locatie, tara, oras) values (4, 'Romania', 'Timisoara');
insert into locatie (id_locatie, tara, oras) values (5, 'Romania', 'Focsani');
insert into locatie (id_locatie, tara, oras) values (6, 'Germania', 'Berlin');
insert into locatie (id_locatie, tara, oras) values (7, 'UK', 'Manchester');
insert into locatie (id_locatie, tara, oras) values (8, 'Finlanda', 'Kouvola');
insert into locatie (id_locatie, tara, oras) values (9, 'Canada', 'Norwood');
insert into locatie (id_locatie, tara, oras) values (10, 'SUA', 'Los Angeles');


create table trupa (
    id_trupa number(4),
    id_locatie number(4) not null,
    nume_trupa varchar2(20) not null,
    an_lansare date not null,
    status varchar2(10) not null,
    logo varchar2(255),
    constraint trupa_fk_1 
        foreign key (id_locatie) 
        references locatie (id_locatie)
		on delete cascade,
    primary key (id_trupa),
    constraint check_status_format 
        check (status in ('ACTIVA','DESPARTITI','NECUNOSCUT')),
    constraint check_url_format_logo 
        check (logo is null or regexp_like(logo, '^https?://.*\..*$'))
);

insert into trupa (id_trupa, id_locatie, nume_trupa, an_lansare, status, logo) 
values (1, 1, 'Nirvana', to_date('1987-01-01', 'YYYY-MM-DD'), 'DESPARTITI', 'https://upload.wikimedia.org/wikipedia/commons/1/19/Nirvana_around_1992.jpg');
insert into trupa (id_trupa, id_locatie, nume_trupa, an_lansare, status, logo) 
values (2, 2, 'Metallica', to_date('1981-10-28', 'YYYY-MM-DD'), 'ACTIVA', 'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3e/Metallica_live_London_2003-12-19.jpg/500px-Metallica_live_London_2003-12-19.jpg');
insert into trupa (id_trupa, id_locatie, nume_trupa, an_lansare, status, logo) 
values (3, 3, 'Depeche Mode', to_date('1980-01-01', 'YYYY-MM-DD'), 'ACTIVA', 'https://upload.wikimedia.org/wikipedia/commons/thumb/7/78/Depeche_mode_in_portland_Nov_2023.jpg/500px-Depeche_mode_in_portland_Nov_2023.jpg');
insert into trupa (id_trupa, id_locatie, nume_trupa, an_lansare, status, logo) 
values (4, 4, 'Cargo', to_date('1985-01-01', 'YYYY-MM-DD'), 'ACTIVA', 'https://upload.wikimedia.org/wikipedia/commons/thumb/7/7f/Members_of_the_Romanian_band_Cargo.jpg/500px-Members_of_the_Romanian_band_Cargo.jpg');
insert into trupa (id_trupa, id_locatie, nume_trupa, an_lansare, status, logo) 
values (5, 5, 'Travka', to_date('2002-01-01', 'YYYY-MM-DD'), 'DESPARTITI', NULL);
insert into trupa (id_trupa, id_locatie, nume_trupa, an_lansare, status, logo) 
values (6, 6, 'Rammstein', to_date('1994-01-01', 'YYYY-MM-DD'), 'ACTIVA', 'https://upload.wikimedia.org/wikipedia/commons/thumb/8/8e/Rammstein_Live_at_Madison_Square_Garden.jpg/500px-Rammstein_Live_at_Madison_Square_Garden.jpg');
insert into trupa (id_trupa, id_locatie, nume_trupa, an_lansare, status, logo) 
values (7, 7, 'Joy Division', to_date('1976-01-01', 'YYYY-MM-DD'), 'DESPARTITI', 'https://upload.wikimedia.org/wikipedia/en/a/a0/Joy_Division_promo_photo.jpg');
insert into trupa (id_trupa, id_locatie, nume_trupa, an_lansare, status, logo) 
values (8, 8, 'To/Die/For', to_date('1993-01-01', 'YYYY-MM-DD'), 'ACTIVA', NULL);
insert into trupa (id_trupa, id_locatie, nume_trupa, an_lansare, status, logo) 
values (9, 9, 'Three Days Grace', to_date('1997-01-01', 'YYYY-MM-DD'), 'ACTIVA', 'https://upload.wikimedia.org/wikipedia/commons/thumb/9/92/ThreeDaysGrace2023.jpg/500px-ThreeDaysGrace2023.jpg');
insert into trupa (id_trupa, id_locatie, nume_trupa, an_lansare, status, logo) 
values (10, 10, 'A Perfect Circle', to_date('1999-01-01', 'YYYY-MM-DD'), 'ACTIVA', 'https://upload.wikimedia.org/wikipedia/commons/thumb/9/99/A_Perfect_Circle_Lollapalooza_Chile_2013.jpg/500px-A_Perfect_Circle_Lollapalooza_Chile_2013.jpg');

create table casa_de_discuri (
    id_casa_de_discuri number(4),
    nume_casa varchar2(20) not null,
    data_infiintare date not null,
    site_online varchar2(255),
    telefon varchar2(20),
    primary key (id_casa_de_discuri),
    constraint check_url_format_site 
        check (site_online is null or regexp_like(site_online, '^https?://.*\..*$'))
);

insert into casa_de_discuri (id_casa_de_discuri, nume_casa, data_infiintare, site_online, telefon) 
values (1,'DGC', to_date('1990-01-01', 'YYYY-MM-DD'), 'https://www.geffen.com', '0210000000');
insert into casa_de_discuri (id_casa_de_discuri, nume_casa, data_infiintare, site_online, telefon) 
values (2,'Elektra', to_date('1950-10-10', 'YYYY-MM-DD'), 'https://www.elektra.com', '0215556666');
insert into casa_de_discuri (id_casa_de_discuri, nume_casa, data_infiintare, site_online, telefon)
values (3, 'Mute Records', to_date('1978-01-01', 'YYYY-MM-DD'), 'https://www.mute.com', '0207000111');
insert into casa_de_discuri (id_casa_de_discuri, nume_casa, data_infiintare, site_online, telefon) 
values (4, 'Sub Pop', to_date('1986-04-01', 'YYYY-MM-DD'), 'https://www.subpop.com', '0206441888');
insert into casa_de_discuri (id_casa_de_discuri, nume_casa, data_infiintare, site_online, telefon) 
values (5, 'MediaPro Music', to_date('1997-01-01', 'YYYY-MM-DD'), 'https://www.mediapromusic.ro', '0212000200');
insert into casa_de_discuri (id_casa_de_discuri, nume_casa, data_infiintare, site_online, telefon) 
values (6, 'Soft Records', to_date('2000-01-01', 'YYYY-MM-DD'), 'https://www.softrecords.ro', '0214445555');
insert into casa_de_discuri (id_casa_de_discuri, nume_casa, data_infiintare, site_online, telefon) 
values (7, 'Motor Music', to_date('1994-01-01', 'YYYY-MM-DD'), 'https://www.universal-music.de', '0305200700');
insert into casa_de_discuri (id_casa_de_discuri, nume_casa, data_infiintare, site_online, telefon) 
values (8, 'Factory Records', to_date('1978-01-24', 'YYYY-MM-DD'), 'https://www.factoryrecords.org', '0161234567');
insert into casa_de_discuri (id_casa_de_discuri, nume_casa, data_infiintare, site_online, telefon) 
values (9, 'Spinefarm Records', to_date('1990-01-01', 'YYYY-MM-DD'), 'https://www.spinefarmrecords.com', '0925220000');
insert into casa_de_discuri (id_casa_de_discuri, nume_casa, data_infiintare, site_online, telefon) 
values (10, 'Jive Records', to_date('1977-01-01', 'YYYY-MM-DD'), 'https://www.jiverecords.com', '0416555123');
insert into casa_de_discuri (id_casa_de_discuri, nume_casa, data_infiintare, site_online, telefon) 
values (11, 'Virgin Records', to_date('1972-01-01', 'YYYY-MM-DD'), 'https://www.virginrecords.com', '0207777888');

create table album (
    id_album number(4),
    id_trupa number(4) not null,
    id_casa_de_discuri number(4) not null,
    titlu_album varchar2(30) not null,
    an_lansare number(4) not null,
    tip_album varchar2(10),
    url_imagine varchar2(255),
    constraint album_fk_1 
        foreign key (id_trupa) 
        references trupa (id_trupa),
    constraint album_fk_2 
        foreign key (id_casa_de_discuri) 
        references casa_de_discuri (id_casa_de_discuri),
    primary key (id_album),
    constraint check_tip_album_format 
        check (tip_album is null or tip_album in ('SINGLE','EP','FULL')),
    constraint check_url_imagine_format 
        check (url_imagine is null or regexp_like(url_imagine, '^https?://.*\..*$'))
);

insert into album (id_album, id_trupa, id_casa_de_discuri, titlu_album, an_lansare, tip_album, url_imagine) 
values (1, 1, 1, 'Nevermind', 1991, 'FULL', 'https://upload.wikimedia.org/wikipedia/en/b/b7/NirvanaNevermindalbumcover.jpg');
insert into album (id_album, id_trupa, id_casa_de_discuri, titlu_album, an_lansare, tip_album, url_imagine) 
values (2, 2, 2, 'Black', 1991, 'FULL', 'https://upload.wikimedia.org/wikipedia/ro/2/2c/Metallica_-_Metallica_cover.jpg');
insert into album (id_album, id_trupa, id_casa_de_discuri, titlu_album, an_lansare, tip_album, url_imagine) 
values (3, 3, 3, 'Ultra', 1997, 'FULL', 'https://upload.wikimedia.org/wikipedia/ro/thumb/e/ea/Ultraalbum.jpg/500px-Ultraalbum.jpg');
insert into album (id_album, id_trupa, id_casa_de_discuri, titlu_album, an_lansare, tip_album, url_imagine) 
values (4, 1, 1, 'In Utero', 1993, 'FULL', 'https://upload.wikimedia.org/wikipedia/ro/e/e5/In_Utero_%28Nirvana%29_album_cover.jpg');
insert into album (id_album, id_trupa, id_casa_de_discuri, titlu_album, an_lansare, tip_album, url_imagine) 
values (5, 1, 4, 'Bleach', 1989, 'FULL', 'https://upload.wikimedia.org/wikipedia/en/a/a1/Nirvana-Bleach.jpg');
insert into album (id_album, id_trupa, id_casa_de_discuri, titlu_album, an_lansare, tip_album, url_imagine) 
values (6, 4, 5, 'Spiritus Sanctus', 2003, 'FULL', 'https://t2.genius.com/unsafe/430x430/https%3A%2F%2Fimages.genius.com%2F419224610e95d531c494eb58cc5c5cbf.500x500x1.jpg');
insert into album (id_album, id_trupa, id_casa_de_discuri, titlu_album, an_lansare, tip_album, url_imagine) 
values (7, 5, 6, 'Corabia Nebunilor', 2005, 'FULL', 'https://cdn.dc5.ro/img-prod/4282552751-2-240.jpeg');
insert into album (id_album, id_trupa, id_casa_de_discuri, titlu_album, an_lansare, tip_album, url_imagine) 
values (8, 6, 7, 'Mutter', 2001, 'FULL', 'https://upload.wikimedia.org/wikipedia/ro/5/5e/Mutter.jpg');
insert into album (id_album, id_trupa, id_casa_de_discuri, titlu_album, an_lansare, tip_album, url_imagine) 
values (9, 7, 8, 'Unknown Pleasures', 1979, 'FULL', 'https://upload.wikimedia.org/wikipedia/en/5/5a/UnknownPleasuresVinyl.jpg');
insert into album (id_album, id_trupa, id_casa_de_discuri, titlu_album, an_lansare, tip_album, url_imagine) 
values (10, 7, 8, 'Closer', 1980, 'FULL', 'https://upload.wikimedia.org/wikipedia/en/6/64/Joy_Division_Closer.jpg');
insert into album (id_album, id_trupa, id_casa_de_discuri, titlu_album, an_lansare, tip_album, url_imagine) 
values (11, 8, 9, 'All Eternity', 1999, 'FULL', 'https://t2.genius.com/unsafe/600x600/https%3A%2F%2Fimages.genius.com%2F021d79a9868a15d4b77f84b8962d8611.709x709x1.jpg');
insert into album (id_album, id_trupa, id_casa_de_discuri, titlu_album, an_lansare, tip_album, url_imagine) 
values (12, 9, 10, 'Three Days Grace', 2003, 'FULL', 'https://upload.wikimedia.org/wikipedia/en/e/e2/Three_Days_Grace_%282003_album%29.jpg');
insert into album (id_album, id_trupa, id_casa_de_discuri, titlu_album, an_lansare, tip_album, url_imagine) 
values (13, 9, 10, 'One-X', 2006, 'FULL', 'https://upload.wikimedia.org/wikipedia/en/c/cf/One_X.png');
insert into album (id_album, id_trupa, id_casa_de_discuri, titlu_album, an_lansare, tip_album, url_imagine) 
values (14, 9, 10, 'Life Starts Now', 2009, 'FULL', 'https://upload.wikimedia.org/wikipedia/en/6/68/Life_starts_now.jpg');
insert into album (id_album, id_trupa, id_casa_de_discuri, titlu_album, an_lansare, tip_album, url_imagine) 
values (15, 10, 11, 'Thirteenth Step', 2003, 'FULL', 'https://upload.wikimedia.org/wikipedia/en/b/bf/A_Perfect_Circle-Thirteenth_Step.jpg');

create table piesa (
    id_piesa number(4),
    id_album number(4) not null,
    titlu_piesa varchar2(40) not null,
    durata varchar2(5) not null,
    gen_muzical varchar2(20),
    constraint piesa_fk_1 
        foreign key (id_album) 
        references album (id_album),
    primary key (id_piesa),
    constraint check_durata_format 
        check (regexp_like(durata, '^[0-5][0-9]:[0-5][0-9]$') and durata != '00:00'),
    constraint check_gen_muzical 
    check (gen_muzical is null or gen_muzical in (
        'Pop',
        'Rock',
        'Hip-hop/Trap',
        'Electronic/Dance',
        'Manele',
        'Clasica',
        'Jazz/Blues',
        'Folk/Latino'
    ))
);

insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (1, 1, 'Smells Like Teen Spirit', '05:01', 'Rock');
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (2, 1, 'In Bloom', '04:14', 'Rock');
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (3, 1, 'Come As You Are', '03:39', 'Rock');
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (4, 1, 'Breed', '03:03', 'Rock');
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (5, 1, 'Lithium', '04:17', 'Rock');
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (6, 1, 'Polly', '02:57', 'Rock'); 
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (7, 1, 'Territorial Pissings', '02:23', 'Rock');
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (8, 1, 'Drain You', '03:43', 'Rock');
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (9, 1, 'Lounge Act', '02:36', 'Rock');
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (10, 1, 'Stay Away', '03:32', 'Rock');
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (11, 1, 'On A Plain', '03:16', 'Rock');
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (12, 1, 'Something In The Way', '03:51', 'Rock');
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (13, 1, 'Endless Nameless', '06:43', 'Rock');
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (14, 2, 'Enter Sandman', '05:31', 'Rock');
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (15, 2, 'Sad but True', '05:24', 'Rock');
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (16, 2, 'Holier Than Thou', '03:47', 'Rock');
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (17, 2, 'The Unforgiven', '06:27', 'Rock'); 
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (18, 2, 'Wherever I May Roam', '06:44', 'Rock');
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (19, 2, 'Dont Tread on Me', '04:00', 'Rock');
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (20, 2, 'Through the Never', '04:04', 'Rock');
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (21, 2, 'Nothing Else Matters', '06:28', 'Rock'); 
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (22, 2, 'Of Wolf and Man', '04:16', 'Rock');
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (23, 2, 'The God That Failed', '05:08', 'Rock');
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (24, 2, 'My Friend of Misery', '06:49', 'Rock');
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (25, 2, 'The Struggle Within', '03:53', 'Rock');
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (26, 3, 'Barrel of a Gun', '05:35', 'Electronic/Dance');
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (27, 3, 'The Love Thieves', '06:34', 'Electronic/Dance'); 
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (28, 3, 'Home', '05:42', 'Pop');
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (29, 3, 'Its No Good', '05:58', 'Electronic/Dance');
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (30, 3, 'Uselink', '02:21', 'Electronic/Dance');
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (31, 3, 'Useless', '05:12', 'Electronic/Dance'); 
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (32, 3, 'Sister of Night', '06:04', 'Electronic/Dance');
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (33, 3, 'Jazz Thieves', '02:54', 'Jazz/Blues');
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (34, 3, 'Freestate', '06:44', 'Electronic/Dance');
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (35, 3, 'The Bottom Line', '04:26', 'Pop'); 
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (36, 3, 'Insight', '06:26', 'Electronic/Dance');
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (37, 4, 'Serve the Servants', '03:36', 'Rock');
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (38, 4, 'Scentless Apprentice', '03:48', 'Rock');
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (39, 4, 'Heart-Shaped Box', '04:41', 'Rock');
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (40, 4, 'Rape Me', '02:50', 'Rock');
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (41, 4, 'Frances Farmer', '04:09', 'Rock');
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (42, 4, 'Dumb', '02:32', 'Rock');
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (43, 4, 'Very Ape', '01:56', 'Rock'); 
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (44, 4, 'Milk It', '03:55', 'Rock'); 
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (45, 4, 'Pennyroyal Tea', '03:37', 'Rock');
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (46, 4, 'Radio Friendly', '04:51', 'Rock'); 
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (47, 4, 'tourettes', '01:35', 'Rock'); 
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (48, 4, 'All Apologies', '03:51', 'Rock'); 
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (49, 5, 'Blew', '02:55', 'Rock');
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (50, 5, 'Floyd the Barber', '02:18', 'Rock');
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (51, 5, 'About a Girl', '02:48', 'Rock'); 
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (52, 5, 'School', '02:42', 'Rock');
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (53, 5, 'Love Buzz', '03:35', 'Rock'); 
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (54, 5, 'Paper Cuts', '04:06', 'Rock'); 
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (55, 5, 'Negative Creep', '02:56', 'Rock');
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (56, 5, 'Scoff', '04:10', 'Rock');
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (57, 5, 'Swap Meet', '03:03', 'Rock');
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (58, 5, 'Mr. Moustache', '03:24', 'Rock'); 
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (59, 5, 'Sifting', '05:22', 'Rock');
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (60, 5, 'Big Cheese', '03:42', 'Rock');
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (61, 5, 'Downer', '01:43', 'Rock'); 
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (62, 6, 'Spiritus Sanctus', '03:55', 'Rock');
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (63, 6, 'Nu ma lasa', '03:40', 'Rock');
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (64, 6, 'Fratii', '04:00', 'Rock');
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (65, 6, 'Daca ploaia', '04:40', 'Rock'); 
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (66, 6, 'Baga-ti mintile', '03:30', 'Rock');
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (67, 6, 'Zice lumea', '03:15', 'Rock');
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (68, 6, 'Calul din nori', '03:20', 'Rock');
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (69, 6, 'E o zi', '04:15', 'Rock'); 
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (70, 7, 'Corabia Nebunilor', '03:45', 'Rock');
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (71, 7, 'Ingeri pe trotuare', '03:12', 'Rock');
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (72, 7, 'Vreau sa simt Praga', '03:58', 'Rock');
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (73, 7, 'Noapte', '04:20', 'Rock');
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (74, 7, 'Zambetul tau', '03:30', 'Rock'); 
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (75, 7, 'Urban violent', '02:55', 'Rock');
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (76, 7, 'Ochii tai', '04:10', 'Rock');
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (77, 7, 'Soare rasare', '03:05', 'Rock');
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (78, 7, 'Ce noapte', '02:45', 'Rock');
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (79, 7, 'E cineva in oras', '05:15', 'Rock');
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (80, 8, 'Mein Herz brennt', '04:39', 'Electronic/Dance'); 
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (81, 8, 'Links 2 3 4', '03:36', 'Electronic/Dance'); 
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (82, 8, 'Sonne', '04:32', 'Electronic/Dance'); 
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (83, 8, 'Ich will', '03:37', 'Electronic/Dance'); 
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (84, 8, 'Feuer frei!', '03:08', 'Electronic/Dance'); 
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (85, 8, 'Mutter', '04:28', 'Electronic/Dance');
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (86, 8, 'Spieluhr', '04:46', 'Electronic/Dance'); 
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (87, 8, 'Zwitter', '04:17', 'Electronic/Dance');
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (88, 8, 'Rein Raus', '03:09', 'Electronic/Dance'); 
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (89, 8, 'Adios', '03:48', 'Electronic/Dance'); 
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (90, 8, 'Nebel', '04:54', 'Rock'); 
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (91, 9, 'Disorder', '03:32', 'Rock'); 
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (92, 9, 'Day of the Lords', '04:49', 'Rock'); 
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (93, 9, 'Candidate', '03:06', 'Rock'); 
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (94, 9, 'Insight', '04:29', 'Rock'); 
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (95, 9, 'New Dawn Fades', '04:47', 'Rock'); 
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (96, 9, 'She is Lost Control', '03:57', 'Rock'); 
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (97, 9, 'Shadowplay', '03:55', 'Rock'); 
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (98, 9, 'Wilderness', '02:38', 'Rock'); 
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (99, 9, 'Interzone', '02:16', 'Rock'); 
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (100, 9, 'I Remember Nothing', '05:53', 'Electronic/Dance'); 
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (101, 10, 'Atrocity Exhibition', '06:06', 'Rock'); 
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (102, 10, 'Isolation', '02:53', 'Electronic/Dance'); 
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (103, 10, 'Passover', '04:46', 'Rock'); 
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (104, 10, 'Colony', '03:55', 'Rock'); 
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (105, 10, 'A Means to an End', '04:07', 'Rock'); 
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (106, 10, 'Heart and Soul', '05:51', 'Rock');
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (107, 10, 'Twenty Four Hours', '04:26', 'Rock');
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (108, 10, 'The Eternal', '06:05', 'Rock'); 
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (109, 10, 'Decades', '06:10', 'Electronic/Dance'); 
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (110, 11, 'Farewell', '03:51', 'Rock'); 
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (111, 11, 'Live in You', '04:06', 'Rock'); 
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (112, 11, 'Our Candle Melts', '04:58', 'Rock'); 
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (113, 11, 'Dripping Down Red', '03:16', 'Rock');
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (114, 11, 'Sea of Sin', '04:36', 'Rock'); 
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (115, 11, 'Loveless', '02:56', 'Rock'); 
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (116, 11, 'One More Time', '05:55', 'Rock'); 
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (117, 11, 'Mary-Ann RIP', '04:34', 'Rock'); 
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (118, 11, 'Together Complete', '04:57', 'Rock'); 
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (119, 11, 'Rimed with Frost', '05:26', 'Rock'); 
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (120, 11, 'Lacrimarum', '05:16', 'Rock'); 
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (121, 12, 'Burn', '04:27', 'Rock'); 
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (122, 12, 'Just Like You', '03:08', 'Rock'); 
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (123, 12, 'I Hate Everything', '03:51', 'Rock');
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (124, 12, 'Home', '04:21', 'Rock'); 
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (125, 12, 'Scared', '03:13', 'Rock'); 
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (126, 12, 'Let You Down', '03:46', 'Rock');
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (127, 12, 'Now or Never', '03:00', 'Rock');
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (128, 12, 'Born Like This', '03:33', 'Rock');
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (129, 12, 'Drown', '03:28', 'Rock'); 
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (130, 12, 'Wake Up', '03:25', 'Rock'); 
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (131, 12, 'Take Me Under', '04:20', 'Rock'); 
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (132, 12, 'Overrated', '03:30', 'Rock');
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (133, 13, 'Its All Over', '04:09', 'Rock'); 
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (134, 13, 'Pain', '03:23', 'Rock');
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (135, 13, 'Animal I Have Become', '03:51', 'Rock'); 
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (136, 13, 'Never Too Late', '03:29', 'Pop'); 
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (137, 13, 'On My Own', '03:06', 'Rock');
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (138, 13, 'Riot', '03:28', 'Rock');
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (139, 13, 'Get Out Alive', '04:22', 'Rock'); 
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (140, 13, 'Let It Die', '03:09', 'Rock');
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (141, 13, 'Over and Over', '03:12', 'Rock'); 
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (142, 13, 'Time of Dying', '03:08', 'Rock'); 
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (143, 13, 'Gone Forever', '03:41', 'Pop'); 
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (144, 13, 'One-X', '04:46', 'Rock'); 
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (145, 14, 'Bitter Taste', '04:01', 'Rock');
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (146, 14, 'Break', '03:13', 'Rock'); 
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (147, 14, 'World So Cold', '04:03', 'Rock'); 
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (148, 14, 'Lost in You', '03:53', 'Pop'); 
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (149, 14, 'The Good Life', '02:53', 'Rock');
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (150, 14, 'No More', '03:45', 'Rock'); 
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (151, 14, 'Last to Know', '03:27', 'Pop'); 
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (152, 14, 'Someone Who Cares', '04:52', 'Rock');
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (153, 14, 'Bully', '03:39', 'Rock');
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (154, 14, 'Without You', '03:34', 'Pop'); 
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (155, 14, 'Goin Down', '03:06', 'Rock');
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (156, 14, 'Life Starts Now', '03:08', 'Rock'); 
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (157, 15, 'The Package', '07:40', 'Rock'); 
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (158, 15, 'Weak and Powerless', '03:15', 'Rock'); 
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (159, 15, 'The Noose', '04:53', 'Rock'); 
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (160, 15, 'Blue', '04:13', 'Rock'); 
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (161, 15, 'Vanishing', '04:51', 'Rock'); 
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (162, 15, 'A Stranger', '03:12', 'Rock'); 
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (163, 15, 'The Outsider', '04:06', 'Rock');
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (164, 15, 'Crimes', '02:34', 'Electronic/Dance');
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (165, 15, 'The Nurse Who Loved Me', '04:04', 'Rock');
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (166, 15, 'Pet', '04:34', 'Rock'); 
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (167, 15, 'Lullaby', '02:01', 'Electronic/Dance'); 
insert into piesa (id_piesa, id_album, titlu_piesa, durata, gen_muzical) 
values (168, 15, 'Gravity', '05:08', 'Rock'); 

create table utilizator (
    id_utilizator number(4),
    nume_utilizator varchar2(20) not null,
    telefon varchar2(20),
    email varchar2(30),
    primary key (id_utilizator),
    constraint check_email_format 
        check (email is null or regexp_like(email, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'))
);

insert into utilizator (id_utilizator, nume_utilizator, telefon, email) 
values (1, 'Rockerul90', '0722123456', 'fan.nirvana@gmail.com');
insert into utilizator (id_utilizator, nume_utilizator, telefon, email) 
values (2, 'MetalHead88', '0722000111', 'metal.head@yahoo.com');
insert into utilizator (id_utilizator, nume_utilizator, telefon, email) 
values (3, 'GrungeGirl', '0744222333', 'kurt.fan@gmail.com');
insert into utilizator (id_utilizator, nume_utilizator, telefon, email) 
values (4, 'VinylCollector', '0755123123', 'vinyl.lover@outlook.com');
insert into utilizator (id_utilizator, nume_utilizator, telefon, email) 
values (5, 'BassPlayer_RO', '0766999888', 'bass.man@music.ro');
insert into utilizator (id_utilizator, nume_utilizator, telefon, email) 
values (6, 'PopPrincess', '0723456789', 'pop.star@yahoo.co.uk');
insert into utilizator (id_utilizator, nume_utilizator, telefon, email) 
values (7, 'OldSchoolRocker', '0733555777', 'acdc.fan@rockfm.ro');
insert into utilizator (id_utilizator, nume_utilizator, telefon, email) 
values (8, 'IndieKid', '0799111222', 'arctic.monkeys@fest.eu');
insert into utilizator (id_utilizator, nume_utilizator, telefon, email) 
values (9, 'TechnoViking', '0777000000', 'rave.master@berlin.de');
insert into utilizator (id_utilizator, nume_utilizator, telefon, email) 
values (10, 'JazzCat', '0788444555', 'miles.davis@cooljazz.com');
insert into utilizator (id_utilizator, nume_utilizator, telefon, email) 
values (11, 'ChitaraRece', '0721333444', 'cargo.fan@yahoo.com');

create table lista_piese (
    id_lista number(4),
    id_utilizator number(4) not null,
    nume_lista varchar2(20) not null,
    data_crearii date not null,
    constraint lista_piese_fk_1 
        foreign key (id_utilizator) 
        references utilizator (id_utilizator),
    primary key (id_lista)
);

insert into lista_piese (id_lista, id_utilizator, nume_lista, data_crearii) values (1, 1, 'Best of Nirvana', sysdate);
insert into lista_piese (id_lista, id_utilizator, nume_lista, data_crearii) values (2, 2, 'Metal Gym', sysdate);
insert into lista_piese (id_lista, id_utilizator, nume_lista, data_crearii) values (3, 5, 'Chill Sunday', sysdate);
insert into lista_piese (id_lista, id_utilizator, nume_lista, data_crearii) values (4, 3, 'Grunge Classics', sysdate);
insert into lista_piese (id_lista, id_utilizator, nume_lista, data_crearii) values (5, 8, 'Indie Vibes', sysdate);
insert into lista_piese (id_lista, id_utilizator, nume_lista, data_crearii) values (6, 11, 'Ro Rock', sysdate);
insert into lista_piese (id_lista, id_utilizator, nume_lista, data_crearii) values (7, 4, 'Vinyl Collection', sysdate);
insert into lista_piese (id_lista, id_utilizator, nume_lista, data_crearii) values (8, 9, 'Dark Wave', sysdate);
insert into lista_piese (id_lista, id_utilizator, nume_lista, data_crearii) values (9, 1, 'My Favorites', sysdate);
insert into lista_piese (id_lista, id_utilizator, nume_lista, data_crearii) values (10, 6, 'Roadtrip Mix', sysdate);
insert into lista_piese (id_lista, id_utilizator, nume_lista, data_crearii) values (11, 7, 'Oldies but Goldies', sysdate);
insert into lista_piese (id_lista, id_utilizator, nume_lista, data_crearii) values (12, 10, 'Late Night', sysdate);
insert into lista_piese (id_lista, id_utilizator, nume_lista, data_crearii) values (13, 2, 'Angry Mode', sysdate);
insert into lista_piese (id_lista, id_utilizator, nume_lista, data_crearii) values (14, 5, 'Bass Lines', sysdate);
insert into lista_piese (id_lista, id_utilizator, nume_lista, data_crearii) values (15, 8, 'Focus Work', sysdate);
insert into lista_piese (id_lista, id_utilizator, nume_lista, data_crearii) values (16, 11, 'Mix Rock', sysdate);
insert into lista_piese (id_lista, id_utilizator, nume_lista, data_crearii) values (17, 1, 'Alternative Mix', sysdate);

create table continut_lista (
    id_lista number(4) not null,
    id_piesa number(4) not null,
    data_adaugarii date not null,
    constraint continut_lista_fk_1 
        foreign key (id_lista) 
        references lista_piese (id_lista),
    constraint continut_lista_fk_2 
        foreign key (id_piesa) 
        references piesa (id_piesa),
    primary key (id_lista, id_piesa)
);

insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (1, 1, sysdate);
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (1, 2, sysdate);
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (1, 3, sysdate);
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (2, 14, sysdate);
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (2, 84, sysdate);
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (2, 81, sysdate);
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (2, 138, sysdate);
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (2, 62, sysdate);
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (2, 16, sysdate);
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (3, 6, sysdate);
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (3, 12, sysdate);
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (3, 35, sysdate);
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (3, 42, sysdate);
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (3, 51, sysdate);
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (3, 69, sysdate);
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (4, 1, sysdate);
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (4, 3, sysdate);
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (4, 39, sysdate);
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (4, 49, sysdate);
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (4, 15, sysdate);
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (4, 122, sysdate);
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (4, 123, sysdate);
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (4, 5, sysdate);
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (5, 72, sysdate);
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (5, 77, sysdate);
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (5, 91, sysdate);
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (5, 102, sysdate);
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (5, 29, sysdate);
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (5, 70, sysdate);
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (5, 10, sysdate);
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (6, 65, sysdate);
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (6, 63, sysdate);
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (6, 71, sysdate);
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (6, 75, sysdate);
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (6, 78, sysdate);
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (6, 64, sysdate);
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (6, 68, sysdate);
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (7, 91, sysdate);
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (7, 97, sysdate);
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (7, 106, sysdate);
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (7, 26, sysdate);
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (7, 31, sysdate);
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (7, 30, sysdate);
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (8, 26, sysdate);
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (8, 32, sysdate);
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (8, 80, sysdate);
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (8, 110, sysdate);
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (8, 114, sysdate);
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (8, 92, sysdate);
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (8, 13, sysdate);
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (9, 4, sysdate);
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (9, 21, sysdate);
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (9, 135, sysdate);
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (9, 123, sysdate);
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (9, 82, sysdate);
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (9, 14, sysdate);
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (9, 64, sysdate);
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (9, 15, sysdate);
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (9, 17, sysdate);
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (10, 18, sysdate);
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (10, 28, sysdate);
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (10, 149, sysdate);
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (10, 22, sysdate);
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (10, 66, sysdate);
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (11, 21, sysdate);
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (11, 17, sysdate);
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (11, 1, sysdate);
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (11, 91, sysdate);
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (11, 65, sysdate);
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (12, 90, sysdate);
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (12, 89, sysdate);
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (12, 108, sysdate);
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (12, 111, sysdate);
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (12, 73, sysdate);
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (13, 123, sysdate);
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (13, 83, sysdate);
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (13, 81, sysdate);
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (13, 44, sysdate);
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (13, 7, sysdate);
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (13, 75, sysdate);
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (13, 133, sysdate);
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (14, 9, sysdate);
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (14, 23, sysdate);
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (14, 24, sysdate);
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (14, 96, sysdate);
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (14, 145, sysdate);
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (15, 30, sysdate);
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (15, 33, sysdate);
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (15, 105, sysdate);
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (16, 145, sysdate);
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (16, 12, sysdate);
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (16, 85, sysdate);
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (16, 40, sysdate);
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (16, 99, sysdate);
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (16, 116, sysdate);
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (17, 158, sysdate);
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (17, 159, sysdate); 
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (17, 163, sysdate); 
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (17, 1, sysdate); 
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (17, 39, sysdate);
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (17, 29, sysdate); 
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (17, 136, sysdate); 
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (17, 91, sysdate);
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (17, 168, sysdate); 
insert into continut_lista (id_lista, id_piesa, data_adaugarii) values (17, 166, sysdate); 

commit;	