from rest_framework import serializers
from epita.models import Attendance


class AttendanceSerializer(serializers.ModelSerializer):
    name = serializers.SerializerMethodField()
    image = serializers.SerializerMethodField()
    class Meta:
        model = Attendance
        fields = ['student_id', 'status', 'file_upload', 'name', 'image']

    def get_name(self, obj):
        return obj.student_id.__str__()

    def get_image(self, obj):
        return obj.student_id.photo_location

