from rest_framework import serializers
from epita.models import Attendance, Student


class AttendanceSerializer(serializers.ModelSerializer):
    name = serializers.SerializerMethodField()
    class Meta:
        model = Attendance
        fields = ['student_id', 'status', 'file_upload', 'name']

    def get_name(self, obj):
        return obj.student_id.__str__()

