from flask import Flask
from flask_restful import Resource, Api

app = Flask(__name__)
api = Api(app)

class hoteis(Resource):
    def get(self):
        return {'hoteis': 'Meus hoteis'}

api.add_resource(hoteis, '/hoteis')
if __name__  == '__main__':
    app.run(debug=True)    

