Return-Path: <linux-kernel+bounces-10605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2484981D73A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 00:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC2221F21D40
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 23:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61B11D681;
	Sat, 23 Dec 2023 23:30:07 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEB21D52D
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 23:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rHBRL-0007nz-LQ; Sun, 24 Dec 2023 00:29:55 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rHBRJ-0015Dk-SM; Sun, 24 Dec 2023 00:29:54 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rHBRK-000W3f-2q;
	Sun, 24 Dec 2023 00:29:54 +0100
Date: Sun, 24 Dec 2023 00:29:54 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, 
	Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org
Subject: Re: [PATCH] pwm: linux/pwm.h: fix Excess kernel-doc description
 warning
Message-ID: <6t33645cqum3ocuojfzr3n7vcj7c63hz6plo7677r6527hwime@3r6tqotja5bk>
References: <20231223050621.13994-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="klonewd2iqhya2tb"
Content-Disposition: inline
In-Reply-To: <20231223050621.13994-1-rdunlap@infradead.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--klonewd2iqhya2tb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Randy,

On Fri, Dec 22, 2023 at 09:06:20PM -0800, Randy Dunlap wrote:
> Remove the @pwm: line to prevent the kernel-doc warning:
>=20
> include/linux/pwm.h:87: warning: Excess struct member 'pwm' description i=
n 'pwm_device'
>=20
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Cc: linux-pwm@vger.kernel.org

Oh indeed.

Fixes: f3e25e68ceb2 ("pwm: Drop unused member "pwm" from struct pwm_device")
Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--klonewd2iqhya2tb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmWHbXEACgkQj4D7WH0S
/k6d3gf/YnniEa/fLJqV2cAgyKgSQ85twNO6kXiMVKCVEAA+Z6rjwMm55Pm1EXDw
+1NSQloew0KvpV8oIp0DjCcGCZXVWRuobiMVEd4yY9M4Wo279+TIG66975OUz1nv
hOtSy+6rzy5SBwzeyayGbHHLTqngWAkgEJ3+o2WvSEqtIX6K2okGFWI1ane6wQub
0o//hgV1rE9jUmOIQtB0bvY1l2PBZd+GX179Mtc57Y5F42k0ES+D45jeawSi26nX
HlQtdR199oBC0DAqJ4ohMSprWtCP38icycrR15Vk1TebNda/IN9UqaGstqVl043i
1dIrQfBbK22CaV0jS9FQw4eol5YzpQ==
=Sngb
-----END PGP SIGNATURE-----

--klonewd2iqhya2tb--

