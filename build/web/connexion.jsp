<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="header.jsp" />
<style>
    /* Définition de tes variables de couleurs (adaptées à ton thème TravelMood) */
    :root {
        --sand: #f4f6f8;
        --white: #ffffff;
        --gray2: #e0e0e0;
        --gray3: #6c757d;
        --ocean: #3B8FB5;
        --ocean2: #0D3249;
    }

    /* Ton CSS personnalisé */
    .auth-wrapper {
        min-height: calc(100vh - 140px);
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 2rem;
        background: var(--sand);
    }

    .auth-card {
        background: var(--white);
        border-radius: 16px;
        border: 1px solid var(--gray2);
        padding: 2.5rem;
        width: 100%;
        max-width: 450px; /* Légèrement élargi pour les formulaires sur 2 colonnes */
        box-shadow: 0 10px 30px rgba(0,0,0,0.05); /* Petite ombre douce ajoutée */
    }

    .auth-card h2 {
        font-family: 'Playfair Display', serif;
        font-size: 1.7rem;
        color: var(--ocean2);
        margin-bottom: 0.3rem;
        font-weight: bold;
    }

    .auth-card p { 
        color: var(--gray3); 
        font-size: 0.9rem; 
        margin-bottom: 2rem; 
    }

    /* Custom Tabs */
    .auth-tabs { 
        display: flex; 
        gap: 0; 
        margin-bottom: 2rem; 
        border-bottom: 1px solid var(--gray2); 
        padding-left: 0;
        list-style: none;
    }
    
    .auth-tab {
        flex: 1;
        padding: 10px;
        text-align: center;
        font-size: 0.95rem;
        cursor: pointer;
        border: none;
        background: transparent;
        border-bottom: 2px solid transparent;
        color: var(--gray3);
        transition: all 0.2s;
        font-weight: 500;
    }
    
    .auth-tab.active { 
        color: var(--ocean2); 
        border-bottom-color: var(--ocean); 
        font-weight: bold; 
    }

    .btn-full { 
        width: 100%; 
        text-align: center; 
        padding: 12px;
    }

    /* Animation */
    .page-fade { animation: fadeIn 0.4s ease; }
    @keyframes fadeIn { 
        from { opacity: 0; transform: translateY(10px); } 
        to { opacity: 1; transform: translateY(0); } 
    }
    
    /* Style des inputs pour coller au design */
    .form-control, .form-select {
        border-color: var(--gray2);
        padding: 0.6rem 1rem;
    }
    .form-control:focus, .form-select:focus {
        border-color: var(--ocean);
        box-shadow: 0 0 0 0.25rem rgba(59, 143, 181, 0.25);
    }
</style>

