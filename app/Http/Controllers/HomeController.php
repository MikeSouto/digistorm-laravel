<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Gallery\Gallery;

class HomeController extends Controller
{
    public function index(Request $request)
    {
        $type = $request->input('type');
        $type = trim($type);
        $gallery = new Gallery('images');

        return view('home', [
            'types' => $gallery->getExtensions(),
            'images' => $gallery->getImages($type),
            'img_type' => $type
        ]);
    }
}
