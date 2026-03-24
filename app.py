from flask import Flask, render_template, request, jsonify
from flask_sqlalchemy import SQLAlchemy
from datetime import datetime

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///database.db'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config['SECRET_KEY'] = 'change-this-secret'
db = SQLAlchemy(app)

class Review(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), nullable=False)
    rating = db.Column(db.Integer, nullable=False)
    message = db.Column(db.Text, nullable=False)
    created_at = db.Column(db.DateTime, default=datetime.utcnow)

with app.app_context():
    db.create_all()

@app.route('/')
def home():
    reviews = Review.query.order_by(Review.created_at.desc()).all()
    return render_template('index.html', reviews=reviews)

@app.route('/contact')
def contact():
    return render_template('contact.html')

@app.route('/add-review', methods=['POST'])
def add_review():
    data = request.json
    review = Review(
        name=data.get('name'),
        rating=data.get('rating'),
        message=data.get('message')
    )
    db.session.add(review)
    db.session.commit()
    return jsonify({
        'id': review.id,
        'name': review.name,
        'rating': review.rating,
        'message': review.message
    })

@app.route('/status')
def status():
    return {'status': 'ok', 'service': 'Santi Styles Barber Website'}

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
