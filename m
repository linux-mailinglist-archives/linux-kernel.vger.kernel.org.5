Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32DB9762BDE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 08:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbjGZGri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 02:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbjGZGrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 02:47:36 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E150E1990
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 23:47:35 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qOYJ1-0002sS-0v; Wed, 26 Jul 2023 08:47:31 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qOYIz-002Auo-TH; Wed, 26 Jul 2023 08:47:29 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qOYIz-007ra7-3f; Wed, 26 Jul 2023 08:47:29 +0200
Date:   Wed, 26 Jul 2023 08:47:26 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 16/61] mmc: rtsx_pci: Drop if block with always false
 condition
Message-ID: <20230726064726.e6yfpt44a3yf4sd3@pengutronix.de>
References: <20230726040041.26267-1-frank.li@vivo.com>
 <20230726040041.26267-16-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gztxvgx5brqqel3h"
Content-Disposition: inline
In-Reply-To: <20230726040041.26267-16-frank.li@vivo.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gztxvgx5brqqel3h
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 26, 2023 at 11:59:56AM +0800, Yangtao Li wrote:
> rtsx_pci_sdmmc_drv_remove() is only called for a device after
> rtsx_pci_sdmmc_drv_probe() returned 0. In that case platform_set_drvdata()
> was called with a non-NULL value and so platform_get_drvdata()
> won't return NULL.
>=20
> Cc: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--gztxvgx5brqqel3h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmTAwX0ACgkQj4D7WH0S
/k7WqQgAtYh1/RV7jJB6VdbpsIrL9lXg03+aH6VjUrt52Qnge8rrBPOzS5qBOcru
8C0uHAvR3WVtM3detklGBSNjoBGcR1JxF5RHNcn3n45pLSwcOIUKp38Qg1jF7ah8
Ss7RtaeEOGzmqlEpsL1u28+56H3xagbDBMY9I2+LlOOz2FcuVT21hdSCSsVzLRdF
nqIpNh2kJ5NUsmdjunGo/DiwlDlcy26H7ore4jKRBKhJYUXPiD9VAhCLCpjwDkTB
U1j/19EjgiOhQMD3OCJIU9BSZgc0B54xgtjxmbjo6oy80P5RbhCxFIgqZ6VozHrZ
LiNxVf4/ruU2uwzcOV88KprQ6NoU7A==
=zNah
-----END PGP SIGNATURE-----

--gztxvgx5brqqel3h--
