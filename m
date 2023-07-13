Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C42C6751CD9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 11:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234145AbjGMJLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 05:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234123AbjGMJKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 05:10:39 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED5130EE
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 02:10:12 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qJsKn-0005YE-Nd; Thu, 13 Jul 2023 11:10:01 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qJsKm-00E5JE-DT; Thu, 13 Jul 2023 11:10:00 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qJsKl-004WHV-Kp; Thu, 13 Jul 2023 11:09:59 +0200
Date:   Thu, 13 Jul 2023 11:09:59 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 25/58]  mmc: uniphier-sd: Convert to platform remove
 callback returning void
Message-ID: <20230713090959.6ywgj2mlzc6t6eao@pengutronix.de>
References: <20230713080807.69999-1-frank.li@vivo.com>
 <20230713080807.69999-25-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yymy3xuhfnllk6sk"
Content-Disposition: inline
In-Reply-To: <20230713080807.69999-25-frank.li@vivo.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yymy3xuhfnllk6sk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

$Subject ~=3D s/  / /

(maybe that's fixed automatically if picked up by git-am, but I'm not
sure and didn't test.)

Otherwise looks fine.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--yymy3xuhfnllk6sk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmSvv2YACgkQj4D7WH0S
/k5gSgf/X0zfkLbvESAkKz65/res1tIZ4SuvObKqsdfiVSqsWDhMvYMgHFJwcqc5
VZkTRs8BjGAwVh1bUGajL+Vzw52YG5iY1sN7pZO851tlnbPaK4rLM73jbIpZVqzl
TOe9QGOe8SVScIcjgGCHGYtgklp3gN/wRH43iQ4kCs+50QZa4AYukQwlLHdRHLFZ
lFTc1QV7VM5Q6++zXHCQAeEIts89yAawmk2iNcs2dys+Y1b1LTFqmDbKOlvCVCJ0
/ijlMJaEAbrzRfzLoBgjQHMWfBC7W4ueDy/dG9xKt1jGrqThATqHIZ+Anln73aSl
wGh02C7ZD9QShq5k+ViCSUIgKc818A==
=qzjz
-----END PGP SIGNATURE-----

--yymy3xuhfnllk6sk--
