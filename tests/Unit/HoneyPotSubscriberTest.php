<?php
namespace App\Tests\Unit;

use Psr\Log\LoggerInterface;
use PHPUnit\Framework\TestCase; 
use App\Subscriber\HoneyPotSubscriber; 
use Symfony\Component\Form\FormError;
use Symfony\Component\Form\FormInterface;
use Symfony\Component\Form\Event\PreSubmitEvent;
use Symfony\Component\HttpFoundation\RequestStack;

class HoneyPotSubscriberTest extends TestCase
{
    /**
     * Teste que le champ honeypot est bien rempli donc présence d'un bot,
     * Teste que le HoneyPotSubscriber supprime le champ des données en fin de traitement
     */
    public function testFieldIsFilled(): void
    {

        // 1. Définir le nom du champ
        $fieldName = 'email_confirm'; 

        // 2. Créer les mocks des dépendances
        $logger = $this->createMock(LoggerInterface::class);
        $requestStack = $this->createMock(RequestStack::class);

        // 3. Créer l'instance du subscriber à tester
        $subscriber = new HoneyPotSubscriber( //même ordre que subscriber
            $fieldName,
            $logger,
            $requestStack,            
            // 'Bot detected' 
        );

        // 4. Préparer les données d'entrée (avant l'événement)
        $initialData = [
            'username' => 'Bot de 7 lieues',
            $fieldName => 'bot-gosse-du-6-7@spam.com'
        ];

        // 5. Créer un mock du formulaire
        $form = $this->createMock(FormInterface::class);

        // 6. Créer un *vrai* objet PreSubmitEvent
        // C'est plus simple que de mocker l'événement lui-même
        $event = new PreSubmitEvent($form, $initialData);

        // 7. Définir nos attentes (Assertions)
        // Le logger DOIT être appelé
        $logger->expects($this->once())
            ->method('warning')
            ->with('Bot detected (Honeypot)'); //idem que subscriber

        // Le formulaire DOIT recevoir une erreur
        $form->expects($this->once())
            ->method('addError')
            ->with($this->isInstanceOf(FormError::class));



        // --- Action ---

        // On déclenche la méthode que l'on veut tester
        $subscriber->onPreSubmit($event);


        // --- ASSERT (Vérif) ---

        // On récupère les données *modifiées* depuis l'événement
        $finalData = $event->getData();

        // On vérifie que le champ honeypot a bien été supprimé
        $this->assertArrayNotHasKey($fieldName, $finalData);

    }
}