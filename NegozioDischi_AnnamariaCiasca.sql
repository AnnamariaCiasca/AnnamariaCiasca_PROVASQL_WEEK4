CREATE DATABASE NegozioDischi;

CREATE TABLE Band (
	IdBand INTEGER IDENTITY(1,1) NOT NULL, 
	Nome NVARCHAR(40) NOT NULL,
	NumeroComponenti INTEGER NOT NULL,
	CONSTRAINT Band_PK PRIMARY KEY(IdBand),
	CONSTRAINT CHK_Band CHECK (NumeroComponenti>1), --ho aggiunto questo check perché affinché sia una band devono esserci almeno 2 componenti
);


CREATE TABLE Album (
	IdAlbum INTEGER IDENTITY(1,1) NOT NULL, 
	Titolo NVARCHAR(60) NOT NULL,
	AnnoDiUscita INTEGER NOT NULL,   --ho deciso di farlo di tipo INT perché la traccia richiede solo l'anno, metto un vincolo di CHECK per impedire che venga inserito un anno inferiore al 1900
	CasaDiscografica NVARCHAR(40) NOT NULL,
    Genere NVARCHAR(40) NOT NULL,
    SupportoDiDistribuzione NVARCHAR(40) NOT NULL,
	IdBand INTEGER NOT NULL,
	CONSTRAINT Album_PK PRIMARY KEY(IdAlbum),
    CONSTRAINT CHK1_Album CHECK (Genere='Classico' OR Genere='Pop' OR Genere='Jazz' OR Genere='Rock' OR Genere='Metal'),
	CONSTRAINT CHK2_Album CHECK (SupportoDiDistribuzione='CD' OR SupportoDiDistribuzione='Vinile' OR SupportoDiDistribuzione='Streaming'),
    CONSTRAINT CHK3_Album CHECK (AnnoDiUscita>1900),
	CONSTRAINT U_Album UNIQUE(Titolo, AnnoDiUscita, CasaDiscografica, Genere, SupportoDiDistribuzione),
    CONSTRAINT Album_FK FOREIGN KEY(IdBand) REFERENCES Band(IdBand),
);

CREATE TABLE Brano (
	IdBrano INTEGER IDENTITY(1,1) NOT NULL, 
	Titolo NVARCHAR(60) NOT NULL,
    Durata INTEGER NOT NULL,    --poiché specifica espressa in secondi, l'ho messa di tipo INT invece di DATE
	CONSTRAINT Brano_PK PRIMARY KEY(IdBrano),
	CONSTRAINT CHK_Brano CHECK (Durata>20),  --ipotizzo una durata quantomeno maggiore di 20 secondi
);

CREATE TABLE BranoAlbum (
	IdBrano INTEGER NOT NULL, 
    IdAlbum INTEGER NULL, 
	CONSTRAINT BranoAlbum_FK FOREIGN KEY(IdBrano) REFERENCES Brano(IdBrano),
	CONSTRAINT BranoAlbum2_FK FOREIGN KEY(IdAlbum) REFERENCES Album(IdAlbum),
);



INSERT INTO Band VALUES ('883', 5);
INSERT INTO Band VALUES ('TheGiornalisti', 3);
INSERT INTO Band VALUES ('Maneskin', 4);
INSERT INTO Band VALUES ('Beatles', 4);
INSERT INTO Band VALUES ('Queen', 4);
INSERT INTO Band VALUES ('AC/DC', 6);
INSERT INTO Band VALUES ('Oasis', 2);
-----------------------PROVA PER VERIFICARE CHE L'UTENTE NON POSSA INSERIRE UNA 'BAND' FORMATA DA UN UNICO COMPONENTE) -ok
INSERT INTO Band VALUES ('Vasco Rossi', 1);

------883------
INSERT INTO Album VALUES ('Hanno ucciso l''uomo ragno', 1992, 'Fri Records', 'Pop', 'CD', 1);
INSERT INTO Album VALUES ('Nord Sud Ovest Est', 1993, 'Fri Records', 'Pop', 'CD', 1);
INSERT INTO Album VALUES ('Gli Anni', 1998, 'Fri Records', 'Pop', 'CD', 1); --raccolta


