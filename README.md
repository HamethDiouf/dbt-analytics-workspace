# 📊 Analytics dbt Workspace (PostgreSQL)

Projet dbt pour la transformation et la modélisation de données analytiques à partir d'une base de données PostgreSQL.

---

## 🛠️ Stack Technique

* **Moteur dbt :** `dbt-core` 1.12.3
* **Adaptateur :** `dbt-postgres` 1.11.0
* **Base de données :** PostgreSQL (`test_analytics`)
* **Langage & Templating :** SQL / Jinja2
* **Environnement Python :** Python 3.10+

---

## 🏗️ Architecture des Modèles

Le projet suit l'architecture dbt classique en 3 couches :

* **Staging (`models/staging`) :** 
  * `stg_orders` *(Vue)* : Nettoyage, renommage et typpage des données brutes de commandes.
* **Intermediate (`models/intermediate`) :** 
  * `int_orders_metrics` *(Vue)* : Calculs intermédiaires et agrégations des métriques au niveau commande.
* **Marts (`models/marts`) :** 
  * `fct_sales_summary` *(Table)* : Table de faits finale contenant la synthèse des ventes par client.

---

## 🚀 Guide d'Installation et de Configuration

### 1. Prérequis Système
Avant de commencer, vérifiez que vous avez installé :
* **Git** (`git --version`)
* **Python 3.10+** (`python --version` ou `python3 --version`)
* **PostgreSQL** en cours d'exécution sur le port `5432` (ou accès à une instance distante)

---

### 2. Cloner le Projet

```bash
git clone [https://github.com/HamethDiouf/dbt-analytics-workspace.git](https://github.com/HamethDiouf/dbt-analytics-workspace.git)
cd dbt-analytics-workspace

3. Créer et Activer l'Environnement Virtuel (venv)
🪟 Sur Windows (PowerShell) :
# Création de l'environnement virtuel
python -m venv dbt-env

# Activation de l'environnement
.\dbt-env\Scripts\Activate.ps1

Note Windows : Si l'activation échoue en raison de la politique d'exécution, lancez PowerShell en administrateur et exécutez : Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope Process.


🐧 Sur Linux / macOS (Bash / Zsh) :
# Création de l'environnement virtuel
python3 -m venv dbt-env

# Activation de l'environnement
source dbt-env/bin/activate

4. Installer les Dépendances Python
Une fois l'environnement virtuel activé (vous devriez voir (dbt-env) au début de votre invite de commande) :

# Mettre à jour pip
python -m pip install --upgrade pip

# Installer dbt-postgres (installe automatiquement dbt-core)
pip install dbt-postgres

5. Configurer la Connexion dbt (profiles.yml)
dbt recherche sa configuration de connexion dans le dossier hôte de votre système :

Windows : C:\Users\<NomUtilisateur>\.dbt\profiles.yml

Linux / macOS : ~/.dbt/profiles.yml

Créez le dossier .dbt s'il n'existe pas, puis ajoutez ou modifiez le fichier profiles.yml avec la structure suivante :

analytics:
  outputs:
    dev:
      type: postgres
      host: localhost
      port: 5432
      user: postgres         # Votre utilisateur PostgreSQL
      password: postgres     # Votre mot de passe PostgreSQL
      dbname: test_analytics # Nom de votre base de données
      schema: public
      threads: 1
      keepalives_idle: 0
      connect_timeout: 10
  target: dev


⚡ Exécution et Validation
Déplacez-vous dans le répertoire du projet dbt (analytics) :
cd analytics

1. Tester la Connexion à la Base de Données

dbt debug

Si la configuration est correcte, la commande se termine par All checks passed!.


2. Exécuter les Transformations Data (Build / Run)

dbt run
Cette commande va créer les vues stg_orders, int_orders_metrics et la table fct_sales_summary dans votre schéma PostgreSQL.


3. Lancer les Tests d'Intégrité

dbt test

Exécute les vérifications d'unicité (unique) et de non-nullité (not_null) sur vos clés primaires.


4. Générer et Consulter la Documentation dbt
# Génère les fichiers d'artifacts de documentation
dbt docs generate

# Démarre un serveur web local pour visualiser le Lineage Graph et le dictionnaire de données
dbt docs serve

Accédez ensuite à l'interface via votre navigateur à l'adresse : http://localhost:8080.

📂 Structure du Projet
dbt-analytics-workspace/
├── dbt-env/                   # Environnement virtuel Python (ignoré par Git)
└── analytics/                 # Racine du projet dbt
    ├── models/
    │   ├── staging/           # Vues de nettoyage et standardisation
    │   ├── intermediate/      # Transformations intermédiaires
    │   └── marts/             # Tables métier finales
    ├── seeds/                 # Données statiques CSV
    ├── tests/                 # Tests de qualité personnalisés
    ├── dbt_project.yml        # Fichier de configuration dbt
    └── .gitignore             # Fichiers et dossiers ignorés par Git


🤝 Contribution & Bonnes Pratiques
Toujours vérifier que la commande dbt debug renvoie un succès avant d'ajouter de nouveaux modèles.

Tout nouveau modèle doit comporter au moins un test d'unicité (unique) et un test de non-nullité (not_null) sur sa clé primaire dans un fichier .yml.

Ne jamais commiter de fichiers sensibles (.env, profiles.yml contenant des identifiants) dans le dépôt Git.    