<div class="auth-wrapper page-fade">
    <div class="auth-card">
        
        <ul class="auth-tabs" id="authTabs" role="tablist">
            <li class="nav-item flex-fill" role="presentation">
                <button class="auth-tab active w-100" id="login-tab" data-bs-toggle="tab" data-bs-target="#login-panel" type="button" role="tab" aria-selected="true">
                    Connexion
                </button>
            </li>
            <li class="nav-item flex-fill" role="presentation">
                <button class="auth-tab w-100" id="register-tab" data-bs-toggle="tab" data-bs-target="#register-panel" type="button" role="tab" aria-selected="false">
                    Inscription
                </button>
            </li>
        </ul>

        <div class="tab-content" id="authTabsContent">
            
            <div class="tab-pane fade show active" id="login-panel" role="tabpanel" aria-labelledby="login-tab">
                <div class="text-center">
                    <h2>Ravi de vous revoir</h2>
                    <p>Accédez à votre espace personnel TravelMood.</p>
                </div>
                
                <form action="UtilisateurControlleur" method="POST">
                    <input type="hidden" name="actionType" value="connexion">
                    
                    <div class="mb-3">
                        <label for="loginEmail" class="form-label fw-medium text-secondary small">Adresse Email</label>
                        <input type="email" class="form-control" id="loginEmail" name="email" required placeholder="exemple@mail.com">
                    </div>
                    
                    <div class="mb-4">
                        <div class="d-flex justify-content-between">
                            <label for="loginPassword" class="form-label fw-medium text-secondary small">Mot de passe</label>
                            <a href="#" class="text-decoration-none small" style="color: var(--ocean);">Oublié ?</a>
                        </div>
                        <input type="password" class="form-control" id="loginPassword" name="password" required placeholder="••••••••">
                    </div>
                    
                    <button type="submit" class="btn text-white fw-bold btn-full rounded-3 border-0" style="background-color: var(--ocean2);">
                        Se connecter
                    </button>
                </form>
            </div>

            <div class="tab-pane fade" id="register-panel" role="tabpanel" aria-labelledby="register-tab">
                <div class="text-center">
                    <h2>Créer un compte</h2>
                    <p>Rejoignez-nous pour des voyages sur-mesure.</p>
                </div>
                
                <form action="UtilisateurControlleur" method="POST" onsubmit="return validerMotsDePasse()">
                    <input type="hidden" name="actionType" value="inscription">
                    
                    <div class="row g-2 mb-3">
                        <div class="col-sm-6">
                            <label for="regPrenom" class="form-label fw-medium text-secondary small">Prénom</label>
                            <input type="text" class="form-control" id="regPrenom" name="prenom" required placeholder="Ahmed">
                        </div>
                        <div class="col-sm-6">
                            <label for="regNom" class="form-label fw-medium text-secondary small">Nom</label>
                            <input type="text" class="form-control" id="regNom" name="nom" required placeholder="Alaoui">
                        </div>
                    </div>
                    
                    <div class="mb-3">
                        <label for="regEmail" class="form-label fw-medium text-secondary small">Adresse Email</label>
                        <input type="email" class="form-control" id="regEmail" name="email" required placeholder="exemple@mail.com">
                    </div>
                    <div class="mb-3">
                        <label for="regTel" class="form-label fw-medium text-secondary small">Téléphone</label>
                        <input type="tel" class="form-control" id="regTel" name="telephone" placeholder="06XXXXXXXX">
                    </div>

                    <div class="mb-3">
                        <label for="regRole" class="form-label fw-medium text-secondary small">Choisir un rôle</label>
                        <select class="form-select" id="regRole" name="role" required>
                            <option value="client" selected> Voyageur </option>
                            <option value="admin">Administrateur </option>
                        </select>
                    </div>
                    
                    <div class="mb-3">
                        <label for="regPassword" class="form-label fw-medium text-secondary small">Mot de passe</label>
                        <input type="password" class="form-control" id="regPassword" name="password" required placeholder="Min. 6 caractères">
                    </div>
                    
                    <div class="mb-4">
                        <label for="regPasswordConfirm" class="form-label fw-medium text-secondary small">Confirmer le mot de passe</label>
                        <input type="password" class="form-control" id="regPasswordConfirm" required placeholder="••••••••">
                        <div id="error-msg" class="text-danger small mt-1 d-none">⚠️ Les mots de passe ne correspondent pas.</div>
                    </div>
                    
                    <button type="submit" class="btn text-white fw-bold btn-full rounded-3 border-0" style="background-color: var(--ocean2);">
                        S'inscrire
                    </button>              
                </form>
            </div>
            
        </div>

    </div>
</div>

<script>
    function validerMotsDePasse() {
        const pass = document.getElementById('regPassword').value;
        const confirmPass = document.getElementById('regPasswordConfirm').value;
        const errorMsg = document.getElementById('error-msg');
        
        if (pass !== confirmPass) {
            errorMsg.classList.remove('d-none');
            return false;
        }
        
        errorMsg.classList.add('d-none');
        return true;
    }
</script>

<jsp:include page="footer.jsp" />