-----------------------PROVA PER VERIFICARE CHE L'UTENTE NON POSSA INSERIRE UN GENERE NON PRESENTE FRA QUELLI DEL CHECK -ok
INSERT INTO Album VALUES ('ABC', 1998, 'Fri Records', 'Rap', 'CD', 1); 
-----------------------PROVA PER VERIFICARE CHE L'UTENTE NON POSSA INSERIRE UN Supporto NON PRESENTE FRA QUELLI DEL CHECK -ok
INSERT INTO Album VALUES ('ABC', 1998, 'Fri Records', 'Pop', 'MP3', 1); 
-----------------------PROVA PER VERIFICARE CHE L'UTENTE NON POSSA INSERIRE UN ANNO PRECEDENTE AL 1900 -ok
INSERT INTO Album VALUES ('ABC', 1888, 'Fri Records', 'Pop', 'CD', 1); 
-----------------------PROVA PER VERIFICARE IL FUNZIONAMENTO DELLA UNIQUE COMPOSTA -ok
INSERT INTO Album VALUES ('Nord Sud Ovest Est', 1993, 'Fri Records', 'Pop', 'CD', 2);



------TheGiornalisti------
INSERT INTO Album VALUES ('Completamente Sold Out', 2016, 'Carosello', 'Pop', 'CD', 2);
INSERT INTO Album VALUES ('Love', 2018, 'Carosello', 'Pop', 'CD', 2);
INSERT INTO Album VALUES ('Love', 2018, 'Carosello', 'Pop', 'Streaming', 2);

------Maneskin------
INSERT INTO Album VALUES ('Il ballo della vita', 2018, 'Sony Music', 'Rock', 'CD', 3);
INSERT INTO Album VALUES ('Il ballo della vita', 2018, 'Sony Music', 'Rock', 'Streaming', 3);
INSERT INTO Album VALUES ('Teatro d ira - Vol. I', 2021, 'Sony Music', 'Pop', 'CD', 3);
INSERT INTO Album VALUES ('Teatro d ira - Vol. I', 2021, 'Sony Music', 'Pop', 'Streaming', 3);

------Beatles------
INSERT INTO Album VALUES ('Let It Be', 1970, 'Apple Records', 'Rock', 'CD', 4);
INSERT INTO Album VALUES ('Let It Be', 1970, 'Apple Records', 'Rock', 'Vinile', 4);

------Queen------
INSERT INTO Album VALUES ('A Night At The Opera', 1975, 'EMI', 'Classico', 'CD', 5);

------AC/DC------
INSERT INTO Album VALUES ('Let There Be Rock', 1977, 'Atlantic Records', 'Metal', 'CD', 6);



INSERT INTO Album VALUES('Ciao ciao', 2020, 'Sony Music', 'Rock', 'CD', 3); --album inesistente inserito per la verifica del corretto funzionamento della query 2



