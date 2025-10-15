import 'package:get/get.dart';

import 'app_string.dart';


class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': {
      AppString.noInternet: "Please check your internet connection.",
      AppString.continueText: "Continue",
      AppString.next: "Next",
      AppString.searchHint: "Search...",

      // Sign In
      AppString.policyTextStart: "By clicking on Continue, you accept our ",
      AppString.serviceConditions: "service conditions",
      AppString.policyAnd: " and our ",
      AppString.privacyPolicy: "Privacy policy",
      AppString.policyTextEnd: ".",
      AppString.welcomeTitle: "Welcome to Piya",
      AppString.welcomeSubtitle: "Please enter credential to proceed.",
      AppString.emailPhoneHint: "Enter your email ID / Phone",
      AppString.or: "OR",
      AppString.continueWithGoogle: "Continue with Google",
      AppString.continueWithApple: "Continue with Apple",
      AppString.phoneNumber: "Phone Number",
      AppString.invalidPhone: "Please enter a valid phone number.",
      AppString.emptyPhone: "Please enter phone number.",
      AppString.invalidEmailOrPhone:
          "Please enter a valid email or phone number.",
      AppString.emptyEmailOrPhone: "Please enter email or phone number.",
      AppString.enterCode: "Please enter your code",

      // Sign Up
      AppString.verifyYourAccount: "Verify Your Account",
      AppString.verificationCodeSent: "We've sent a 6-digit verification code",
      AppString.enterVerificationCode:
          "Enter a 6 digit code sent to your email address C*********@gmail.com below",
      AppString.codeExpiresIn: "Code Expires in ",
      AppString.codeTime: "05:23 S",
      AppString.didntGetCode: "Didn't get code? ",
      AppString.resendCode: "Resend Code",
      AppString.back: "Back",
      AppString.verifyAndContinue: "Verify & Continue",
      AppString.emptyFullName: "Please enter your full name",

      // Create Account
      AppString.createNewAccount: "Create New Account",
      AppString.fullName: "Full name",
      AppString.emailId: "Enter your email ID",

      // Workspace
      AppString.createWorkspace: "Create Workspace",
      AppString.createBrandedWorkspace:
          "Create a branded workspace to collaborate in",
      AppString.workspaceName: "Workspace Name",
      AppString.customUrl: "Custom URL",
      AppString.joinWorkspace: "Join Workspace",
      AppString.lowercase: "Lowercase",
      AppString.noSpaces: "No spaces",
      AppString.avoidSpecialCharacters: "Avoid special characters",
      AppString.emptyWorkspaceName: "Please enter workspace name.",
      AppString.emptyCustomUrl: "Please enter custom URL.",
      AppString.invalidCustomUrl: "Please enter a valid custom URL.",
      AppString.cancel: "Cancel",

      // Core Services
      AppString.addCoreServices: "Add Core Services",
      AppString.defineServices: "Define the services you offer",
      AppString.others: "Others",
      AppString.enterOtherService: "Enter other service...",
      AppString.serviceNameRequired: "Service name is required",
      AppString.restore: "Restore",
      AppString.subscriptionTitle: "Unlock All Project\nManagement Features",
      AppString.featureUnlimitedProjects: "Unlimited Projects & Workflows",
      AppString.featureClientUpdates: "Real-Time Client Updates",
      AppString.featureMediaStorage: "Document & Media Storage",
      AppString.featureWorkflowAI: "AI-Powered Workflow Generator",
      AppString.featureNoContract: "Cancel Anytime — No Contracts",
      AppString.planMonthly: "Monthly",
      AppString.planMonthlyOffer: "Save 15% Off",
      AppString.planYearly: "Yearly",
      AppString.planYearlyOffer: "Save 15% Over Monthly",
      AppString.planPrice: "₹999 / \nmonth",
      AppString.activateSubscription: "Activate Subscription (Cancel Anytime)",
      AppString.subscriptionNote:
          "By Subscribing, You Agree To Our [Terms Of Use] And [Privacy Policy].\nYour Payment Will Be Processed Securely. Cancel Anytime From Your Account Settings.",
      AppString.create: "Create",
      AppString.yourFirst: "your first",
      AppString.workflow: "Workflow",
      AppString.workflowSubText:
          "Select a service and describe your project to generate smart stages and milestones with AI.",
      AppString.selectService: "Select Service",
      AppString.description: "Description",
      AppString.generateWorkflow: "Generate Workflow",
      AppString.hiThere: "Hi, there",
      AppString.aiExpert: "Bobby : Your AI companion",
      AppString.save: "Save",
      AppString.startConversation: "Start Conversation with Bobby...",
      AppString.pleaseAddCoreServices: "Please add core services",
      AppString.workspaceCreated: "Workspace created successfully",
      AppString.somethingWentWrong: "Something went wrong, please try again",
      AppString.loading: "Loading...",
      AppString.services: "Services",

      AppString.edit: "Edit",
      AppString.stageAndMilestone: "Add Stage & Milestone.",
      AppString.completedOnboarding: "Completed Onboarding",
      AppString.onboardingDescription:
          "This marks the user's onboarding completion.",
      AppString.saveToWorkflow: "Save to workflow",

      AppString.stageName: "Stage Name",
      AppString.stage: "Stage",
      AppString.milestone: "Milestone",
      AppString.milestoneName: "Milestone Name",
      AppString.add: "Add",
      AppString.action: "Action",
      AppString.noAction: "No Action right now, please press Add",
      AppString.editStages: "Edit Stages & Milestone",
      AppString.addStages: "Add Stages & Milestone",
      AppString.delete: "Delete",
      AppString.pleaseSelectService: "Please select service.",
      AppString.pleaseEnterDescription: "Please enter description",
      AppString.workflowName: "Workflow Name",
      AppString.nostagesfound: "No stages found",

      AppString.failedToCreateAiStages: "Failed to create AI Stages",
      AppString.noAiStagesAvailable: "No AI stages available to edit",
      AppString.enterValidAiText: "Please enter a valid text to edit AI stages",
      AppString.stagesSavedSuccessfully: "Stages saved successfully",

      AppString.deleteMilestoneMessage:
          "Are you sure that you want to delete this milestone?",
      AppString.confirm: "Confirm",
      AppString.pleaseEnterMilestone: "Please enter milestone name.",
      AppString.pleaseEnterAction: "Please enter action.",
      AppString.pleaseEnterStageName: "Please enter stage name",
      AppString.pleaseAddMilestone: "Please add at least one milestone",
    },

    'fr_FR': {
      AppString.noInternet: "Veuillez vérifier votre connexion Internet.",
      AppString.continueText: "Continuer",
      AppString.next: "Suivant",

      // Sign In
      AppString.policyTextStart:
          "En cliquant sur Continuer, vous acceptez nos ",
      AppString.serviceConditions: "conditions de service",
      AppString.policyAnd: " et notre ",
      AppString.privacyPolicy: "politique de confidentialité",
      AppString.policyTextEnd: ".",
      AppString.welcomeTitle: "Bienvenue chez Piya",
      AppString.welcomeSubtitle:
          "Veuillez saisir vos identifiants pour continuer.",
      AppString.emailPhoneHint: "Entrez votre e-mail / téléphone",
      AppString.or: "OU",
      AppString.continueWithGoogle: "Continuer avec Google",
      AppString.continueWithApple: "Continuer avec Apple",
      AppString.phoneNumber: "Numéro de téléphone",
      AppString.invalidPhone: "Veuillez entrer un numéro de téléphone valide.",
      AppString.emptyPhone: "Veuillez entrer un numéro de téléphone.",
      AppString.invalidEmailOrPhone:
          "Veuillez entrer un e-mail ou un numéro de téléphone valide.",
      AppString.emptyEmailOrPhone:
          "Veuillez entrer un e-mail ou un numéro de téléphone.",
      AppString.enterCode: "Veuillez entrer votre code",

      // Sign Up
      AppString.verifyYourAccount: "Vérifiez votre compte",
      AppString.verificationCodeSent:
          "Nous avons envoyé un code de vérification à 6 chiffres",
      AppString.enterVerificationCode:
          "Entrez un code de 6 chiffres envoyé à votre adresse e-mail C*********@gmail.com ci-dessous",
      AppString.codeExpiresIn: "Le code expire dans ",
      AppString.codeTime: "05:23 S",
      AppString.didntGetCode: "Pas reçu de code ? ",
      AppString.resendCode: "Renvoyer le code",
      AppString.back: "Retour",
      AppString.verifyAndContinue: "Vérifier et continuer",
      AppString.emptyFullName: "Veuillez entrer votre nom complet",

      // Create Account
      AppString.createNewAccount: "Créer un nouveau compte",
      AppString.fullName: "Nom complet",
      AppString.emailId: "Entrez votre adresse e-mail",
      AppString.phoneNumber: "Numéro de téléphone",

      // Workspace
      AppString.createWorkspace: "Créer un espace de travail",
      AppString.createBrandedWorkspace:
          "Créez un espace personnalisé pour vos clients",
      AppString.workspaceName: "Nom de l'espace de travail",
      AppString.customUrl: "URL personnalisée",
      AppString.joinWorkspace: "Rejoindre l'espace de travail",
      AppString.lowercase: "Minuscule",
      AppString.noSpaces: "Pas d'espaces",
      AppString.avoidSpecialCharacters: "Évitez les caractères spéciaux",
      AppString.emptyWorkspaceName:
          "Veuillez entrer le nom de l'espace de travail.",
      AppString.emptyCustomUrl: "Veuillez entrer l'URL personnalisée.",
      AppString.invalidCustomUrl:
          "Veuillez entrer une URL personnalisée valide.",

      // Core Services
      AppString.addCoreServices: "Ajouter des services principaux",
      AppString.defineServices: "Définir ce que vous faites",
      AppString.restore: "Restaurer",
      AppString.subscriptionTitle:
          "Débloquez toutes les fonctionnalités de gestion\n de projet",
      AppString.featureUnlimitedProjects: "Projets et workflows illimités",
      AppString.featureClientUpdates:
          "Mises à jour en temps réel pour le client",
      AppString.featureMediaStorage: "Stockage de documents et de médias",
      AppString.featureWorkflowAI: "Générateur de flux de travail IA",
      AppString.featureNoContract: "Annulez à tout moment — sans contrat",
      AppString.planMonthly: "Mensuel",
      AppString.planMonthlyOffer: "Économisez 15 %",
      AppString.planYearly: "Annuel",
      AppString.planYearlyOffer: "Économisez 15 % sur le mensuel",
      AppString.planPrice: "₹999 / \nmois",
      AppString.activateSubscription:
          "Activer l'abonnement (Annulable à tout moment)",
      AppString.subscriptionNote:
          "En vous abonnant, vous acceptez nos [Conditions d'utilisation] et [Politique de confidentialité].\nVotre paiement sera traité en toute sécurité. Vous pouvez annuler à tout moment dans les paramètres du compte.",
      AppString.create: "Créer",
      AppString.yourFirst: "votre premier",
      AppString.workflow: "Workflow",
      AppString.workflowSubText:
          "Sélectionnez un service et décrivez votre projet pour générer des étapes intelligentes avec l'IA.",
      AppString.selectService: "Sélectionner un service",
      AppString.description: "Description",
      AppString.generateWorkflow: "Générer le workflow",
      AppString.hiThere: "Salut",
      AppString.aiExpert: "Piya Expert IA",
      AppString.save: "Enregistrer",
      AppString.startConversation: "Commencer la conversation avec l'IA...",
      AppString.edit: "Éditer",
      AppString.stageAndMilestone: "+Étape et Jalons",
      AppString.completedOnboarding: "Intégration terminée",
      AppString.onboardingDescription:
          "Cela marque la fin de l'intégration de l'utilisateur.",
      AppString.saveToWorkflow: "Enregistrer dans le workflow",
      AppString.stageName: "Stage Name",
      AppString.milestone: "Milestone",
      AppString.milestoneName: "Milestone Name",
      AppString.add: "Add",
      AppString.action: "Action",
      AppString.noAction: "No Action right now, please press Add",
      AppString.editStages: "Edit Stages & Milestone",
      AppString.addStages: "Add Stages & Milestone",
      AppString.delete: "Delete",
      AppString.cancel: "Cancel",
    },
  };
}
