from flask import Flask, json, jsonify

app = Flask(__name__)

@app.route('/')
def home():
    message = {'hello': 'nyan!'}
    return jsonify(message)

@app.route('/v1')
def get_v1():
    message = {'message':'this route is not accessible.'}
    return jsonify(message)

@app.route('/v1/xiaomi/<device>')
def get_devices(device):
    with open('api/xiaomi/xiaomi_devices.json', 'r', encoding='utf-8') as file:
        data = json.load(file)

    if 'xiaomi' in data and device in data['xiaomi']:
        return jsonify({device: data['xiaomi'][device]})
    else:
        return jsonify({"error": "Device not found"}), 404

@app.errorhandler(404)
def page_not_found(error):
    return jsonify({"error": "page not found!"}), 404

if __name__ == '__main__':
    app.run(debug=True)
