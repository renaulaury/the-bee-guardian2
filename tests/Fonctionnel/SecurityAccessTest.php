<?php

// pour lancer test : php bin/phpunit tests/Fonctionnel/SecurityAccessTest.php


namespace App\Tests\Fonctionnel;

use Symfony\Bundle\FrameworkBundle\Test\WebTestCase;

class SecurityAccessTest extends WebTestCase
{
    public function testRedirectToLoginIfAnonymous(): void
    {
        $client = static::createClient();

        $client->request('GET', '/editProfile'); 
       
        $this->assertResponseRedirects('/login'); 
    }
}
