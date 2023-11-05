Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05F617E13EA
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 15:32:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjKEObz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 09:31:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKEOby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 09:31:54 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9668C0
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 06:31:50 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qzeAG-0007ip-Eq; Sun, 05 Nov 2023 15:31:48 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qzeAE-006oO5-L5; Sun, 05 Nov 2023 15:31:46 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qzeAE-00DBmr-Bx; Sun, 05 Nov 2023 15:31:46 +0100
Date:   Sun, 5 Nov 2023 15:31:46 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 1/2] bus: fsl-mc:  Drop if block with always false
 condition
Message-ID: <20231105143146.j5t7viojjtsnydwi@pengutronix.de>
References: <20231103230001.3652259-3-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2mcjuqra2rrmp3sh"
Content-Disposition: inline
In-Reply-To: <20231103230001.3652259-3-u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2mcjuqra2rrmp3sh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

I just noticed a double space in the Subject line. Feel free to replace
it by a single one when applying. (I assume I shouldn't resend just for
that, tell me if you prefer that though.)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--2mcjuqra2rrmp3sh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVHp1EACgkQj4D7WH0S
/k5Jwgf+PmAN+u04EXey9qi+Cw17qe1elpIuMbEK1fD2SAKgayf6igQi0TnzyM5f
qVJkB8kY21o6CZriS5fLvrWo+qYSkWmwizrsfyteQBEgy8KNp2nITG0O0FTBC8AO
nQIjZAWvqyiY0T7Dr0ucND99hpLEphRHmlzJHcPgFroW8B4gHM51ViV/cQNBTXia
IV/puUeXRJupAFrTjejDWAvhERxhtAu7fgnGw1JC6jB4l7edqPCaaCJvVlqqSZ3X
DWpEUQVvQ51bR7RB+H/PqXtfBSEn/T2mFIWQ7hl2Iofw0HSLtfdJH/VZVvM1ymxN
w/PPoQX+hVaMXGHq7WDXkVDZNw06uQ==
=FLYE
-----END PGP SIGNATURE-----

--2mcjuqra2rrmp3sh--
