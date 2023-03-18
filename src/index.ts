import express, { Request, Response } from 'express';

const port = process.env.PORT || 4000;

const app = express();

app.get('/', (req: Request, res: Response) => {
	return res.json({message: "hey"});
});

app.listen(port, () => {
	console.log("listening on port " + port);
});