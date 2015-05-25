I am a sample symfony app, in development mode! Here is some php:
<?= time();?>
Now, let us try to access the database.
<?php $dbh = new PDO('pgsql:host=database;dbname=sample_app', 'sample_app', 'sample_app');
$statement = $dbh->query('SELECT NOW();');
$time = $statement->fetchObject()->now;
;?>
<br/>
Here is the time, right from the database: <?= $time;
