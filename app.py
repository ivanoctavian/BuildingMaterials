from flask import Flask, render_template, request, redirect, url_for, session
from flask_mysqldb import MySQL
#from flaskext.mysql import MySQL
#import pymysql
import yaml
import bcrypt

#session['authenticated'] = False
app = Flask(__name__)
db = yaml.load(open('db.yaml'))
app.secret_key = 'oct@vi@n'
app.config['MYSQL_HOST'] = db['mysql_host']
app.config['MYSQL_USER'] = db['mysql_user']
app.config['MYSQL_PASSWORD'] = db['mysql_password']
app.config['MYSQL_DB'] = db['mysql_db']
app.config['MYSQL_CURSORCLASS'] = db['mysql_cursorclass']
mysql = MySQL(app)
ISLOGIN = False
@app.route('/home', methods=['GET', 'POST'])
def index():
    return render_template('index.html')

# ANGAJATI DONE
@app.route('/angajati', methods=['GET', 'POST'])
def home():
    print("___app.py/home::angajati: STARTED")

    try:
        curs = mysql.connection.cursor()
        curs.execute('SELECT * FROM tblAngajati')
        data = curs.fetchall()
        # pentru a vedea atributele unui obiect:
        #for ang in data:
         #   print(ang['idAngajat'])
        print('___app.py / home::angajati: FETCH DONE.')
        curs.close()
    except Exception as e:
        print('ERROR___app.py / home::angajati: EROARE FETCH____', e)

    return render_template('angajati.html', angajati=data)



@app.route('/adauga', methods=['GET', 'POST'])
def adauga():
    if request.method == 'POST':
        print("___app.py / adauga::adauga.html: doPost STARTED")

        idAn            = request.form["idAngajat"]
        print("___app.py / adauga::adauga.html: idAngajat to be added: "+idAn)

        numeAn          = request.form['nume']
        print("___app.py / adauga::adauga.html: NumeAngajat to be added: "+numeAn)
        prenumeAn       = request.form['prenume']
        print("___app.py / adauga::adauga.html: PrenumeAngajat to be added: "+prenumeAn)

        functieeAn      = request.form['functie']
        print("___app.py / adauga::adauga.html: FunctieAngajat to be added: "+functieeAn)

        dataAngajariiAn = request.form['data_angajarii']
        print("___app.py / adauga::adauga.html: DataAngajarii to be added: "+dataAngajariiAn)

        telAn           = request.form['telefon']
        print("___app.py / adauga::adauga.html: TelefonAngajat to be added: "+telAn)

        emailAn         = request.form['email']
        print("___app.py / adauga::adauga.html: EmailAngajat to be added: "+emailAn)

        salariuAn       = request.form['salariu']
        print("___app.py / adauga::adauga.html: Salariu to be added: "+salariuAn)
        try:
            curs = mysql.connection.cursor()
            print("___app.py / adauga::adauga.html: ____CONEXIUNE OK DB____")
            try:
                curs.execute(
                    'INSERT INTO tblAngajati(idAngajat, Nume, Prenume, Functie, DataAngajarii, Telefon, Email, SalariuRON) VALUES (%s, %s, %s, %s, %s, %s, %s, %s)',
                    (idAn, numeAn, prenumeAn, functieeAn, dataAngajariiAn, telAn, emailAn, salariuAn))
                print("___app.py / adauga::adauga.html: SUCCES SA MOARA COPII INSERT QUERY EXECUTED")
                mysql.connection.commit()
                curs.close()
                return  redirect(url_for('home'))
            except Exception as e:
                print("ERROR___app.py / adauga::adauga.html: ____EROARE ADAUGARE____::", e)
                # print(traceback.print_exc())
        except Exception as e:
            print("ERROR___app.py / adauga::adauga.html: ____EROARE CONEXIUNE DB____")
            print("ERROR___app.py / adauga::adauga.html: ____EROARE CONEXIUNE DB____::",e)

        print("___app.py / adauga::adauga.html: ____doPost END")

    return render_template('adauga.html')


