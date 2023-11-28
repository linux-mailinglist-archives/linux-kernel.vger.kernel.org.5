Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE76C7FC2AA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjK1RDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 12:03:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjK1RDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 12:03:07 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1791810DF
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 09:03:14 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r81UN-00088P-SA; Tue, 28 Nov 2023 18:03:11 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r81UN-00CDgW-8l; Tue, 28 Nov 2023 18:03:11 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r81UM-00AHpR-Vz; Tue, 28 Nov 2023 18:03:11 +0100
Date:   Tue, 28 Nov 2023 18:03:10 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 1/2] bus: fsl-mc:  Drop if block with always false
 condition
Message-ID: <20231128170310.s3qdydr6zde5dapa@pengutronix.de>
References: <20231103230001.3652259-3-u.kleine-koenig@pengutronix.de>
 <20231105143146.j5t7viojjtsnydwi@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2f2r57upvouufzms"
Content-Disposition: inline
In-Reply-To: <20231105143146.j5t7viojjtsnydwi@pengutronix.de>
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


--2f2r57upvouufzms
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Sun, Nov 05, 2023 at 03:31:46PM +0100, Uwe Kleine-K=F6nig wrote:
> I just noticed a double space in the Subject line. Feel free to replace
> it by a single one when applying. (I assume I shouldn't resend just for
> that, tell me if you prefer that though.)

Gentle ping. Is this patch set still waiting for review in someone's
mailbox, or did it fell through the cracks already?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--2f2r57upvouufzms
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVmHU4ACgkQj4D7WH0S
/k6gDwf/UtzBxGMu6ekZTPjFBl2CoLdIB/aJCw1CZAWKP+DZX5kKFYXMdVxkroeS
wIFQ/xsuEfcnkcMchtmAoAJyux+uJscWG8yrb1ie5eUPdLWkv71xmzLxkqK6te4D
VwX2/tOi7n+T0Jet/2qCni0IUJIC6LOaRR68iTZU6BNs//R6+RIvgzZak3xoS1/B
CZ5Y4O+q7m/+LKAkNJEt4b5OdRVDbICiCeTHyd3mHvHdJpDdYoygIjXDntbIo739
N5eHXU6zEkOagsPlrBv6HamhHKbjSrrtiqVg3ot3Hm0LCPZJ6f2VuXi41/K0b+wc
z0f2EEYuFl1Y5pyGmL9Bdn9pNpqo9Q==
=9w/h
-----END PGP SIGNATURE-----

--2f2r57upvouufzms--
