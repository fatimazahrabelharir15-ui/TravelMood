<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html >
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TravelMood</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet"
href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<style>

.nav-pills .nav-link {
    color: #334155; /* Gris foncé lisible */
    font-weight: 600;
    border-radius: 12px;
    padding: 14px 18px;
    transition: all 0.3s ease;
}

.nav-pills .nav-link:hover {
    background-color: #E8F0FE;
    color: #0D3249;
    
}

.nav-pills .nav-link {
    margin-bottom: 12px;
}

.nav-pills .nav-link.active {
    background-color: #2563EB !important;
    color: white !important;
}

.card{

    border-radius:20px;

}

table{

    border-radius:15px;

    overflow:hidden;

}

.sidebar hr {
    margin: 24px 0;
}

</style>
</head>
<body class="bg-light">

<nav class="navbar navbar-expand-lg navbar-dark" style="background-color: #0D3249;">
  <div class="container">
    <a class="navbar-brand fw-bold" href="index.jsp"> Travel<span class="text-warning">Mood</span></a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav me-auto">
        <li class="nav-item"><a class="nav-link" href="SejourControlleur">Accueil</a></li>
<<<<<<< HEAD
        <li class="nav-item"><a class="nav-link" href="ListerSejourControlleur">S�jours</a></li>
        <li class="nav-item"><a class="nav-link" href="QuizControlleur">Pour moi</a></li>
=======
        <li class="nav-item"><a class="nav-link" href="ListerSejourControlleur">Séjours</a></li>
        <li class="nav-item"><a class="nav-link" href="ProfilControlleur">Pour moi</a></li>
>>>>>>> 49270c68072751f1f4f575846aba712c45c8b380
      </ul>
      <div class="d-flex gap-2">
        <a href="ProfilControlleur" class="btn btn-outline-light">Mon profil</a>
        <a href="connexion.jsp" class="btn btn-warning">Connexion</a>
      </div>
    </div>
  </div>
</nav>

    <main class="container my-5">
        