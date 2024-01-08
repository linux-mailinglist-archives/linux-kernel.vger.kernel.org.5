Return-Path: <linux-kernel+bounces-19895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 977D482765B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 18:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 346AE1F232CD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 17:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3D654735;
	Mon,  8 Jan 2024 17:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="un01cIWs"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C385466F;
	Mon,  8 Jan 2024 17:31:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB9E7C433C8;
	Mon,  8 Jan 2024 17:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704735083;
	bh=TpcI3dIuWNjlKbiZdSsWqC4HAoWP9zhHwULpZ+JjExE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=un01cIWsY2l7ec12fbUWfb1qr8tZmvTjPeOHQAZJDN7e8roSZWeXC8LHNqMgPmpt/
	 OSJq5FkZWjL4xVuyHSbSu7PnsXNvasjfv2Fewr2IM4Kn9JwVTcO+e8Atyi9TiwW0TE
	 2xCNujZTg4R/G6UpksnYomw7qHgAQ+vTmtoLzh4k+sBUjltbXgHCuwUabRygiYJh63
	 ZgkmEgfsZIbiXJaHkMiwJxqdY1kSPBHIcaKcQb5VU33KHe7SQSHhGtUqHxXc9VX8dI
	 V4xdKwwTFgLcd5t635lQSRPyblLOgmp1KqPriyffLCc/wFGfI/YcwXKFK+C8BhEkxH
	 BRzEyAvcqb7XQ==
Date: Mon, 8 Jan 2024 17:31:17 +0000
From: Conor Dooley <conor@kernel.org>
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	William Qiu <william.qiu@starfivetech.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org,
	Emil Renner Berthing <kernel@esmil.dk>,
	Rob Herring <robh+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hal Feng <hal.feng@starfivetech.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v10 3/4] riscv: dts: starfive: jh7100: Add PWM node and
 pins configuration
Message-ID: <20240108-hubcap-stubble-ecf6ea34afb9@spud>
References: <20231222094548.54103-1-william.qiu@starfivetech.com>
 <20231222094548.54103-4-william.qiu@starfivetech.com>
 <CAJM55Z9tyrR7emEBrY0+Fnc_LUFQHkqYHLQ4ptL=XQMy52qtVw@mail.gmail.com>
 <xd2ryic6mr6d6cbljjbhmr56mfpchfzkmc3lnznhmoiwyzip2a@6bhbho267e7c>
 <CAJM55Z9DgFCwXjQGhe+urnOg-AkJMbQUR+biXKONQsRcup1GXw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uwSZRLPC3LWeYwWV"
Content-Disposition: inline
In-Reply-To: <CAJM55Z9DgFCwXjQGhe+urnOg-AkJMbQUR+biXKONQsRcup1GXw@mail.gmail.com>


--uwSZRLPC3LWeYwWV
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 05, 2024 at 05:18:45AM -0800, Emil Renner Berthing wrote:
> Uwe Kleine-K=F6nig wrote:
> > Hello Emil,
> >
> > On Sun, Dec 24, 2023 at 02:49:34AM -0800, Emil Renner Berthing wrote:
> > > William Qiu wrote:
> > > > Add OpenCores PWM controller node and add PWM pins configuration
> > > > on VisionFive 1 board.
> > > >
> > > > Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> > >
> > > Sorry, I thought I already sent my review. This looks good.
> > >
> > > Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> >
> > Is this also an implicit Ack to take this patch via the pwm tree once
> > the earlier patches are ready? Or do you want to take it via your tree?
> > (Maybe already now together with the binding? If so, you can assume my
> > Reviewed-by to be an implicit Ack for that.)
>=20
> Yes, sorry. This is also meant to be an Ack from me.
>=20
> I imagined the dt patches would go through Conor's riscv-dt-for-next bran=
ch,
> but the pwm tree is certainly also fine by.

idk, I prefer things to go as MAINTAINERS indicates, in case something
is determined to be wrong in the cycle where the patch is in the "wrong"
tree.

I suppose I could take the binding though, since I am CCed on every
binding patch under the sun... I'd rather an explicit ack in that case
though.

Cheers,
Conor.

--uwSZRLPC3LWeYwWV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZZwxZQAKCRB4tDGHoIJi
0nUqAP9yJe3WrgYMWXpHjBz60+ar3t/qeJkOfk0Jf5wV3nSGKQEA/+BcCFymlJ3W
7iVCVwtlZAqIdUtOXuLEG5keZjo0kwI=
=7uiV
-----END PGP SIGNATURE-----

--uwSZRLPC3LWeYwWV--

