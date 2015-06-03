<?php require __DIR__ . '/../vendor/autoload.php' ?>
I am a sample symfony app, in development mode! Here is some php:
<?= time();?>
<br/>
Now, let us try to access the database.
<?php $dbh = new PDO('pgsql:host=database;dbname=sample_app', 'sample_app', 'sample_app');
$statement = $dbh->query('SELECT NOW();');
$time = $statement->fetchObject()->now;
;?>
Here is the time, right from the database: <?= $time; ?>
<?php
    $memcache = new Memcache;
    $memcache->addServer('memcached');
?>
<br/>
And now let us try to get memcache's status (0 is bad) : <?= $memcache->getServerStatus('memcached');

$transport = Swift_SmtpTransport::newInstance('mailer', 1025);
$mailer = Swift_Mailer::newInstance($transport);
$message = Swift_Message::newInstance('Mail sent from the app container')
   ->setFrom(array('awesome@dev.org' => 'John Doe'))
   ->setTo(array('everyone@on-earth.com', 'other@domain.org' => 'A name'))
   ->setBody('Here is the body of the email.');
$mailer->send($message);
?>
<br/>
A mail was just sent. <a href="localhost:1080">Check your mail!</a>
