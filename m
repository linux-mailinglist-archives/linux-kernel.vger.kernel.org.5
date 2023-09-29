Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA2A7B2C21
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 08:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232585AbjI2GB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 02:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjI2GBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 02:01:23 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF951A5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 23:01:21 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qm6Yu-00056R-GL; Fri, 29 Sep 2023 08:01:16 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qm6Yt-009kA5-25; Fri, 29 Sep 2023 08:01:15 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qm6Ys-005pya-PG; Fri, 29 Sep 2023 08:01:14 +0200
Date:   Fri, 29 Sep 2023 08:01:14 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Florian Fainelli <florian.fainelli@broadcom.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     kernel@pengutronix.de, soc@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Fix Florian Fainelli's email address
Message-ID: <20230929060114.zbex7z4atuzojs45@pengutronix.de>
References: <20230928070652.2290946-1-u.kleine-koenig@pengutronix.de>
 <a5aadd2b-6c88-4a7e-a0e5-580dfe604c68@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="buaieoofig252hiw"
Content-Disposition: inline
In-Reply-To: <a5aadd2b-6c88-4a7e-a0e5-580dfe604c68@broadcom.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--buaieoofig252hiw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Sep 28, 2023 at 11:21:50PM +0200, Florian Fainelli wrote:
> On 9/28/2023 9:06 AM, Uwe Kleine-K=F6nig wrote:
> > Commit 31345a0f5901 ("MAINTAINERS: Replace my email address") added 13
> > instances of ...@broadcom.com and one of only ...@broadcom. I didn't
> > double check if Broadcom really owns that TLD, but git send-email
> > doesn't accept it, so add ".com" to that one bogous(?) instance.
> >=20
> > Fixes: 31345a0f5901 ("MAINTAINERS: Replace my email address")
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
>=20
> Embarrassing, thanks for fixing this Uwe!
>=20
> Acked-by: Florian Fainelli <florian.fainelli@broadcom.com>

Who picks this up? 31345a0f5901 went in via arm-soc. Arnd, will you?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--buaieoofig252hiw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmUWaCkACgkQj4D7WH0S
/k5N9gf9FkIV2dZeRVasQHHxxUFvxnaqnNXX29fBo2bDLXQ1Jpn01s+0YpRBaq2m
rF1ax4Gn1bZVjpq1El3Z4IAn+VR4oRgJtde/+6w3r//9Lz30tzNl3VG3L8sJZIhK
YQotJ1nxMJ6oosnIi6sw3WgUaactU4+4s3acjvYcMBQRu6T7hV9zG/sEEPYJiDgt
M4jzZCDhrvWA3TcHHARAznNthMhX0irb29NNyavwYTXiBwcJtK+NzhFJoEaeqDWG
lEmMIZQFX41FW7IF7Di3S+qQ4O6nNTPtTTH0j7xi6eGsu5lGqVgkvIkg4AqUA6r/
FcYjwQUNpMI79dd6xBl10cJL2my8bA==
=uhmd
-----END PGP SIGNATURE-----

--buaieoofig252hiw--
