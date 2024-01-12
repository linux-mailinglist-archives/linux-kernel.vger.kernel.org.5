Return-Path: <linux-kernel+bounces-24985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C5482C5A2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 19:53:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1574B20F7E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 18:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323DF15AD8;
	Fri, 12 Jan 2024 18:53:48 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DE1156DF
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 18:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rOMeP-00032S-MK; Fri, 12 Jan 2024 19:53:05 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rOMeK-002CyT-QW; Fri, 12 Jan 2024 19:53:00 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rOMeK-008NwN-2H;
	Fri, 12 Jan 2024 19:53:00 +0100
Date: Fri, 12 Jan 2024 19:53:00 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Raag Jadav <raag.jadav@intel.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
	Fabio Estevam <festevam@gmail.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	Khuong Dinh <khuong@os.amperecomputing.com>, Kevin Hilman <khilman@baylibre.com>, 
	Andy Gross <agross@kernel.org>, NXP Linux Team <linux-imx@nxp.com>, 
	linux-arm-msm@vger.kernel.org, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Frank Li <Frank.li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Besar Wicaksono <bwicaksono@nvidia.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, linux-amlogic@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, Neil Armstrong <neil.armstrong@linaro.org>, 
	Jiucheng Xu <jiucheng.xu@amlogic.com>, Shawn Guo <shawnguo@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, linux-kernel@vger.kernel.org, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Shuai Xue <xueshuai@linux.alibaba.com>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 00/18] perf: Convert to platform remove callback
 returning void
Message-ID: <2lviizgknyxxwa5fg45sv3rfg6h43qvv7w6ae4nptlkm774hcp@4rsdsvwpcq6c>
References: <cover.1702648124.git.u.kleine-koenig@pengutronix.de>
 <vlnl6og3bts5hcdjw5h7c4km7zolzuf6h7cwyfymjzan3uqjwy@rsra3lqdhou7>
 <20240112135009.GA16771@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vke34tmtmued5nvt"
Content-Disposition: inline
In-Reply-To: <20240112135009.GA16771@willie-the-truck>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--vke34tmtmued5nvt
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Will,

On Fri, Jan 12, 2024 at 01:50:09PM +0000, Will Deacon wrote:
> On Wed, Jan 10, 2024 at 09:56:26AM +0100, Uwe Kleine-K=F6nig wrote:
> > On Fri, Dec 15, 2023 at 02:59:00PM +0100, Uwe Kleine-K=F6nig wrote:
> > > this series converts all drivers below drivers/perf to use
> > > .remove_new(). See commit 5c5a7680e67b ("platform: Provide a remove
> > > callback that returns no value") for an extended explanation and the
> > > eventual goal. The TL;DR; is to make it harder for driver authors to
> > > leak resources without noticing.
> > >=20
> > > I based the patches on today's next, I had to revert commits=20
> > > 3115ee021bfb ("arm64: perf: Include threshold control fields in
> > > PMEVTYPER mask") and 816c26754447 ("arm64: perf: Add support for event
> > > counting threshold") to compile test on ARCH=3Darm (this is a problem=
 in
> > > next, not in my patch series).
> > >=20
> > > This is merge window material. All patches are pairwise independent of
> > > each other so they can be applied individually. Still it would be gre=
at
> > > to let them go in all together.
> >=20
> > I wonder if this series is still on someone's radar. It didn't appear in
> > next up to now, so I guess it's too late for 6.8-rc1?!
>=20
> This came in during the holiday period so, by the time I saw it, it was
> too late to land for this merge window. I can pick it up for 6.9 in a few
> weeks, though. I usually start queueing stuff at -rc3.

If it's not lost I'm happy. There are still quite a few more such
changes necessary for other subsystems, so no time pressure from my
side; 6.9 is great.

Cheers
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--vke34tmtmued5nvt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmWhiosACgkQj4D7WH0S
/k5aWwf7BuXw3bYNc3VbYfXdW3RoIYntlEgq6QVUK0bRidYY00oQ99K0GXu/LAh1
ia+WmqQ1A45GuvAh2Q/5502p/5PfExDWIgWEyvEIdiEilKS0y/1yVhRuwWg62kEO
C6OsBmphtkbuUbGmKnpEURdqgslMkLiGAqCCzXMTDqjrcttSH0twaPpmQh9SemfQ
xAGukovuoPDXoEE2JbzZgRpkIEt+YkvSVkicU4aq9UhVaacak0SuGXGmcqL/dOJZ
KwWaAhdxJh5+q2N0mqlmFVjZYLv0s9WYpjic8ZjlA3Ie3V/hKP8q8pVR7TRNOFZZ
yfmCKfk96RxKLFonuuofeFaY4y/AAA==
=YLUl
-----END PGP SIGNATURE-----

--vke34tmtmued5nvt--

