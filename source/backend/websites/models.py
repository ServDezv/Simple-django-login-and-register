from django.db import models

class Localitate(models.Model):
    id = models.BigAutoField(primary_key=True)
    nume = models.CharField(max_length=100, db_comment="Fara diacritice")
    judet = models.CharField(max_length=100)
    auto = models.CharField(max_length=5, db_comment="OT, BN, MH, MS, SV etc.")
    lat = models.DecimalField(max_digits=9, decimal_places=6, db_comment="Latitudinea")
    lng = models.DecimalField(max_digits=9, decimal_places=6, db_comment="Longitudinea")

class WebsiteState(models.Model):
    id = models.BigAutoField(primary_key=True)
    stare = models.CharField(max_length=100, db_comment="Vom avea 'Neacreditat', 'În curs de acreditare', 'Acreditat' + alte stări pe care le identificăm pe parcursul dezvoltării")

class Website(models.Model):
    id = models.BigAutoField(primary_key=True)
    um_gazda = models.ForeignKey('UM', on_delete=models.CASCADE, related_name='gazda_de_umuri')
    um_detinator = models.ForeignKey('UM', on_delete=models.CASCADE, related_name='detinator_de_umuri')
    um_beneficiar = models.ForeignKey('UM', on_delete=models.CASCADE, related_name='beneficiar_de_umuri')
    url = models.CharField(max_length=100)
    ip_public = models.CharField(max_length=100)
    nume_isp = models.CharField(max_length=100)
    stare = models.ForeignKey('WebsiteState', on_delete=models.CASCADE)

class UserGrad(models.Model):
    id = models.BigAutoField(primary_key=True)
    denumire_grad = models.CharField(max_length=100)

class User(models.Model):
    id = models.BigAutoField(primary_key=True)
    grad = models.ForeignKey('UserGrad', on_delete=models.CASCADE)
    nume = models.CharField(max_length=100)
    prenume = models.CharField(max_length=100)
    unitate = models.ForeignKey('UM', on_delete=models.CASCADE)
    rol = models.ForeignKey('WebsiteState', on_delete=models.CASCADE)
    email_intra = models.CharField(max_length=100, db_comment="Va fi obținut din detaliile contului din Active Directory (autentificare LDAP)")
    email_inter = models.CharField(max_length=100)
    telefon_rtp = models.CharField(max_length=100)
    telefon_mobil = models.CharField(max_length=100, null=True, blank=True, db_comment="Optional")

class UM(models.Model):
    id = models.BigAutoField(primary_key=True)
    indicativ = models.CharField(max_length=20)
    denumire = models.CharField(max_length=100)
    localitate = models.ForeignKey('Localitate', on_delete=models.CASCADE)
    lat = models.DecimalField(max_digits=9, decimal_places=6, null=True, blank=True, db_comment="Latitudinea")
    lng = models.DecimalField(max_digits=9, decimal_places=6, null=True, blank=True, db_comment="Longitudinea")
    crisc = models.BooleanField(default=False, db_comment="By default = False; La înregistrarea UM-ului de către administrator, se va putea marca ca fiind True din UI")

class SSLCertificate(models.Model):
    id = models.BigAutoField(primary_key=True)
    website = models.ForeignKey('Website', on_delete=models.CASCADE)
    ca_semnatar = models.CharField(max_length=100, null=True, blank=True)
    data_expirare = models.DateField(null=True, blank=True)

class WebsiteHistory(models.Model):
    website = models.ForeignKey(Website, on_delete=models.CASCADE)
    visit_date = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.website.name} - {self.visit_date}"