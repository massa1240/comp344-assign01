<?php

$loader = require __DIR__ . '/../vendor/autoload.php';

$app = new \Slim\Slim(array(
	'view' => 'Slim\Views\Twig',
	'mode' => 'development',
));

/*******************************************
 * PREPARE ENTITY MANAGER DOCTRINE
 *******************************************/
$cache    = new \Doctrine\Common\Cache\ArrayCache();
$apcCache = new \Doctrine\Common\Cache\ApcCache();

use Doctrine\ORM\Configuration;
use Doctrine\ORM\EntityManager;

$config = new Configuration;
$config->setMetadataCacheImpl($cache);
$driverImpl = $config->newDefaultAnnotationDriver(array(__DIR__ . '/../COMP344/Entities'));
$config->setMetadataDriverImpl($driverImpl);
$config->setQueryCacheImpl($apcCache);
$config->setProxyDir(__DIR__ . '/../data/Proxies');
$config->setProxyNamespace('COMP344\Proxies');
$config->setAutoGenerateProxyClasses(true);

// the connection configuration
$dbParams = array(
	'driver'   => '',
	'user'     => '',
	'password' => '',
	'dbname'   => '',
	'host'     => '',
	'charset'  => '',
	'port'     => ,
);

$app->container->singleton('em',

function () use ($dbParams, $config) {
		return EntityManager::create($dbParams, $config);
	});

/*******************************************
 * PREPARE VIEW
 *******************************************/
$app->view->parserOptions = array(
	'charset'          => 'utf-8',
	'cache'            => realpath('../data/cache'),
	'auto_reload'      => true,
	'strict_variables' => false,
	'autoescape'       => true
);

$app->view->parserExtensions = array(new \Slim\Views\TwigExtension());
$app->view->twigTemplateDirs = array(realpath('../lib/COMP344/View'));

/*******************************************
 * SESSION MIDDLEWARE
 *******************************************/
$app->add(new \Slim\Middleware\SessionCookie(array(
	'path'   => '/',
	'secret' => 'uGMEueajbz3tYUAZlw',
	'secure' => false
)));

/*******************************************
 * GUARD MIDDLEWARE FOR AUTHENTICATION
 *******************************************/
$app->authGuardMiddleware = function () use ($app) {
	return function () use ($app) {

		if (!isset($_SESSION['email'])) {
			$app->flash('error', 'Login required to access this page!');
			$app->redirect($app->urlFor('home'));
		}
	};
};

/*******************************************
 * DEFINITION OF ROUTES
 *******************************************/
$app->get('/', function () use ($app) {
	new \COMP344\Controller\IndexController($app);
})->name('home');

$app->post('/login', function () use ($app) {
	new \COMP344\Controller\LoginController($app);
})->name('login');

$app->get('/register', function () use ($app) {
	new \COMP344\Controller\RegisterController($app);
})->name('register');

$app->post('/register', function () use ($app) {
	new \COMP344\Controller\RegisterController($app);
});

$app->get('/check-email', function () use ($app) {
	new \COMP344\Controller\CheckEmailController($app);
});

$app->get('/check-postcode', function () use ($app) {
	new \COMP344\Controller\CheckPostcodeController($app);
});

$app->post('/checkout', $app->authGuardMiddleware, function () use ($app) {
	new \COMP344\Controller\CheckoutController($app);
});

$app->get('/logout', $app->authGuardMiddleware, function () use ($app) {
	new \COMP344\Controller\LogoutController($app);
})->name('logout');

$app->get('/view-book/:book', $app->authGuardMiddleware, function ($book) use ($app) {
	new \COMP344\Controller\ViewBookController($app, array('book' => $book));
})->name('view-book');

$app->get('/browse-books', $app->authGuardMiddleware, function () use ($app) {
	new \COMP344\Controller\BrowseBooksController($app);
})->name('browse-books');

$app->get('/browse-books/:unit', $app->authGuardMiddleware, function ($unit) use ($app) {
	new \COMP344\Controller\BrowseBooksController($app, array('unit' => $unit));
})->name('browse-books-by-unit');

/*****************************************
 * ROUTES THAT WERE SUPPOSED TO BE USED
 *****************************************/

$app->get('/confirmation', $app->authGuardMiddleware, function () use ($app) {
	new \COMP344\Controller\ConfirmationController($app);
});

$app->get('/checkout', $app->authGuardMiddleware, function () use ($app) {
	new \COMP344\Controller\CheckoutController($app);
});

$app->get('/view-cart', $app->authGuardMiddleware, function () use ($app) {
	new \COMP344\Controller\ViewCartController($app);
});

$app->get('/view-wishlist', $app->authGuardMiddleware, function () use ($app) {
	new \COMP344\Controller\ViewWishlistController($app);
});

$app->get('/update-information', $app->authGuardMiddleware, function () use ($app) {
	new \COMP344\Controller\UpdateInformationController($app);
});

$app->post('/update-information', $app->authGuardMiddleware, function () use ($app) {
	new \COMP344\Controller\UpdateInformationController($app);
});

$app->put('/add-book-to-wishlist/:id', $app->authGuardMiddleware, function () use ($app) {
	new \COMP344\Controller\AddBookWishlistController($app);
});

$app->put('/add-book-to-cart/:id', $app->authGuardMiddleware, function () use ($app) {
	new \COMP344\Controller\AddBookCartController($app);
});

$app->put('/update-quantity/:id/:x', $app->authGuardMiddleware, function () use ($app) {
	new \COMP344\Controller\UpdateBookCartController($app);
});

$app->delete('/remove-book-from-wishlist/:id', $app->authGuardMiddleware, function () use ($app) {
	new \COMP344\Controller\RemoveBookWishlistController($app);
});

$app->delete('/remove-book-from-cart/:id', $app->authGuardMiddleware, function () use ($app) {
	new \COMP344\Controller\RemoveBookCartController($app);
});

$app->run();