Return-Path: <linux-kernel+bounces-18569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3C1825F7C
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 13:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50D701C2128E
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 12:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175B17460;
	Sat,  6 Jan 2024 12:32:52 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A436FD0
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 12:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rM5qu-0000Ju-6T; Sat, 06 Jan 2024 13:32:36 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rM5qt-000nso-A6; Sat, 06 Jan 2024 13:32:35 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rM5qt-0040Bi-0k;
	Sat, 06 Jan 2024 13:32:35 +0100
Date: Sat, 6 Jan 2024 13:32:35 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc: Thierry Reding <thierry.reding@gmail.com>, 
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: pxa-pwm: Convert to YAML
Message-ID: <vp2hqzkfpd45xr6rivbh3l7wrybprdcd3tk63t3w27vktmpkqu@emhbfg4cb2zl>
References: <20240105-pxa-pwm-yaml-v1-1-4ded9d00c38f@skole.hr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sjwskbdtxv4t6hpe"
Content-Disposition: inline
In-Reply-To: <20240105-pxa-pwm-yaml-v1-1-4ded9d00c38f@skole.hr>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--sjwskbdtxv4t6hpe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Jan 05, 2024 at 11:50:32PM +0100, Duje Mihanovi=C4=87 wrote:
> Convert the PXA PWM binding file from TXT to YAML.
>=20
> Signed-off-by: Duje Mihanovi=C4=87 <duje.mihanovic@skole.hr>

LGTM

Reviewed-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

I'd wait for an ack by the dt people before picking this up.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--sjwskbdtxv4t6hpe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmWZSGIACgkQj4D7WH0S
/k6VFQgAo+Yqwofg+/xzFQSjMQu1aUvEwWD35jOQFsGUxk8dT+ZHWh6svkbc19cT
o973u0Ce/BJcDi5w+nxiYUG4po9XZrcppScsW4KrlF6QmZQYuRKSXFA71iTSxAH9
FJ/aesp2kImVlGCJdpZUsI2lMSgoqwuCmE9W9Hk12ubi1D2iqjUo9CSzlF++TN/r
tAUkoAlSxGEHp2oAUISAPzV4A7LTWBKADegMesiJhyxIVrMbBycpVPgEpWbGRAMV
6foVDoeWckSaxqaSO9Us+wEu/Zzks7Pr+0Ct0jD/hCUp2vMgQr7/pfYKPLhHpBgs
HUpFBLjjrfhRS7qntujrk6kDHWb9vw==
=qiZx
-----END PGP SIGNATURE-----

--sjwskbdtxv4t6hpe--

