Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F26E803B28
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 18:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbjLDRKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 12:10:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjLDRKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 12:10:17 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E223C1
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 09:10:22 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1rACSZ-0007ft-H1; Mon, 04 Dec 2023 18:10:19 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1rACSY-00DZD4-75; Mon, 04 Dec 2023 18:10:18 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1rACSX-00EBFd-UI; Mon, 04 Dec 2023 18:10:17 +0100
Date:   Mon, 4 Dec 2023 18:10:17 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/2] bus: fsl-mc:  Drop if block with always false
 condition
Message-ID: <20231204171017.j5zznavijoqfvfhz@pengutronix.de>
References: <20231103230001.3652259-3-u.kleine-koenig@pengutronix.de>
 <20231105143146.j5t7viojjtsnydwi@pengutronix.de>
 <20231128170310.s3qdydr6zde5dapa@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="k3vbssqcajetu73k"
Content-Disposition: inline
In-Reply-To: <20231128170310.s3qdydr6zde5dapa@pengutronix.de>
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


--k3vbssqcajetu73k
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Nov 28, 2023 at 06:03:10PM +0100, Uwe Kleine-K=F6nig wrote:
> On Sun, Nov 05, 2023 at 03:31:46PM +0100, Uwe Kleine-K=F6nig wrote:
> > I just noticed a double space in the Subject line. Feel free to replace
> > it by a single one when applying. (I assume I shouldn't resend just for
> > that, tell me if you prefer that though.)
>=20
> Gentle ping. Is this patch set still waiting for review in someone's
> mailbox, or did it fell through the cracks already?

For the record: These two patches are included in a pull request to Arnd
(https://lore.kernel.org/all/20231128174927.m46dgp4juig2omci@pengutronix.de=
/)
for all of drivers/bus.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--k3vbssqcajetu73k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVuB/kACgkQj4D7WH0S
/k7U3Qf/WiGjAFCPQAc9eP4Uc+lB8HFZXNI+u3XOmvSzvj564vvNFDfXUfVYakP0
KXUPfSNk+1nTr1EWF5uBBOrQBOyOja7DMgLDIW35UmR8ZTGcmwyAtke9iTI7BpmM
A2hfcogKeUV/Yls+gd4oBWb7/kq1jrHoniK9d89mDQUt4GSbjueH307sTi3H+XS7
liLy58+qZPKaClp+7BLyPmDlVF4WYjYSRKpOj7eNbZc6uaNJitCWANDJt7+p5qTK
GjHxwajSbSeX1Bla33RrjRxX2maW16aYvoG6FY+205dpd61ZzFDeQfSfGCvdCwR5
xi+jUqPH1XuibJyenrU3VIWi4X5Gjw==
=PyxJ
-----END PGP SIGNATURE-----

--k3vbssqcajetu73k--
