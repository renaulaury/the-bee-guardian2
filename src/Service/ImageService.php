<?php

namespace App\Service;

/**
 * Service de traitement d'images.
 * Responsable de la conversion de formats et du redimensionnement.
 * Ce service peut être injecté dans un contrôleur ou autre service.
 */
class ImageService
{
    /**
     * Convertit une image source (JPEG, PNG) en format WebP.
     * Gère également l'augmentation de la limite mémoire et le redimensionnement.
     *
     * @param string $sourcePath Chemin absolu vers le fichier image source.
     * @param string $destinationPath Chemin absolu où enregistrer l'image WebP.
     * @throws \Exception Si le format d'image n'est pas supporté (considérer une exception plus spécifique).
     * @return void
     */
    public function convertToWebP(string $sourcePath, string $destinationPath): void
    {
        ini_set('memory_limit', '512M'); // Augmente temporairement la limite de mémoire

        // Utilisation de getimagesize() pour une vérification initiale.
        $imageInfo = getimagesize($sourcePath);

        // Vérification du résultat de getimagesize. 
        //Une image invalide pourrait retourner false. Ajout d'une vérification de nullité/false recommandé.
        if ($imageInfo === false) {
             throw new \Exception('Impossible de lire l\'image ou le fichier est invalide.');
        }

        $mimeType = $imageInfo['mime'];
        $image = null; // Init pour éviter les erreurs si non affecté

        // Charger l'image en fonction de son type MIME
        if ($mimeType === 'image/jpeg') {
            $image = imagecreatefromjpeg($sourcePath);
        } elseif ($mimeType === 'image/png') {
            $image = imagecreatefrompng($sourcePath);
        } else {
            // Gestion des erreurs.
            throw new \Exception('Format d\'image non supporté pour la conversion en WebP.');
        }

        // Redimensionner l'image si elle est trop grande (par exemple, max 1920x1080) (hardcoding)
        // Config dans services.yaml ou .env pour respecter SRP
        $maxWidth = 1920;
        $maxHeight = 1080;

        if (imagesx($image) > $maxWidth || imagesy($image) > $maxHeight) {
            $image = $this->resizeImage($image, $maxWidth, $maxHeight);
        }

        // Convertir en WebP
        // Par défaut, la qualité est 80. Spécifier le niveau de qualité (ex: `imagewebp($image, $destinationPath, 90);`)
        // pourrait être exposée via un paramètre de la méthode `convertToWebP` pour plus de flexibilité.
        imagewebp($image, $destinationPath);

        // Libérer la mémoire
        imagedestroy($image);
    }

    /**
     * Redimensionne une ressource image tout en conservant le ratio.
     *
     * @param \GdImage $image La ressource image GD (typage PHP 8+).
     * @param int $maxWidth Largeur maximale souhaitée.
     * @param int $maxHeight Hauteur maximale souhaitée.
     * @return \GdImage La nouvelle ressource image redimensionnée.
     */
    private function resizeImage($image, int $maxWidth, int $maxHeight): \GdImage
    {
        $width = imagesx($image);
        $height = imagesy($image);

        // Calculer les nouvelles dimensions tout en conservant le ratio (fit/contain).
        $ratio = min($maxWidth / $width, $maxHeight / $height);
        $newWidth = (int)($width * $ratio);
        $newHeight = (int)($height * $ratio);

        // Créer une nouvelle image redimensionnée
        $newImage = imagecreatetruecolor($newWidth, $newHeight);
        
        // imagecopyresampled() pour le redimensionnement de haute qualité.
        imagecopyresampled($newImage, $image, 0, 0, 0, 0, $newWidth, $newHeight, $width, $height);

        return $newImage;
    }
}