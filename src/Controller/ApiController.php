<?php
namespace App\Controller;

use App\Entity\Member;
use App\HttpClient\ApiHttpClient;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\component\Routing\Annotation\Route;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;

class ApiController extends AbstractController
{
    #[Route('/user', name: 'users_list')]
    public function index(ApiHttpClient $apiHttpClient): Response
    {
        $users = $apiHttpClient->getUsers();
        return $this->render('user/index.html.twig', [
            'users' => $users
        ]);
    }


    #[Route('/user/addMember', name: 'addMember', methods: 'POST')]
    public function addMember(EntityManagerInterface $entityManager, Request $request, ?Member $member)
    {
        $member = new Member();

        $title = filter_input(INPUT_POST, 'title', FILTER_SANITIZE_FULL_SPECIAL_CHARS);
        $last = filter_input(INPUT_POST, 'last', FILTER_SANITIZE_FULL_SPECIAL_CHARS);
        $first = filter_input(INPUT_POST, 'first', FILTER_SANITIZE_FULL_SPECIAL_CHARS);
        $email = filter_input(INPUT_POST, 'email', FILTER_SANITIZE_FULL_SPECIAL_CHARS);
        $phone = filter_input(INPUT_POST, 'phone', FILTER_SANITIZE_FULL_SPECIAL_CHARS);
        $picture = filter_input(INPUT_POST, 'picture', FILTER_SANITIZE_FULL_SPECIAL_CHARS);
        $streetnumber = filter_input(INPUT_POST, 'streetnumber', FILTER_SANITIZE_FULL_SPECIAL_CHARS);
        $streetname = filter_input(INPUT_POST, 'streetname', FILTER_SANITIZE_FULL_SPECIAL_CHARS);
        $postcode = filter_input(INPUT_POST, 'postcode', FILTER_SANITIZE_FULL_SPECIAL_CHARS);
        $city = filter_input(INPUT_POST, 'city', FILTER_SANITIZE_FULL_SPECIAL_CHARS);
        $country = filter_input(INPUT_POST, 'country', FILTER_SANITIZE_FULL_SPECIAL_CHARS);

        if($title && $last && $first && $last && $email && $phone && $picture && $streetnumber && $streetname && $postcode && $city && $country) {
            $member->setTitle($title);
            $member->setLast($last);
            $member->setFirst($first);
            $member->setEmail($email);
            $member->setPhone($phone);
            $member->setPicture($picture);
            $member->setStreetnumber($streetnumber);
            $member->setStreetname($streetname);
            $member->setPostcode($postcode);
            $member->setCity($city);
            $member->setCountry($country);

            $entityManager->persist($member);
            $entityManager->flush();

            return $this->redirectToRoute('users_list');
        } else {
            return $this->redirectToRoute('users_list');
        }
    }
}