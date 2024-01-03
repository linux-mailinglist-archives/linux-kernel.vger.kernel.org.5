Return-Path: <linux-kernel+bounces-15509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A7A822CEA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 13:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE1231C23543
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 12:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53CF519477;
	Wed,  3 Jan 2024 12:22:29 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6B918EDD
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 12:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rL0GL-00043N-Mm; Wed, 03 Jan 2024 13:22:21 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rL0GE-00074J-Ti; Wed, 03 Jan 2024 13:22:14 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rL0GE-003Lb5-2e;
	Wed, 03 Jan 2024 13:22:14 +0100
Date: Wed, 3 Jan 2024 13:22:14 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: William Qiu <william.qiu@starfivetech.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org, 
	Emil Renner Berthing <kernel@esmil.dk>, Rob Herring <robh+dt@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Hal Feng <hal.feng@starfivetech.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v10 2/4] pwm: opencores: Add PWM driver support
Message-ID: <sl3np65yohjs2hyz3d2mfbs3ewdfpaisdlgle7dcqudpecgipl@pxccptubrguc>
References: <20231222094548.54103-1-william.qiu@starfivetech.com>
 <20231222094548.54103-3-william.qiu@starfivetech.com>
 <b1a44192-4e7d-46c2-b9cf-969795208839@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ei7ppzofy2gte56m"
Content-Disposition: inline
In-Reply-To: <b1a44192-4e7d-46c2-b9cf-969795208839@starfivetech.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--ei7ppzofy2gte56m
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello William,

On Wed, Jan 03, 2024 at 03:15:31PM +0800, William Qiu wrote:
> Could you please help me review this patch series to see if there is
> anything that needs to be modified? If not, could you help me integrate
> this patch into the main line? Thanks.
> Thanks for taking time to review this patch series.

It's on my radar. Actually your patch set is on the top of my list. I
won't promise a timely review, but I plan to do it this week.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ei7ppzofy2gte56m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmWVUXUACgkQj4D7WH0S
/k4Wrgf9H2xWkjQYexVF/+Fqnk0YZUI6HXVnF+6vhwtoU8wskh1hVETaDfAsA1ca
TNI/mS1aYYaukikrpbprbR0MjwI2dRjvwm54xZgvZLTZx61Gl69FNH2KMlnPCjha
9Vw++IAFa+HrzV55Yl/fmY1/W4i7sHZTDY+px2IgD51sxy4SLZq7D0S9NurCGx7J
PbGHBBNWdSxWjP6klQdnA2C7A6ivG3nkhVmcqKXlmwpdacEEUh8kfyJVQ/n4QRZi
15sCY0nt9D6IOC9v1z2mvPocCrTMkefG0gkraiOVf6Xh5kIFHVUNAj2NTnQb7F2R
7FFOt3V+xcAO+F9jVsSfZymQ+t9Mbg==
=Lp3F
-----END PGP SIGNATURE-----

--ei7ppzofy2gte56m--

