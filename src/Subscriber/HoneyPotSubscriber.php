<?php

namespace App\Subscriber;

use Psr\Log\LoggerInterface;
use Symfony\Component\Form\FormError;
use Symfony\Component\Form\FormEvent; 
use Symfony\Component\Form\FormEvents;
use Symfony\Component\HttpFoundation\RequestStack;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

class HoneyPotSubscriber implements EventSubscriberInterface
{
    private string $fieldName;
    private LoggerInterface $logger;
    private RequestStack $requestStack;


    public function __construct(string $fieldName, LoggerInterface $logger, RequestStack $requestStack)
    {
        $this->fieldName = $fieldName; //Clé du champ honeypot
        $this->logger = $logger; //Injecter par autowire
        $this->requestStack = $requestStack;
    }

    //Ecoute des forms avant soumission
    public static function getSubscribedEvents(): array
    {
        return [
           FormEvents::PRE_SUBMIT => 'onPreSubmit', //Se déclenche après clic et avant validation
        ];
    }


   public function onPreSubmit(FormEvent $event): void
    {
        //Récup des données
        $data = $event->getData();
        $form = $event->getForm();

        // Vérifier si le champ honeypot existe et est rempli -> c'est un bot
        if (isset($data[$this->fieldName]) && !empty($data[$this->fieldName])) {      
            
            // Récupérer l'adresse IP
            $ipAdress = $this->requestStack->getMainRequest(); //Retourne l'objet Request
            $ipAddress = $ipAdress ? $ipAdress->getClientIp() : 'unknown'; //nul si != req HTTP princ

            //Logger l'event
            $this->logger->warning('Bot detected (Honeypot)', [
                'form_name' => $form->getName(),
                'field_name' => $this->fieldName,
                'value_submitted' => $data[$this->fieldName],
                'ip_address' => $ipAddress,
            ]);


            $form->addError(new FormError('An error was coming.'));
        }

        // Tjs supprimer le champ honeypot des données        
        if (isset($data[$this->fieldName])) {
            unset($data[$this->fieldName]);
            $event->setData($data); 
        }
    }
}