INSERT INTO Brano VALUES ('Hanno ucciso l'''' Uomo Ragno', 190);
INSERT INTO Brano VALUES ('Come un Deca', 300);
INSERT INTO Brano VALUES ('Come mai', 310);
INSERT INTO Brano VALUES ('Nord Sud Ovest Est', 180);
INSERT INTO Brano VALUES ('Gli Anni', 200);
-----------------------PROVA PER VERIFICARE CHE L'UTENTE NON POSSA INSERIRE UNA DURATA INFERIORE AI 20 SECONDI -ok
INSERT INTO Brano VALUES ('Gli Anni', 10);

INSERT INTO Brano VALUES ('Completamente', 180);
INSERT INTO Brano VALUES ('Sold Out', 300);
INSERT INTO Brano VALUES ('Sbagliare a vivere', 210);
INSERT INTO Brano VALUES ('New York', 240);
INSERT INTO Brano VALUES ('Questa nostra stupida canzone d amore', 340);

INSERT INTO Brano VALUES ('Torna a casa', 190);
INSERT INTO Brano VALUES ('Le parole lontane', 210);
INSERT INTO Brano VALUES ('Morirò da re', 210);
INSERT INTO Brano VALUES ('Zitti e buoni', 240);
INSERT INTO Brano VALUES ('I wanna be your slave', 280);

INSERT INTO Brano VALUES ('Let It Be', 180);
INSERT INTO Brano VALUES ('Imagine', 300);

INSERT INTO Brano VALUES ('Bohemian Rhapsody', 550);

INSERT INTO Brano VALUES ('Overdose', 400);

INSERT INTO Brano VALUES('We Will Rock You', 500); --questi 2 brani non vengono inseriti in nessun album
INSERT INTO Brano VALUES('Radio Ga Ga', 430);
INSERT INTO BranoAlbum VALUES (20, NULL);
INSERT INTO BranoAlbum VALUES (21, NULL);


INSERT INTO BranoAlbum VALUES (1,1);
INSERT INTO BranoAlbum VALUES (2,1);
INSERT INTO BranoAlbum VALUES (3,2);
INSERT INTO BranoAlbum VALUES (4,2);
INSERT INTO BranoAlbum VALUES (5,2);
INSERT INTO BranoAlbum VALUES (1,3);
INSERT INTO BranoAlbum VALUES (3,3);
INSERT INTO BranoAlbum VALUES (4,3);
INSERT INTO BranoAlbum VALUES (5,3);

INSERT INTO BranoAlbum VALUES (6,4);
INSERT INTO BranoAlbum VALUES (7,4);
INSERT INTO BranoAlbum VALUES (8,4);
INSERT INTO BranoAlbum VALUES (9,5);
INSERT INTO BranoAlbum VALUES (10,5);

INSERT INTO BranoAlbum VALUES (6,4);
INSERT INTO BranoAlbum VALUES (7,4);
INSERT INTO BranoAlbum VALUES (8,4);
INSERT INTO BranoAlbum VALUES (9,5);
INSERT INTO BranoAlbum VALUES (10,5);
INSERT INTO BranoAlbum VALUES (9,6);
INSERT INTO BranoAlbum VALUES (10,6);

INSERT INTO BranoAlbum VALUES (11,7);
INSERT INTO BranoAlbum VALUES (12,7);
INSERT INTO BranoAlbum VALUES (13,7);
INSERT INTO BranoAlbum VALUES (11,8);
INSERT INTO BranoAlbum VALUES (12,8);
INSERT INTO BranoAlbum VALUES (13,8);
INSERT INTO BranoAlbum VALUES (14,9);
INSERT INTO BranoAlbum VALUES (15,9);
INSERT INTO BranoAlbum VALUES (14,10);
INSERT INTO BranoAlbum VALUES (15,10);


INSERT INTO BranoAlbum VALUES (16,11);
INSERT INTO BranoAlbum VALUES (17,11);
INSERT INTO BranoAlbum VALUES (16,12);
INSERT INTO BranoAlbum VALUES (17,12);

INSERT INTO BranoAlbum VALUES (18,15);

INSERT INTO BranoAlbum VALUES (19,14);



SELECT * FROM Band
SELECT * FROM Brano
SELECT * FROM Album
SELECT * FROM BranoAlbum


--1.Scrivere una query che restituisca i titoli degli album degli “883” in ordine alfabetico;
SELECT a.Titolo as [Titolo dell'Album]
FROM Album a INNER JOIN Band b ON b.IdBand = a.IdBand
WHERE b.Nome='883'
ORDER BY a.Titolo --ok


--2.Selezionare tutti gli album della casa discografica “Sony Music” relativi all’anno 2020;
SELECT *
FROM Album
WHERE CasaDiscografica='Sony Music' AND AnnoDiUscita=2020; --ok, è l'unico


--3.Scrivere una query che restituisca tutti i titoli delle canzoni dei “Maneskin” appartenenti ad album pubblicati prima del 2019;SELECT DISTINCT b.Titolo  --ho usato il distinct perché ci sono album presenti sia sottoforma di CD che streaming
FROM Brano b INNER JOIN BranoAlbum ba ON b.IdBrano = ba.IdBrano
             INNER JOIN Album a ON a.IdAlbum = ba.IdAlbum
			 INNER JOIN Band ON Band.IdBand = a.IdBand
WHERE band.Nome='Maneskin' AND a.AnnoDiUscita<2019; --ok, le altre canzoni sono successive


--4.Individuare tutti gli album in cui è contenuta la canzone “Imagine”
SELECT DISTINCT a.Titolo as [Album contenente 'Imagine'], a.AnnoDiUscita, a.CasaDiscografica, a.Genere
FROM Album a INNER JOIN BranoAlbum ba ON ba.IdAlbum = a.IdAlbum
             INNER JOIN Brano b ON b.IdBrano = ba.IdBrano
WHERE b.Titolo='Imagine'; --ok, infatti è l'unico


--5.Restituire il numero totale di canzoni eseguite dalla band “The Giornalisti”
SELECT COUNT(DISTINCT br.IdBrano) as [Numero Totale Brani]
FROM Brano br INNER JOIN BranoAlbum ba ON br.IdBrano = ba.IdBrano
              RIGHT JOIN Album a ON a.IdAlbum = ba.IdAlbum
			  INNER JOIN Band b ON b.IdBand = a.IdBand
GROUP BY  b.Nome
HAVING b.Nome='TheGiornalisti' --ok



--6.Contare per ogni album, la “durata totale” cioè la somma dei secondi dei suoi brani
SELECT a.Titolo, SUM(DISTINCT b.Durata) as [Durata Totale]
FROM Brano b INNER JOIN BranoAlbum ba ON b.IdBrano = ba.IdBrano
             INNER JOIN Album a ON a.IdAlbum = ba.IdAlbum
GROUP BY a.Titolo --ok
ORDER BY [Durata Totale]  DESC   -- non richiesto, l'ho messo per correttezza di visualizzazione


--7.Mostrare i brani (distinti) degli “883” che durano più di 3 minuti
SELECT DISTINCT b.Titolo
FROM Brano b INNER JOIN BranoAlbum ba ON b.IdBrano = ba.IdBrano
             INNER JOIN Album a ON a.IdAlbum = ba.IdAlbum
			 INNER JOIN Band ON Band.IdBand = a.IdBand
WHERE Band.Nome='883' AND b.Durata>180   --funziona, infatti non mostra NORD SUD OVEST EST



INSERT INTO Band VALUES('Muffin', 10); --Band inesistente inserita per verificare corretto funzionamento della query successiva, poiché c'è solo 'Maneskin' che soddisfa la richiesta e volevo essere sicura
--8.Mostrare tutte le Band il cui nome inizia per “M” e finisce per “n”.
SELECT *
FROM Band
WHERE Nome like 'M%' AND Nome like '%n' --ok


--9.Mostrare il titolo dell’Album e di fianco un’etichetta che stabilisce che si tratta di un Album:
--‘Very Old’ se il suo anno di uscita è precedente al 1980,
--‘New Entry’ se l’anno di uscita è il 2021,
--‘Recente’ se il suo anno di uscita è compreso tra il 2010 e 2020,
--‘Old’ altrimenti

SELECT DISTINCT a.Titolo, a.AnnoDiUscita,  --ho usato il distinct perché ci sono album presenti sia sottoforma di CD che streaming
CASE
    WHEN a.AnnoDiUscita<1980 THEN 'Very Old'
    WHEN a.AnnoDiUscita=2021 THEN 'New Entry'
    WHEN a.AnnoDiUscita BETWEEN 2010 AND 2020 THEN 'Recente'
    ELSE 'Old'
END AS 'Classifica per Data di Uscita'
FROM Album a --ok
ORDER BY AnnoDiUscita; --non richiesto, ma ho pensato fosse più ordinato visualizzarli così


--10.Mostrare i brani non contenuti in nessun album.SELECT b.Titolo
FROM Brano b INNER JOIN BranoAlbum ba ON ba.IdBrano = b.IdBrano 
WHERE ba.IdAlbum IS NULL; --OK


--11.Motrare il Nome delle band che sono un duo
SELECT Nome
FROM Band
WHERE NumeroComponenti = 2; --OK


--12.Mostrare il titolo dell'album che contiene più brani
SELECT DISTINCT a.Titolo as [Album con più brani]
FROM Album a
WHERE (
(SELECT MAX([Numero brani Album]) as [Numero massimo brani]
FROM (
SELECT a.IdAlbum as ID, COUNT(br.IdBrano) as [Numero brani Album]
FROM Brano br INNER JOIN BranoAlbum ba ON ba.IdBrano = br.IdBrano
GROUP BY ba.IdBrano) as ContaBraniAlbum)
=
(SELECT COUNT(br.IdBrano) as [Numero brani Album]
FROM Brano br INNER JOIN BranoAlbum ba ON ba.IdBrano = br.IdBrano
WHERE a.IdAlbum= ba.IdAlbum)
)  --ok




--13.Mostrare tutte le band che hanno scritto 2 o più brani dopo il 2010
SELECT DISTINCT b.Nome
FROM Band b INNER JOIN Album a ON a.IdBand = b.IdBand
            INNER JOIN BranoAlbum ba ON ba.IdAlbum = a.IdAlbum
            INNER JOIN Brano br ON br.IdBrano = ba.IdBrano
WHERE EXISTS(
SELECT b.Nome, COUNT(DISTINCT br.IdBrano) as [Numero Brani]
FROM Brano br INNER JOIN BranoAlbum ba ON br.IdBrano = ba.IdBrano
              INNER JOIN Album a ON a.IdAlbum = ba.IdAlbum
			  INNER JOIN Band b ON b.IdBand = a.IdBand
GROUP BY b.Nome
HAVING COUNT(br.IdBrano)>2    --se eseguo la subquery da sola, mi restituisce le band che hanno composto più di 2 brani, ed il relativo numero di brani (883-5, Beatles-2, Maneskin-5, TheGiornalisti-5)
) AND a.AnnoDiUscita>2010 --ok  --eseguendo la query completa, mi seleziona solo le band che tali brani li hanno composti dopo il 2010



--14.Mostrare le band che hanno pubblicato brani di genere POP prima del 2000
SELECT DISTINCT b.Nome, a.Titolo, a.AnnoDiUscita
FROM Band b INNER JOIN Album a ON a.IdBand = b.IdBand
WHERE a.Genere = 'Pop' AND a.AnnoDiUscita<2000; --ok
