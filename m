Return-Path: <linux-kernel+bounces-9079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C1981C009
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 22:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F126A1F25BE8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 21:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C27976DB3;
	Thu, 21 Dec 2023 21:25:35 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D354A64ABE
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 21:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rGQXo-0006LI-Kx; Thu, 21 Dec 2023 22:25:28 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rGQXm-000bza-VV; Thu, 21 Dec 2023 22:25:28 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rGQXn-001VAN-PL; Thu, 21 Dec 2023 22:25:27 +0100
Date: Thu, 21 Dec 2023 22:25:27 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Santosh Shilimkar <ssantosh@kernel.org>, kernel@pengutronix.de, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] memory: emif: ifdefs and platform_driver_probe()
Message-ID: <xv6llov6iuhj45dukzh5bvxvynl25rjqrfvx76wn4goci2vv2e@zo6uucf7y4uy>
References: <cover.1702829744.git.u.kleine-koenig@pengutronix.de>
 <8764ca60-56b4-4309-aa8e-2e5b89dfc32b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uep552yorgz7eqtb"
Content-Disposition: inline
In-Reply-To: <8764ca60-56b4-4309-aa8e-2e5b89dfc32b@linaro.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--uep552yorgz7eqtb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Krzysztof,

On Thu, Dec 21, 2023 at 09:46:29PM +0100, Krzysztof Kozlowski wrote:
> On 17/12/2023 20:31, Uwe Kleine-K=F6nig wrote:
> > while preparing the series to convert the platform drivers below
> > drivers/memory to use .remove_new()[1], I noticed that the emif driver
> > unnecessarily uses some #ifdefs and doesn't use platform_driver_probe()
> > correctly. Note there is a conflict between these series. Tell me if you
> > need support to resolve this.
>=20
> I was waiting here for some Reviews or Tested-by. Time passed, reviews
> did not happen but it is too late for me to take it for the next merge
> window. I will take it after the merge window.

Thanks for the status update. That's very appreciated. (And taking it
for the next development cycle is entirely fine, that's just a drive-by
series, nothing on my side depends on it.)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--uep552yorgz7eqtb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmWErUYACgkQj4D7WH0S
/k7nawf+OGPeaoYwHC8myj5znOkJ4dGBp/PDEZc7TYBYYFU8VPBoegPKNJfhnsls
Cys9GM9Uy35ZtyBcCSSRA02+Lm1YNWEHhBaM53s6xX/UmT009FHt0+lWii4ZOA6+
8XektD5kMi0dhEqa2rHN+AYcABlaXvrW507X78R++4xFxJF0iBJgJ8QC6eHDHVfG
jFHn/JJ4GzO6pCOzOMWJlDj+HJoQU3zQc/DJJjtm6jh81uPqjD+hOajY+Nxizu7g
gKw3o0nwkCfpjAhDh8pMiH23hkRYD7Y/qpCZVXS47Cgo1Try8jasS4DUMWdarFPY
bN8LR5r3LsK6T6rcNrGE+8y0Puwp8Q==
=24zw
-----END PGP SIGNATURE-----

--uep552yorgz7eqtb--

