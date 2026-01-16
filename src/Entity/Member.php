<?php

namespace App\Entity;

use ApiPlatform\Metadata\Get;
use Doctrine\ORM\Mapping as ORM;
use App\Repository\MemberRepository;
use ApiPlatform\Metadata\ApiResource;
use ApiPlatform\Metadata\GetCollection;
use Symfony\Component\Serializer\Annotation\Groups;

#[ORM\Entity(repositoryClass: MemberRepository::class)]
#[ORM\Table(name: '`member`')]
#[ApiResource(
    operations: [
        new Get(normalizationContext: ['groups' => 'member:item']),
        new GetCollection(normalizationContext: ['groups' => 'member:list'])
    ]
)]
class Member
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    #[Groups(['member:list', 'member:item'])]
    private ?int $id = null;

    #[ORM\Column(length: 20)]
    #[Groups(['member:list', 'member:item'])]
    private ?string $title = null;

    #[ORM\Column(length: 100)]
    #[Groups(['member:list', 'member:item'])]
    private ?string $last = null;

    #[ORM\Column(length: 50)]
    #[Groups(['member:list', 'member:item'])]
    private ?string $first = null;

    #[ORM\Column(length: 255)]
    #[Groups(['member:list', 'member:item'])]
    private ?string $email = null;

    #[ORM\Column(length: 255)]
    #[Groups(['member:list', 'member:item'])]
    private ?string $phone = null;

    #[ORM\Column(length: 255)]
    #[Groups(['member:list', 'member:item'])]
    private ?string $picture = null;

    #[ORM\Column(length: 20)]
    #[Groups(['member:list', 'member:item'])]
    private ?string $streetnumber = null;

    #[ORM\Column(length: 50)]
    #[Groups(['member:list', 'member:item'])]
    private ?string $postcode = null;

    #[ORM\Column(length: 100)]
    #[Groups(['member:list', 'member:item'])]
    private ?string $city = null;

    #[ORM\Column(length: 50)]
    #[Groups(['member:list', 'member:item'])]
    private ?string $country = null;

    #[ORM\Column(length: 255)]
    #[Groups(['member:list', 'member:item'])]
    private ?string $Streetname = null;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getTitle(): ?string
    {
        return $this->title;
    }

    public function setTitle(string $title): static
    {
        $this->title = $title;

        return $this;
    }

    public function getLast(): ?string
    {
        return $this->last;
    }

    public function setLast(string $last): static
    {
        $this->last = $last;

        return $this;
    }

    public function getFirst(): ?string
    {
        return $this->first;
    }

    public function setFirst(string $first): static
    {
        $this->first = $first;

        return $this;
    }

    public function getEmail(): ?string
    {
        return $this->email;
    }

    public function setEmail(string $email): static
    {
        $this->email = $email;

        return $this;
    }

    public function getPhone(): ?string
    {
        return $this->phone;
    }

    public function setPhone(string $phone): static
    {
        $this->phone = $phone;

        return $this;
    }

    public function getPicture(): ?string
    {
        return $this->picture;
    }

    public function setPicture(string $picture): static
    {
        $this->picture = $picture;

        return $this;
    }

    public function getStreetnumber(): ?string
    {
        return $this->streetnumber;
    }

    public function setStreetnumber(string $streetnumber): static
    {
        $this->streetnumber = $streetnumber;

        return $this;
    }

    public function getPostcode(): ?string
    {
        return $this->postcode;
    }

    public function setPostcode(string $postcode): static
    {
        $this->postcode = $postcode;

        return $this;
    }

    public function getCity(): ?string
    {
        return $this->city;
    }

    public function setCity(string $city): static
    {
        $this->city = $city;

        return $this;
    }

    public function getCountry(): ?string
    {
        return $this->country;
    }

    public function setCountry(string $country): static
    {
        $this->country = $country;

        return $this;
    }

    public function setId(int $id): static
    {
        $this->id = $id;

        return $this;
    }

    public function getStreetname(): ?string
    {
        return $this->Streetname;
    }

    public function setStreetname(string $Streetname): static
    {
        $this->Streetname = $Streetname;

        return $this;
    }
}
