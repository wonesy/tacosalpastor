import os


if os.getenv('OSX_MYSQL_WORKAROUND') == '1':

    import pymysql
    pymysql.install_as_MySQLdb()
