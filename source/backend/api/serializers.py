from rest_framework import serializers
from .models import Localitate, WebsiteState, Website, UserGrad, User, UM, SSLCertificate, WebsiteHistory

class LocalitateSerializer(serializers.ModelSerializer):
    class Meta:
        model = Localitate
        fields = '__all__'

class WebsiteStateSerializer(serializers.ModelSerializer):
    class Meta:
        model = WebsiteState
        fields = '__all__'

class WebsiteSerializer(serializers.ModelSerializer):
    class Meta:
        model = Website
        fields = '__all__'

class UserGradSerializer(serializers.ModelSerializer):
    class Meta:
        model = UserGrad
        fields = '__all__'

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = '__all__'

class UMSerializer(serializers.ModelSerializer):
    class Meta:
        model = UM
        fields = '__all__'

class SSLCertificateSerializer(serializers.ModelSerializer):
    class Meta:
        model = SSLCertificate
        fields = '__all__'

class WebsiteHistorySerializer(serializers.ModelSerializer):
    class Meta:
        model = WebsiteHistory
        fields = '__all__'