@app.route('/angajati1', methods=['GET','DELETE'])
def delete_order():
    print("___app.py/home::angajati: STARTED")
    try:
        curs = mysql.connection.cursor()
        curs.execute('DELETE FROM tblAngajati WHERE idAngajat = 34')
        #aasa
        mysql.connection.commit()
        curs.close()
    except Exception as e:
        print('ERROR___app.py / home::angajati: EROARE FETCH____', e)

    return render_template('angajati.html')


@app.route('/editAngajat/<string:id>', methods=['GET', 'POST'])
def editAngajat(id):
    curs = mysql.connection.cursor()
    if request.method == 'POST':
        try:
            idToUpdate      = id
            numeToUpdate    = request.form['nume']
            prenumeToUpdate = request.form['prenume']
            functieToUpdate = request.form['functie']
            dataAngToUpd    = request.form['data_angajarii']
            telefonToUpdate = request.form['telefon']
            emailToUpdate   = request.form['email']
            salariuToUpdate = request.form['salariu']
            sql = "UPDATE tblAngajati SET Nume=%s, Prenume=%s, Functie=%s,DataAngajarii=%s,Telefon=%s, Email=%s, SalariuRON=%s WHERE idAngajat=%s"
            curs.execute(sql,[ numeToUpdate,prenumeToUpdate,functieToUpdate,dataAngToUpd,telefonToUpdate,emailToUpdate,salariuToUpdate, idToUpdate])
            mysql.connection.commit()
            curs.close()
            return redirect(url_for('home'))
        except Exception as e:
            print(e)


    sql = 'SELECT * FROM tblAngajati WHERE idAngajat=%s'
    curs.execute(sql,[id])
    res = curs.fetchone()
    return render_template("editAngajat.html", angajati=res)

# INCERCARE
def delete(numeidElem,tabel,valoareId):
    curs = mysql.connection.cursor()
    query = "DELETE FROM %s WHERE %s=%s"
    curs.execute(query,[tabel,numeidElem,valoareId])
    mysql.connection.commit()
    curs.close()
# END INCERCARE

@app.route('/deleteAngajat/<string:id>', methods=['GET','POST'])
def deleteAngajat(id):
        curs = mysql.connection.cursor()
        sql = "DELETE FROM tblAngajati WHERE idAngajat=%s"
        curs.execute(sql, [id])
        mysql.connection.commit()
        curs.close()

        return redirect(url_for('home'))


@app.route('/register', methods=['GET','POST'])
def register():
    if request.method == 'GET':
        return render_template('register.html')
    else:
        user = request.form['userN']
        password = request.form['pwd'].encode('utf-8')
        hash_pwd = bcrypt.hashpw(password, bcrypt.gensalt())
        curs = mysql.connection.cursor()
        curs.execute('INSERT INTO tblUsers (username, password) VALUES (%s, %s)', ([user, hash_pwd]) )
        mysql.connection.commit()
        session['username'] = user
        return redirect(url_for('home'))


@app.route('/login', methods=['GET','POST'])
def login():
    if request.method == 'GET':
        return render_template('login.html')
    else:
        userLogin = request.form['userLog']
        passLogin = request.form['pwdLog'].encode('utf-8')
        curs = mysql.connection.cursor()
        curs.execute("SELECT * FROM tblUsers WHERE username=%s", ([userLogin]))
        userInfo = curs.fetchone()
        curs.close()
        print(userInfo['password'])
        if len(userLogin) > 0:
            if bcrypt.hashpw(passLogin, userInfo['password'].encode('utf-8')) == userInfo['password'].encode('utf-8'):
                ISLOGIN = True
                session['username'] = userInfo['username']
                session['authenticated'] = True
                return 'login success'
            else:
                return 'login failed'

@app.route('/logout')
def logout():
    session.clear()
    return render_template('angajati.html')

if __name__ == '__main__':

    app.run(debug=True)
    #ISLOGIN = False