<?php

namespace App\Http\Controllers\Api;

//use Illuminate\Http\Request;
//use App\Http\Controllers\Controller;

//class UserController extends Controller
//{
    //
//}

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

class UserController extends Controller
{
    public function show(Request $request)
    {
        return $request->user();
    }
}
