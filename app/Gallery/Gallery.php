<?php

namespace App\Gallery;

class Gallery
{
    /**
     * Directory of images
     * @var string
     */
    private $img_directory = "";
    /**
     * Directory of images
     * @var string
     */
    private $img_media = "";
    /**
     * Image extensions allowed
     * @var array
     */
    private $img_extensions = ['jpg', 'jpeg', 'png', 'gif'];

    public function __construct(string $folder = "")
    {
        $this->img_directory = public_path($folder);
        $this->img_media = sprintf('/%s/', trim($folder,'/'));
    }

    public function getExtensions():array
    {
        return $this->img_extensions;
    }

    protected function getDirectory(array &$images, string $directory = "", string $media = "", string $type = ""):void
    {
        $directory = rtrim($directory, '/').'/';
        $dir = scandir($directory);

        if(false != $dir)
        {
            $extensions = $this->img_extensions;

            if($type != "")
            {
                $extensions = [$type];
            }
            foreach($dir as $item)
            {
                if($item == '.' || $item == '..')
                {
                    continue;
                }
                elseif(is_dir($directory.$item))
                {
                    $this->getDirectory($images, $directory.$item, rtrim($media, '/').'/'.$item, $type);
                }
                else
                {
                    $ext = pathinfo($directory.$item, PATHINFO_EXTENSION);

                    if(in_array($ext, $extensions))
                    {
                        $aux = getimagesize($directory.$item);
                        $images[] = [
                            'name' => $item,
                            'fullpath' => trim($media, '/').'/'.$item,
                            'width' => $aux[0],
                            'height' => $aux[1],
                            'type' => $aux[2],
                            'size' => $aux['bits'],
                            'mime' => $aux['mime'],
                            'type' => $aux[2],
                        ];
                    }
                }
            }
        }
    }

    public function getImages(string $type = ""):array
    {
        $images = [];
        $this->getDirectory($images, $this->img_directory, $this->img_media, $type);
        return $images;
    }
}