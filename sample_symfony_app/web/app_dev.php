<?php require __DIR__ . '/../vendor/autoload.php';

use PhpAmqpLib\Connection\AMQPConnection;
use PhpAmqpLib\Message\AMQPMessage;

?>
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

$transport = Swift_SmtpTransport::newInstance('mailer', 25);
$mailer = Swift_Mailer::newInstance($transport);
$message = Swift_Message::newInstance('Mail sent from the app container')
   ->setFrom(array('awesome@dev.org' => 'John Doe'))
   ->setTo(array('everyone@on-earth.com', 'other@domain.org' => 'A name'))
   ->setBody('Here is the body of the email.');
$mailer->send($message);
?>
<br/>
A mail was just sent. <a href="sample.web.docker:1080">Check your mail!</a>

<br/>
Ok now let us try to publish a message on rabbitmq!
<?php

$connection = new AMQPConnection('messagebroker', 5672, 'admin', 'admin');
$channel = $connection->channel();
$channel->queue_declare('hello', false, false, false, false);

$msg = new AMQPMessage('Hello World!');
$channel->basic_publish($msg, '', 'hello');
$channel->close();
$connection->close();
?>
Go check <a href="localhost:15672">the administration interface</a>
