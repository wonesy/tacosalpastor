import sys

if sys.platform == 'darwin':

    import pymysql
    pymysql.install_as_MySQLdb()
