Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 655AA80B4D6
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 15:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbjLIOFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 09:05:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjLIOFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 09:05:15 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9A810EA
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 06:05:21 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1rBxxB-0002d9-IX; Sat, 09 Dec 2023 15:05:13 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1rBxxA-00Eefm-G8; Sat, 09 Dec 2023 15:05:12 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1rBxxA-00H5gt-6L; Sat, 09 Dec 2023 15:05:12 +0100
Date:   Sat, 9 Dec 2023 15:05:12 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
        Arnd Bergmann <arnd@arndb.de>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Kalle Valo <kvalo@kernel.org>, Lee Jones <lee@kernel.org>,
        linux-kernel@vger.kernel.org,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Paolo Abeni <pabeni@redhat.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Mack <daniel@zonque.org>
Subject: Re: [PATCH 0/7] pcmcia: Convert to platform remove callback
 returning void
Message-ID: <20231209140512.b62vkdufmvdxzghg@pengutronix.de>
References: <cover.1702051073.git.u.kleine-koenig@pengutronix.de>
 <ZXNsLJfqs9DLHb1Q@shine.dominikbrodowski.net>
 <2023120930-possum-ignore-e8df@gregkh>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ncb3s75oufbunhyn"
Content-Disposition: inline
In-Reply-To: <2023120930-possum-ignore-e8df@gregkh>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ncb3s75oufbunhyn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Sat, Dec 09, 2023 at 10:28:36AM +0100, Greg Kroah-Hartman wrote:
> On Fri, Dec 08, 2023 at 08:19:08PM +0100, Dominik Brodowski wrote:
> > Both options are fine with me. In the latter case:
> >=20
> > 	Acked-by: Dominik Brodowski <linux@dominikbrodowski.net>
>=20
> I can take these, thanks!

I missed Greg's reply when I just suggested that Dominik should take
these. Either way is fine for me.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ncb3s75oufbunhyn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmV0dBcACgkQj4D7WH0S
/k6kEgf/UWLuW9FsJfRAd3++UNxjQ8RFTaUySsmwvl4gBItV7iiLyD7Lko43eVNF
WzC1Zo2A/kuMewie3V0z38ZwDaUvhK8kXVAuSV84MP6Q8iHXijQhslEOXmXF7XPu
BK2vl0U74tVcjY7hLieZpIm7Yw4wq5vt08uYRaX41RbAO2vZcb9PEc+56++altQF
Sh0Lm7IFX3BE36hUNrO44uZjLAvqp+YklNGF44AiEiejzMDcS9sSZ6JYPVTZ5GPc
4eJR5zl/68SOQNNkpLPFw6npS2Vp/fhu13ul7Z3ZTYsVlvUOPPc4raskPxErOD/X
Km1rAs/XcTuzVgKigmGRFRT8O9WjaQ==
=OWvG
-----END PGP SIGNATURE-----

--ncb3s75oufbunhyn--
