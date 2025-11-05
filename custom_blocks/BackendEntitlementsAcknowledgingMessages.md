---
name: Backend Entitlements - Acknowledging messages
---
Upon the reception of an event, you MUST return a `HTTP 200` to confirm to the Purchasely Platform that your backend has successfully handled the event.

> 📘 Return (almost) always a `200` response.
>
> If you don't, the Purchasely Platform will continue sending you the message following our retry strategy. This table contains approximate retry waiting times:
>
> | #  | Next retry backoff | Total waiting time |
> | :- | :----------------- | :----------------- |
> | 1  | 0d 0h 0m 20s       | 0d 0h 0m 20s       |
> | 2  | 0d 0h 0m 26s       | 0d 0h 0m 46s       |
> | 3  | 0d 0h 0m 46s       | 0d 0h 1m 32s       |
> | 4  | 0d 0h 1m 56s       | 0d 0h 3m 28s       |
> | 5  | 0d 0h 4m 56s       | 0d 0h 8m 24s       |
> | 6  | 0d 0h 11m 10s      | 0d 0h 19m 34s      |
> | 7  | 0d 0h 22m 26s      | 0d 0h 42m 0s       |
> | 8  | 0d 0h 40m 56s      | 0d 1h 22m 56s      |
> | 9  | 0d 1h 9m 16s       | 0d 2h 32m 12s      |
> | 10 | 0d 1h 50m 26s      | 0d 4h 22m 38s      |
> | 11 | 0d 2h 47m 50s      | 0d 7h 10m 28s      |
> | 12 | 0d 4h 5m 16s       | 0d 11h 15m 44s     |
> | 13 | 0d 5h 46m 56s      | 0d 17h 2m 40s      |
> | 14 | 0d 7h 57m 26s      | 1d 1h 0m 6s        |
> | 15 | 0d 10h 41m 46s     | 1d 11h 41m 52s     |
> | 16 | 0d 14h 5m 20s      | 2d 1h 47m 12s      |
> | 17 | 0d 18h 13m 56s     | 2d 20h 1m 8s       |
> | 18 | 0d 23h 13m 46s     | 3d 19h 14m 54s     |
> | 19 | 1d 5h 11m 26s      | 5d 0h 26m 20s      |
> | 20 | 1d 12h 13m 56s     | 6d 12h 40m 16s     |
> | 21 | 1d 20h 28m 40s     | 8d 9h 8m 56s       |
> | 22 | 2d 6h 3m 26s       | 10d 15h 12m 22s    |
> | 23 | 2d 17h 6m 26s      | 13d 8h 18m 48s     |
> | 24 | 3d 5h 46m 16s      | 16d 14h 5m 4s      |
> | 25 | 3d 20h 11m 56s     | 20d 10h 17m 0s     |
>
> Any other response code than `HTTP 200` will generate a retry.
>
> > 🚧 Not returning a `200` will pause subsequent webhooks for the user.
> >
> > To ensure webhooks are always sent in the correct order (otherwise an `ACTIVATE`/`DEACTIVATE` could become a `DEACTIVATE`/`ACTIVATE`, causing unintended access for your user), we will not send any subsequent webhooks for the affected user until the first one succeeds on your end (ie: until we receive a `200` response).
> >
> > Once the first webhook succeeds, any paused webhooks will be sent immediately, maintaining the correct order.
>
> > 🚧 Anonymous users
> >
> > Sometimes you way receive webhooks targeting an <Glossary>Anonymous User</Glossary>, even if you're not supposed to have one.
> >
> > In this case, just return a `200` response and ignore the content of the webhook. When the user logs in, the subscription will be automatically associated with them, and you’ll receive the corresponding webhook.
> >
> > If you don’t return a `200` response, we’ll keep sending the anonymous user’s webhook, and you’ll never receive the one for the connected user (because we want to guarantee the order of webhooks, as explained before).
