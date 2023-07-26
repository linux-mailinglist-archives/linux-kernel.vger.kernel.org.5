Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72658762C2E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 08:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbjGZG67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 02:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbjGZG6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 02:58:31 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1392722
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 23:58:20 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qOYT6-00046l-2t; Wed, 26 Jul 2023 08:57:56 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qOYT4-002Aw1-9J; Wed, 26 Jul 2023 08:57:54 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qOYT3-007reb-J0; Wed, 26 Jul 2023 08:57:53 +0200
Date:   Wed, 26 Jul 2023 08:57:50 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Joel Stanley <joel@jms.id.au>, linux-aspeed@lists.ozlabs.org,
        openbmc@lists.ozlabs.org, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 33/61] mmc: sdhci-of-aspeed: remove unneeded variables
Message-ID: <20230726065750.judvhyyuzcc2zsgu@pengutronix.de>
References: <20230726040041.26267-1-frank.li@vivo.com>
 <20230726040041.26267-33-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yelgoin2bjjhlkyv"
Content-Disposition: inline
In-Reply-To: <20230726040041.26267-33-frank.li@vivo.com>
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


--yelgoin2bjjhlkyv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 26, 2023 at 12:00:13PM +0800, Yangtao Li wrote:
> The variable 'dead' is redundant, let's remove it.
>=20
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--yelgoin2bjjhlkyv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmTAw+0ACgkQj4D7WH0S
/k5v+wf/dYBVwVf2EH5vWE9ipYC2wAo2mozZWtvfJa5VG9dGJUmBG0m6WjPk0k5w
MQGB7LZb3VoXJxpxyU4eE0DVtwTrifgqu5AjkDuOQtYVAl5Y9XmhtQC36cykQzo5
PPTogFKVFLJ50BBbVxehFlLtJQJ/WKdpeX30xTC5bglFOJGEWnAiqeuKelPZxAwh
CbjWeJgGX2G90D6GeyglBRI83K6losaHj/uw36+uGqtZ19IZwpd109dvfCtOGzCA
AJaWR1DoIf7s/g6eAVOWupnlRfAFCZ0H5KGaVP2Xtfh7bFTyEts2w0TT7YTDrKg7
1l/xPlfaWkVBDCqTfoyybWIYF0oRlA==
=tn4P
-----END PGP SIGNATURE-----

--yelgoin2bjjhlkyv--
