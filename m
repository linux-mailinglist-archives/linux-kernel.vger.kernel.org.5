Return-Path: <linux-kernel+bounces-19289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01179826AE8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 10:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B86828147F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 09:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996DC12B99;
	Mon,  8 Jan 2024 09:39:53 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B964312B6C
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 09:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rMlt0-000418-SC; Mon, 08 Jan 2024 10:25:34 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rMlsz-001DHQ-BP; Mon, 08 Jan 2024 10:25:33 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rMlsz-004jki-0p;
	Mon, 08 Jan 2024 10:25:33 +0100
Date: Mon, 8 Jan 2024 10:25:33 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Nylon Chen <nylon.chen@sifive.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, thierry.reding@gmail.com, 
	emil.renner.berthing@canonical.com, vincent.chen@sifive.com, greentime.hu@sifive.com, 
	zong.li@sifive.com, nylon7717@gmail.com
Subject: Re: [v5 2/2] pwm: sifive: change the PWM controlled LED algorithm
Message-ID: <djdio3t54er4vqnjp4yjeoghopd5gdkybktvojzzvhs5ijxmwg@4db2hsmtoh6e>
References: <20231024101902.6689-1-nylon.chen@sifive.com>
 <20231024101902.6689-3-nylon.chen@sifive.com>
 <20231211204950.fkaqsnpzb6kixqf2@pengutronix.de>
 <CAHh=Yk-9-M2G_cfdxLig2d0g1DucEytXhfFO5dp5HcDn+egWBw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2uooa2ltsa4cbfhk"
Content-Disposition: inline
In-Reply-To: <CAHh=Yk-9-M2G_cfdxLig2d0g1DucEytXhfFO5dp5HcDn+egWBw@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--2uooa2ltsa4cbfhk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Nylon,

On Mon, Jan 08, 2024 at 04:27:40PM +0800, Nylon Chen wrote:
> Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> =E6=96=BC 2023=E5=
=B9=B412=E6=9C=8812=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=884:50=E5=
=AF=AB=E9=81=93=EF=BC=9A
> > On Tue, Oct 24, 2023 at 06:19:02PM +0800, Nylon Chen wrote:
> > > diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
> > > index eabddb7c7820..353c2342fbf1 100644
> > > --- a/drivers/pwm/pwm-sifive.c
> > > +++ b/drivers/pwm/pwm-sifive.c
> > > @@ -101,7 +101,7 @@ static void pwm_sifive_update_clock(struct pwm_si=
five_ddata *ddata,
> > >
> > >       /* As scale <=3D 15 the shift operation cannot overflow. */
> > >       num =3D (unsigned long long)NSEC_PER_SEC << (PWM_SIFIVE_CMPWIDT=
H + scale);
> > > -     ddata->real_period =3D div64_ul(num, rate);
> > > +     ddata->real_period =3D DIV_ROUND_UP_ULL(num, rate);
> >
> > It's unclear to me, why you changed that.
> Because there is a gap in idempotent tests.
> e.g.
> root@unmatched:~# echo 110 >
> /sys/devices/platform/led-controller-1/leds/d12/brightness
> [  706.987712] .apply is not idempotent (ena=3D1 pol=3D0 1739692/4032985)
> -> (ena=3D1 pol=3D0 1739630/4032985)
> root@unmatched:~# echo 120 >
> /sys/devices/platform/led-controller-1/leds/d12/brightness
> [  709.817554] .apply is not idempotent (ena=3D1 pol=3D0 1897846/4032985)
> -> (ena=3D1 pol=3D0 1897784/4032985)
>=20
> Round the result to the nearest whole number. This ensures that
> real_period is always a reasonable integer that is not lower than the
> actual value.
>=20
> After modification, idempotent errors can be avoided.

That's very welcome, however I think this should be a separate change.

I'll think about the rest of your changes when you send a new patch.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--2uooa2ltsa4cbfhk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmWbv4wACgkQj4D7WH0S
/k7eMAgAiRy8wWagjbQMdQFD8bdFQ8EgRz0wMMyWy44lAb0p+sC7KeIaefzAl9je
8cSVn2Lo82Ow0FZoWuF0cfYjYCWqVfXJ4oONYedhbs4AEW0dRvk79FSG4AUdyGpY
msD3CfrGSSEcfGilhKj1IO894popC2K9VbviBlfssNo39tpksIFhBZuW0OMKY8VF
fgezepSwzXsrBbHMWstvwtDH7hvQkgtfgzID+GM1pgdKuQ/kPbE1Zqt0crbkhP9O
p6kCCUDRFHecYHJUN69Io0k//+eE6789vFmvBVkRkdy8XoxIdj7XpxWLEOvHtnIU
C+D/5IyP9Uh8fm46qcCD/n7BLjzI5g==
=eV/P
-----END PGP SIGNATURE-----

--2uooa2ltsa4cbfhk--

