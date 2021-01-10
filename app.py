from flask import Flask, render_template, request, redirect, url_for, session
from flask_mysqldb import MySQL
#from flaskext.mysql import MySQL
#import pymysql
import yaml
import bcrypt

app = Flask(__name__)
db = yaml.load(open('db.yaml'))
app.secret_key = 'oct@vi@n'
app.config['MYSQL_HOST'] = db['mysql_host']
app.config['MYSQL_USER'] = db['mysql_user']
app.config['MYSQL_PASSWORD'] = db['mysql_password']
app.config['MYSQL_DB'] = db['mysql_db']
app.config['MYSQL_CURSORCLASS'] = db['mysql_cursorclass']
mysql = MySQL(app)


# ANGAJATI DONE
@app.route('/angajati', methods=['GET', 'POST'])
def getAngajati():
    print("___app.py/home::angajati: STARTED")
    if request.method=='GET':
        if session.get('username') is None:
            print("Nu e logat")
            return redirect(url_for('login'))
        if session['username']:
            #return render_template('angajati.html')
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


@app.route('/editAngajat/<string:id>', methods=['GET', 'POST'])
def editAngajat(id):
    curs = mysql.connection.cursor()
    if request.method == "GET":
        if session.get('username') is None:
            print("Nu e logat")
            return redirect(url_for('login'))
        if session['username']:
            sql = 'SELECT * FROM tblAngajati WHERE idAngajat=%s'
            curs.execute(sql, [id])
            res = curs.fetchone()
            curs.close()
            return render_template("editAngajat.html", angajati=res)
            #return render_template('homePage.html')

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
            curs.execute(sql, [numeToUpdate, prenumeToUpdate, functieToUpdate, dataAngToUpd, telefonToUpdate, emailToUpdate, salariuToUpdate, idToUpdate])
            mysql.connection.commit()
            curs.close()
            return redirect(url_for('getAngajati'))
        except Exception as e:
            print(e)
    # sql = 'SELECT * FROM tblAngajati WHERE idAngajat=%s'
    # curs.execute(sql,[id])
    # res = curs.fetchone()
    # curs.close()
    # return render_template("editAngajat.html", angajati=res)

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

        return redirect(url_for('getAngajati'))


@app.route('/register', methods=['GET', 'POST'])
def register():
    if request.method == 'GET':
        return render_template('register.html')
    else:
        session['reg'] = ""

        numeN        = request.form['nume']
        prenumeN     = request.form['prenume']
        emailN       = request.form['email']
        userN        = request.form['username']
        passwordN    = request.form['pwd2'].encode('utf-8')
        hash_pwd = bcrypt.hashpw(passwordN, bcrypt.gensalt())
        curs = mysql.connection.cursor()
        try:
            curs.execute('INSERT INTO tblUsers (Username, Nume, Prenume, Email, Password) VALUES (%s, %s, %s, %s, %s)',
                         ([userN, numeN, prenumeN, emailN, hash_pwd]))
            mysql.connection.commit()
            curs.close()
            eroareRegister = "OK"
            session['reg']='OK'
            #return 'register success'
            session.clear()
            return redirect(url_for('login'))
            #return render_template('register.html', eroareHTML=eroareRegister)
        except Exception as e:
            print(e)
            if e.args[0] == 1062:
                eroareRegister = "Username already exist. Try another."
                session['reg'] = '1062'
                #return render_template('register.html', eroareHTML='MUIE')
                #return 'username already exists'
                return redirect(url_for('register'))
                #return render_template('register.html')
    #return render_template('register.html', eroareHTML='MUIE')

       # session['username'] = userN
        #return redirect(url_for('homePage'))

@app.route('/homePage', methods=['GET', 'POST'])
def homePage():
    if request.method=="GET":
        if session.get('username') is None:
            print("Nu e logat")
            return redirect(url_for('login'))
        if session['username']:
            return render_template('homePage.html')
    # if request.method == 'GET':
    #     return render_template('homePage.html')
    # else:
    #     userLogin = request.form['userLog']
    #     passLogin = request.form['pwdLog'].encode('utf-8')
    #     curs = mysql.connection.cursor()
    #
    #     curs.execute("SELECT * FROM tblUsers WHERE Username=%s", ([userLogin]))
    #     userInfo = curs.fetchone()
    #
    #     curs.close()
    #     # print(userInfo['password'])
    #     session['para'] = ""
    #     if len(userLogin) > 0:
    #         if userInfo == None:
    #             session['para'] = "NOTEXIST"
    #             return redirect(url_for('homePage'))
    #
    #             #return 'user doesnt exist'
    #         if bcrypt.hashpw(passLogin, userInfo['Password'].encode('utf-8')) == userInfo['Password'].encode('utf-8'):
    #             session['username'] = userInfo['Username']
    #             session['authenticated'] = True
    #             return redirect(url_for('homePage'))
    #         else:
    #             session['para'] = "FAILED"
    #             return redirect(url_for('homePage'))
    #             #return 'login failed'



@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'GET':

        if session.get('username') is None:
            print("Nu e logat")
            return render_template('login.html')
        if session['username']:
            return redirect(url_for('homePage'))
        #else:
            #return render_template('login.html')
           #return render_template('login.html')
    else:
        #session['username'] = ""
        userLogin = request.form['userLog']
        passLogin = request.form['pwdLog'].encode('utf-8')
        curs = mysql.connection.cursor()

        curs.execute("SELECT * FROM tblUsers WHERE Username=%s", ([userLogin]))
        userInfo = curs.fetchone()

        curs.close()
        #print(userInfo['password'])

        if len(userLogin) > 0:
            if userInfo is None:
                session['authenticated'] = False
                return redirect(url_for('login'))
            if bcrypt.hashpw(passLogin, userInfo['Password'].encode('utf-8')) == userInfo['Password'].encode('utf-8'):
                session['username'] = userInfo['Username']
                session['authenticated'] = True
                return redirect(url_for('homePage'))
            else:
                session['authenticated'] = False
                return redirect(url_for('login'))


@app.route('/logout')
def logout():
    #print(session.__getitem__('username'))
    #session['username'] = ""
    session.clear()
    #session['username']=""
    #session['authenticated'] = False
    return redirect(url_for('login'))


if __name__ == '__main__':

    app.run(debug=True)
    #ISLOGIN = False