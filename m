Return-Path: <linux-kernel+bounces-5649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF802818D99
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F62A1F25464
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F42C45C1C;
	Tue, 19 Dec 2023 17:01:56 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4400731A63
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 17:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rFdTX-0001Qs-Pt; Tue, 19 Dec 2023 18:01:47 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rFdTW-0003n2-AU; Tue, 19 Dec 2023 18:01:47 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rFdTX-000BWR-4H; Tue, 19 Dec 2023 18:01:47 +0100
Date: Tue, 19 Dec 2023 18:01:47 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Sean Young <sean@mess.org>
Cc: linux-media@vger.kernel.org, linux-pwm@vger.kernel.org, 
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 2/6] pwm: Replace ENOTSUPP with EOPNOTSUPP
Message-ID: <eeewkabfujbszz226tibtsmry2gf2nygwqcs4au7y2rulqoobt@qgdyyvlbcoma>
References: <cover.1703003288.git.sean@mess.org>
 <7d6c10b52bbb29925fff9d2f16788a65c138921e.1703003288.git.sean@mess.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xsvd72fnpkymohhj"
Content-Disposition: inline
In-Reply-To: <7d6c10b52bbb29925fff9d2f16788a65c138921e.1703003288.git.sean@mess.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--xsvd72fnpkymohhj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 04:30:25PM +0000, Sean Young wrote:
> According to Documentation/dev-tools/checkpatch.rst ENOTSUPP is
> not recommended and EOPNOTSUPP should be used instead.
>=20
> Signed-off-by: Sean Young <sean@mess.org>

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--xsvd72fnpkymohhj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmWBzHoACgkQj4D7WH0S
/k6t8AgAhDIOQQmuFx+ge4Psp5comBBYf6kTwTuMMJJU5VPdMg5GO1CY3dV7zAyW
0HQ1Zxqf4ZHL622v7BH/b4p2m6zhVbbzWylrn9AqvWF8/X9tiXK87jrrmFhsVHde
tkZny1d1RXLy6kiNJD5gSHyVNH5Fc73POTIVlL8ImfyynqAOvhq85LaCu9oHTTSI
mYgwY2zXVBArbs9kfOz+U31eeVCkKr3U8U3nXfqAbHD9CEMw7upVNF5zgTeupFHH
k72B3ZZqDrt/6CTeEKzlfihsPTQ69jyXDJm8paIkmXsw7De2qYyLhhpfPJluQZnT
nHOh3Wn/Lorr7vQg08vVEnk8voY+lQ==
=zASY
-----END PGP SIGNATURE-----

--xsvd72fnpkymohhj--

