const express = require("express");
const app = express();

const chalk = require("ansis");
const prompt = require("prompt");
const fs = require("fs");
const drpc = require("discord-rpc");
const axios = require("axios").default;

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

	// setInterval(() => {

	// 	if (Date.now() - lastStudioEdit > 5000) {
	// 		axios
	// 			.request({
	// 				method: "POST",
	// 				url: "https://presence.roblox.com/v1/presence/users",
	// 				data: {
	// 					userIds: [userId],
	// 				},
	// 			})
	// 			.then((response) => {
	// 				console.log(response.data);
	// 			})
	// 			.catch((error) => {
	// 				console.log(chalk.hex(redHex).bold(error.message));
	// 			});

	// 		// got.post("https://presence.roblox.com/v1/presence/users", {
	// 		// 	json: { userIds: [Number(userid)] },
	// 		// 	headers: {
	// 		// 		"Content-Type": "application/json",
	// 		// 		cookie: `RBXViralAcquisition=time=2/11/2021 12:46:13 PM&referrer=&originatingsite=; GuestData=UserID=-299031544; RBXSource=rbx_acquisition_time=2/11/2021 12:46:13 PM&rbx_acquisition_referrer=&rbx_medium=Direct&rbx_source=&rbx_campaign=&rbx_adgroup=&rbx_keyword=&rbx_matchtype=&rbx_send_info=1; __utmc=200924205; RBXEventTrackerV2=CreateDate=2/11/2021 12:48:25 PM&rbxid=104793962&browserid=80031577037; gig_bootstrap_3_OsvmtBbTg6S_EUbwTPtbbmoihFY5ON6v6hbVrTbuqpBs7SyF_LQaJwtwKJ60sY1p=_gigya_ver4; _ga=GA1.2.1501438022.1613069246; .ROBLOSECURITY=_|WARNING:-DO-NOT-SHARE-THIS.--Sharing-this-will-allow-someone-to-log-in-as-you-and-to-steal-your-ROBUX-and-items.|_E3E9C46568023240D686F2E866A37B938CD0BB428118B44154716DAB093774111BFCA36A7022F17FDE2026A56A78CD1FE34200995A85CE39DC65979F20A3D9B23F428BBB258C3B1688B69420C8C035FAB176740D61C2EC180FE24CF30D9B3D34130535DE2221551D349A318F38FEACA717BBC20F05075E8DDEA0E5BEB61AFAAE0EBDEF023C85FC66D678D2BAF59CF20F05C70ABF0E09DCD48F7FDEDBD5CA9B4AA464EEAA7630EA40852389DF667868BA6F58A890ACAEB120EA8315E14413E6CCD24EB643DA0410640BF89E75AB520C603386612471A35A8EDD5C98B7869A9F100F57E812D05F1FE02AA8D5536EAFCFB1C9E5E8D1805D93BAB3C7EFD6499414ED9201E085EE0C047D9BB3C9D3CAC4326C68DADAFD168350012FC11501A7B44306C76BF9BFB36D17F6E4AF3566D17BD769A5224F80; .RBXID=_|WARNING:-DO-NOT-SHARE-THIS.--Sharing-this-will-allow-someone-to-log-in-as-you-and-to-steal-your-ROBUX-and-items.|_eyJhbGciOiJIUzI1NiJ9.eyJqdGkiOiI3NmQ5NTRiZS02MjdiLTQ4YjctYTVhNi1kNDdhYjgzYjUwMjIiLCJzdWIiOjQzNDU3NTQwfQ.NsIhAWdN6V2uc0HAowMkHtTSSolp5SHJLO0iCzk4DDU; __utmz=200924205.1614694619.33.6.utmcsr=sleitnick.github.io|utmccn=(referral)|utmcmd=referral|utmcct=/Knit/gettingstarted/; _gid=GA1.2.1963859931.1614713564; RBXSessionTracker=sessionid=accfb73c-6c14-4985-8c76-da905c731d48; __utma=200924205.1501438022.1613069246.1615058009.1615062143.40; rbx-ip2=`,
	// 		// 	},
	// 		// }).then((data) => {
	// 		// 	data = JSON.parse(data.body);

	// 		// 	console.log("okay i got data back, lets see it");
	// 		// 	console.log(data);
	// 		// 	if (!data.userPresences[0].placeId) return RPC.clearActivity();
	// 		// 	got(
	// 		// 		`https://api.roblox.com/marketplace/productinfo/${data.usersPresences[0].placeId}`
	// 		// 	)
	// 		// 		.then((json) => json.json())
	// 		// 		.then((placeData) => {
	// 		// 			console.log("Alternate request");
	// 		// 			RPC.request("SET_ACTIVITY", {
	// 		// 				pid: process.pid,
	// 		// 				activity: {
	// 		// 					name: placeData.name,
	// 		// 				},
	// 		// 			});
	// 		// 		})
	// 		// 		.catch(console.error);
	// 		// });
	// 	}
	// }, 5000);

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
			console.log(chalk.hex(redHex).bold(error.message));
		});
});
