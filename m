Return-Path: <linux-kernel+bounces-25214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A64782CA84
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 09:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D6211C2241C
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 08:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B69817E8;
	Sat, 13 Jan 2024 08:36:39 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E961110
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 08:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rOZV4-0001Dg-GF; Sat, 13 Jan 2024 09:36:18 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rOZV1-002KTB-EC; Sat, 13 Jan 2024 09:36:15 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rOZV1-008mAD-19;
	Sat, 13 Jan 2024 09:36:15 +0100
Date: Sat, 13 Jan 2024 09:36:12 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Sean Young <sean@mess.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, linux-pwm@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] pwm: bcm2835: Remove duplicate call to
 clk_rate_exclusive_put()
Message-ID: <2nropn2obzpwedkbm5vtgdgvhjg26jici4wxawvn2xmk2cypzy@z7h54tcqurte>
References: <20231222131312.174491-1-sean@mess.org>
 <sbcslehlbdhjggyb4thughrzuzjrbc3knbh3ulfhhi6mcrvayd@rbheyjouom6d>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dw56ztajnxfvlpqz"
Content-Disposition: inline
In-Reply-To: <sbcslehlbdhjggyb4thughrzuzjrbc3knbh3ulfhhi6mcrvayd@rbheyjouom6d>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--dw56ztajnxfvlpqz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Jan 03, 2024 at 01:28:25PM +0100, Uwe Kleine-K=F6nig wrote:
> this patch should be added to your for-next branch and then your PR for
> the next merge window.

This was missed for the pwm/for-6.8-rc1 PR. I added it to my for-next
branch at
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next
now with the intention to send it for inclusion in 6.8-rc after being in
next for a few days.

> Also "pwm: linux/pwm.h: fix Excess kernel-doc description warning"
> (Message-Id: 20231223050621.13994-1-rdunlap@infradead.org) should be
> added IMHO.

This one was already cared for.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--dw56ztajnxfvlpqz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmWiS3sACgkQj4D7WH0S
/k404gf9ErhEB0EJr7iIV3AKWiF/4ExmJVwTk4lujHFh1ZKePPvpgNWoz4m4iXwc
Nfd0bW2dHZmjPoFd5sogsotaIyHqw6IvUZx65HOxVSPNEuFThfjYeQLqsTWYU3Gs
2rp+MT9a3Sw7hMDgJxL+vCjaazfXEB6gUl4abDpNzHKTIJAh9s6kChBUoEgv978p
/kpHlkoyE3KSfx/BCMLHMONbPtBm/qamCxNbEdaOjv4lM7tACOl1VnJzzziAJrHL
vMvnrUlbHtlJjXsEU2giXIqGbEQc1IUwXo3OnS53uXYKaaNlTVbFXWPMORz6FyTv
WIATKyy6iRMhjbPCWKaAJ2P2yUNYYw==
=8z34
-----END PGP SIGNATURE-----

--dw56ztajnxfvlpqz--

