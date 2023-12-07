Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A024C808D24
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 17:22:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232958AbjLGP6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 10:58:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232954AbjLGP6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 10:58:34 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8AFE10F6
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 07:58:38 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1rBGli-0008J7-Q1; Thu, 07 Dec 2023 16:58:30 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1rBGli-00EDrq-6L; Thu, 07 Dec 2023 16:58:30 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1rBGlh-00G0UC-TS; Thu, 07 Dec 2023 16:58:29 +0100
Date:   Thu, 7 Dec 2023 16:58:29 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 0/3] w1: gpio: Some cleanup and simplifiction
Message-ID: <20231207155829.lgj7i3zwdt4qxnmn@pengutronix.de>
References: <cover.1701727212.git.u.kleine-koenig@pengutronix.de>
 <15578a4d-f749-4bf8-b507-4c6efb7805fa@kernel.org>
 <20231207142445.rp5or5wvkosyu7ho@pengutronix.de>
 <e97d54f2-88f3-4c03-9f41-e90df458bb95@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="36qah7d7lag5bls4"
Content-Disposition: inline
In-Reply-To: <e97d54f2-88f3-4c03-9f41-e90df458bb95@kernel.org>
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


--36qah7d7lag5bls4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Krzysztof,

On Thu, Dec 07, 2023 at 03:27:57PM +0100, Krzysztof Kozlowski wrote:
> On 07/12/2023 15:24, Uwe Kleine-K=C3=B6nig wrote:
> > Hello Krzysztof,
> >=20
> > On Thu, Dec 07, 2023 at 02:29:34PM +0100, Krzysztof Kozlowski wrote:
> >> On 04/12/2023 23:05, Uwe Kleine-K=C3=B6nig wrote:
> >>> Hello,
> >>>
> >>> v1 is available at
> >>> https://lore.kernel.org/r/20230525095624.615350-1-u.kleine-koenig@pen=
gutronix.de.
> >>>
> >>> The changes in this v2 since then are:
> >>>
> >>>  - Fix a build problem in patch #3
> >>>  - Rebase to today's next
> >>
> >>   =E2=9C=97 No key: openpgp/u.kleine-koenig@pengutronix.de

I think "openpgp" isn't about the keys.openpgp.org keyserver, but just
the signature algorithm.

> >> Are you sure you exported your key to openpgp and verified addresses?
> >=20
> > Works for me:
> >=20
> > $ gpg --locate-keys u.kleine-koenig@pengutronix.de

FTR: This lookup used WKD, but my key is also on keys.openpgp.org.

> > gpg: directory '/home/test/.gnupg' created
> > gpg: keybox '/home/test/.gnupg/pubring.kbx' created
> > gpg: /home/test/.gnupg/trustdb.gpg: trustdb created
> > gpg: key E2DCDD9132669BD6: public key "Uwe Kleine-K=C3=B6nig <u.kleine-=
koenig@pengutronix.de>" imported
> > gpg: Total number processed: 1
> > gpg:               imported: 1
> > gpg: no ultimately trusted keys found
> > pub   rsa4096 2010-06-15 [SC] [expires: 2024-06-21]
> >       0D2511F322BFAB1C1580266BE2DCDD9132669BD6
> > uid           [ unknown] Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutr=
onix.de>
> > sub   rsa2048 2023-03-17 [A] [expires: 2025-03-16]
> > sub   rsa2048 2023-03-17 [S] [expires: 2025-03-16]
> > sub   rsa2048 2023-03-17 [E] [expires: 2025-03-16]
> >=20
> > also https://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git seems to
> > have the current key since commit 5151fbdbeb53 "Update E2DCDD9132669BD6
> > (Uwe Kleine-K=C3=B6nig)".
>=20
> Huh, I think I misunderstood the message from b4. I thought it is trying
> to get your key from keys.openpgp.org and your key is just not there.
> Are you saying that it was looking only in my local keyring?

I didn't check how the keyhandling is implemented in b4, but I guess it
just calls gpg and leaves it to you to get my key into your keyring.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--36qah7d7lag5bls4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVx66UACgkQj4D7WH0S
/k7szgf/f8r2/+mE/rRiu18GVWDEyod+HeLDm7MXTc4bYWhaNWt5umObX7GrKSez
i7TsD493mR7gIIGSne3VhhZs3fpH4HVqeJd9ZUv1ZDAxatlmFRt7FL+ep5Oi+eIG
1s7EJiVwuu6Z+aCpb0vzD76qFcanF8+dHST08jDfSL2iZ7pHrr5mq9Fc638KiMm8
nraXRCMRWSBjGP6ZK2MmffWkPeK7KMV/sfu+7tvgE/MIok0dSiqCLKmFx/sFezp/
7oU4ZCYg5+s9Nh3l/Fd2KgQdnF3QaW+TltjEMu2cTefiQZY2wr4cAznt0J3dNBjd
O3Xqo6kapgLccGzBn5SoupQkyhpi9A==
=Uaif
-----END PGP SIGNATURE-----

--36qah7d7lag5bls4--
