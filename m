Return-Path: <linux-kernel+bounces-21866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D26829572
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 09:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E9521F26AD3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 08:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9233A8F4;
	Wed, 10 Jan 2024 08:57:02 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551A53A1D5
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 08:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rNUNx-0004Iz-T7; Wed, 10 Jan 2024 09:56:29 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rNUNu-001f8W-QB; Wed, 10 Jan 2024 09:56:26 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rNUNu-006Ntr-2E;
	Wed, 10 Jan 2024 09:56:26 +0100
Date: Wed, 10 Jan 2024 09:56:26 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Raag Jadav <raag.jadav@intel.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
	Fabio Estevam <festevam@gmail.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	Khuong Dinh <khuong@os.amperecomputing.com>, Kevin Hilman <khilman@baylibre.com>, 
	Andy Gross <agross@kernel.org>, NXP Linux Team <linux-imx@nxp.com>, 
	linux-arm-msm@vger.kernel.org, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Frank Li <Frank.li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Besar Wicaksono <bwicaksono@nvidia.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, linux-amlogic@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, Neil Armstrong <neil.armstrong@linaro.org>, 
	Jiucheng Xu <jiucheng.xu@amlogic.com>, Robin Murphy <robin.murphy@arm.com>, 
	Bjorn Andersson <andersson@kernel.org>, linux-kernel@vger.kernel.org, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Shuai Xue <xueshuai@linux.alibaba.com>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH 00/18] perf: Convert to platform remove callback
 returning void
Message-ID: <vlnl6og3bts5hcdjw5h7c4km7zolzuf6h7cwyfymjzan3uqjwy@rsra3lqdhou7>
References: <cover.1702648124.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="no4oat75dmv7km36"
Content-Disposition: inline
In-Reply-To: <cover.1702648124.git.u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--no4oat75dmv7km36
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Dec 15, 2023 at 02:59:00PM +0100, Uwe Kleine-K=F6nig wrote:
> this series converts all drivers below drivers/perf to use
> .remove_new(). See commit 5c5a7680e67b ("platform: Provide a remove
> callback that returns no value") for an extended explanation and the
> eventual goal. The TL;DR; is to make it harder for driver authors to
> leak resources without noticing.
>=20
> I based the patches on today's next, I had to revert commits=20
> 3115ee021bfb ("arm64: perf: Include threshold control fields in
> PMEVTYPER mask") and 816c26754447 ("arm64: perf: Add support for event
> counting threshold") to compile test on ARCH=3Darm (this is a problem in
> next, not in my patch series).
>=20
> This is merge window material. All patches are pairwise independent of
> each other so they can be applied individually. Still it would be great
> to let them go in all together.

I wonder if this series is still on someone's radar. It didn't appear in
next up to now, so I guess it's too late for 6.8-rc1?!

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--no4oat75dmv7km36
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmWeW7kACgkQj4D7WH0S
/k5rIwgAqr3/DiavBC9snrdYbr7SgHIPe7cKime6131NsWiElWfvc2pWiDnQyj1t
qo6sBLxFi+qRa61dSSRy7b7NT3XZ4orkpEgASsGYtgyc/b0f0XlAkn2RRcRaPeQW
XKbHFW4fjGZfXhyUdOBp9vvhuraDQx1GZezpISG0YWvT4UFQIlFSfX6GaoiIGe4d
LidSuc3leV3Ke2RsFLw0GhIHrv7ctd96TqJsXP7zmDh/sFF4ysQEfbpeSkFDEjX0
fnGnHlj4cefY5TkgFtHZW7avEDUda7WdADNApxyYijPvMaoVg/5gRLjuoTABLO1h
abXTI2fsT0fot+C8JuPHCxKOwfIprA==
=53Rz
-----END PGP SIGNATURE-----

--no4oat75dmv7km36--

