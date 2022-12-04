const express = require("express");
const app = express();

const chalk = require("ansis");
const prompt = require("prompt");
const fs = require("fs");
const drpc = require("discord-rpc");

const client = new drpc.Client({ transport: "ipc" });

const { blueHex, greenHex, redHex, yellowHex, orangeHex, purpleHex, pinkHex } =
	JSON.parse(fs.readFileSync("./colors.json", "utf8"));

const schema = {
	properties: {
		userId: {
			description: chalk.hex(yellowHex)("Enter your Roblox User ID"),
			type: "string",
			required: true,
		},
	},
};

let lastStudioEdit = Date.now();

app.use(express.json());

app.post("/", async (request, response) => {
	lastStudioEdit = Date.now();

	try {
		data = request.body;
		// console.log(data);

		if (data.updateType == "CLOSE") {
			client.request("SET_ACTIVITY", {
				pid: process.pid,
			});

			client.transport.close();
			client.transport.connect();
		} else {
			client.request("SET_ACTIVITY", {
				pid: process.pid,
				activity: data.activity,
			});
		}

		response.status(200).send("SET Activity");
	} catch (error) {
		console.log(chalk.hex(redHex).bold(error.message));
	}
});

app.listen(4455, async () => {
	let userId;

	if (fs.existsSync("./userId.txt")) {
		userId = fs.readFileSync("./userId.txt", "utf8");
	} else {
		prompt.start();

		userId = await new Promise((resolve, reject) => {
			prompt.get(schema, (error, result) => {
				if (error) {
					reject(error);
				} else {
					resolve(result.userId);
				}
			});
		});

		fs.writeFileSync("./userId.txt", userId);
	}

	console.log(chalk.hex(blueHex)("Starting"));

	client
		.login({ clientId: "812381092963287050" })
		.then(() => {
			console.log(
				chalk.hex(greenHex)(
					"Thank you for using DRPC by RigidStudios#6315."
				)
			);
		})
		.catch((error) => {
			console.log(chalk.hex(redHex).bold(err.message));
		});
});
