Return-Path: <linux-kernel+bounces-20118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1808279EA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 22:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 721701F22DA2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 21:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EACD455E62;
	Mon,  8 Jan 2024 21:04:03 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5182A55E64
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 21:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rMwmn-0007Sw-0g; Mon, 08 Jan 2024 22:03:53 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rMwmj-001KoV-Ei; Mon, 08 Jan 2024 22:03:49 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rMwmj-005EcE-0e;
	Mon, 08 Jan 2024 22:03:49 +0100
Date: Mon, 8 Jan 2024 22:03:49 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Conor Dooley <conor+dt@kernel.org>
Cc: William Qiu <william.qiu@starfivetech.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org, 
	Emil Renner Berthing <kernel@esmil.dk>, Rob Herring <robh+dt@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Hal Feng <hal.feng@starfivetech.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v10 1/4] dt-bindings: pwm: Add bindings for OpenCores PWM
 Controller
Message-ID: <p22vjdwk35yc66mb4pkntnst6kjyhhmnv3eb2n25c3dhi5bdeo@bj7amwepprab>
References: <20231222094548.54103-1-william.qiu@starfivetech.com>
 <20231222094548.54103-2-william.qiu@starfivetech.com>
 <t3w2p765fs633nanqsx5yqres7taqpk6juwyl4iex5v4jpobo2@rqw6r4myjmv3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qdsxa55awznoyul6"
Content-Disposition: inline
In-Reply-To: <t3w2p765fs633nanqsx5yqres7taqpk6juwyl4iex5v4jpobo2@rqw6r4myjmv3>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--qdsxa55awznoyul6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Conor,

On Thu, Jan 04, 2024 at 11:43:13PM +0100, Uwe Kleine-K=F6nig wrote:
> On Fri, Dec 22, 2023 at 05:45:45PM +0800, William Qiu wrote:
> > Add bindings for OpenCores PWM Controller.
> >=20
> > Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> > Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>=20
> Looks fine to me. I'll assume you reiterate the series for patch #2 and
> so I will mark this patch as deferred in patchwork.
>=20
> Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

If you want, pick this patch up that it goes along with the dts changes.

To make this formal:

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--qdsxa55awznoyul6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmWcYy8ACgkQj4D7WH0S
/k5Cxgf/QI/V+M0FjuVw/kgYUfVX9XsL67vIUwYey8CNZjcTRYrd1pch6cjV4Uxa
Oq7ZKp7LpMxt6yLwKcI9vZHav86KPKPI+CaZtMpC2OuYqEo4ltygCMOUJrXoJnDU
epVaCEiIS5e3vsOZ35EWGQeOpXUV/xHHNA4VIKfI1F4arIpPvlS6J3t8h/8nICpQ
jk8Fk0X2HRqdy+kX0P6kSaQFBDBIFS/zRYI0ahlgLWEOGPj7dfpYa6Oqj7sXiZZP
Mta2dmEwn4C10rTk7Pa7Y/RtpsYU2EVPiqaaHqgbTKrzpFPIPldMS4+f7CTYiKWD
/s4YD833V/0aPhWZHYCGEQmTv4NlBw==
=5dXp
-----END PGP SIGNATURE-----

--qdsxa55awznoyul6--

