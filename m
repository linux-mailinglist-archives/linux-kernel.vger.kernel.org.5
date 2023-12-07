Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87C6D808A79
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 15:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjLGO0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 09:26:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443269AbjLGOZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 09:25:35 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8841BE7
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 06:24:58 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1rBFJ0-0005GM-Do; Thu, 07 Dec 2023 15:24:46 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1rBFIz-00EDAG-MS; Thu, 07 Dec 2023 15:24:45 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1rBFIz-00FwBy-DM; Thu, 07 Dec 2023 15:24:45 +0100
Date:   Thu, 7 Dec 2023 15:24:45 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 0/3] w1: gpio: Some cleanup and simplifiction
Message-ID: <20231207142445.rp5or5wvkosyu7ho@pengutronix.de>
References: <cover.1701727212.git.u.kleine-koenig@pengutronix.de>
 <15578a4d-f749-4bf8-b507-4c6efb7805fa@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zphejp4frfwbr6rc"
Content-Disposition: inline
In-Reply-To: <15578a4d-f749-4bf8-b507-4c6efb7805fa@kernel.org>
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


--zphejp4frfwbr6rc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Krzysztof,

On Thu, Dec 07, 2023 at 02:29:34PM +0100, Krzysztof Kozlowski wrote:
> On 04/12/2023 23:05, Uwe Kleine-K=C3=B6nig wrote:
> > Hello,
> >=20
> > v1 is available at
> > https://lore.kernel.org/r/20230525095624.615350-1-u.kleine-koenig@pengu=
tronix.de.
> >=20
> > The changes in this v2 since then are:
> >=20
> >  - Fix a build problem in patch #3
> >  - Rebase to today's next
>=20
>   =E2=9C=97 No key: openpgp/u.kleine-koenig@pengutronix.de
>=20
> Are you sure you exported your key to openpgp and verified addresses?

Works for me:

$ gpg --locate-keys u.kleine-koenig@pengutronix.de
gpg: directory '/home/test/.gnupg' created
gpg: keybox '/home/test/.gnupg/pubring.kbx' created
gpg: /home/test/.gnupg/trustdb.gpg: trustdb created
gpg: key E2DCDD9132669BD6: public key "Uwe Kleine-K=C3=B6nig <u.kleine-koen=
ig@pengutronix.de>" imported
gpg: Total number processed: 1
gpg:               imported: 1
gpg: no ultimately trusted keys found
pub   rsa4096 2010-06-15 [SC] [expires: 2024-06-21]
      0D2511F322BFAB1C1580266BE2DCDD9132669BD6
uid           [ unknown] Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix=
=2Ede>
sub   rsa2048 2023-03-17 [A] [expires: 2025-03-16]
sub   rsa2048 2023-03-17 [S] [expires: 2025-03-16]
sub   rsa2048 2023-03-17 [E] [expires: 2025-03-16]

also https://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git seems to
have the current key since commit 5151fbdbeb53 "Update E2DCDD9132669BD6
(Uwe Kleine-K=C3=B6nig)".

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--zphejp4frfwbr6rc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVx1awACgkQj4D7WH0S
/k5shwf/QPjY0vbw3xiXkut1wHgeR76JD4HVoLS3y6kuyIjMkkKTvyUadGQuODir
9CBJP0WZIVH/guFlifyDKRnQPl1WYdPauWySSSPQVaFOgaIJZANtqH0hWkcI+QG/
M+xIoTWuZOIWma+cHLpBlhNWfzegBrP/VOnIHyEKUQPjDHvdNNdrsYeOXtpEdYN5
haJgyR1gcIHRiCIh+aNgvAVM2TGMPmO4m+yJcnrgZNC5TbM30QcLl9CQjjF7otRN
/f9WVN5eWApaKKVLlteBlwBPeF8WtruB1hizwyvth3TwyQM6NnHoh8i/YZx1y/dc
/VcX+z+50dVw3wNEWnuL+IYm7+JtfQ==
=T7pv
-----END PGP SIGNATURE-----

--zphejp4frfwbr6rc--
