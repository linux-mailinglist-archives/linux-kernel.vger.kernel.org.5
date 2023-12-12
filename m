Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E316A80EA60
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 12:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbjLLL2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 06:28:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbjLLL2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 06:28:21 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF099D3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 03:28:27 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1rD0w2-0003dl-Gx; Tue, 12 Dec 2023 12:28:22 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1rD0w2-00FKEX-2c; Tue, 12 Dec 2023 12:28:22 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1rD0w1-001axU-Pm; Tue, 12 Dec 2023 12:28:21 +0100
Date:   Tue, 12 Dec 2023 12:28:21 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Sean Young <sean@mess.org>
Cc:     linux-media@vger.kernel.org, linux-pwm@vger.kernel.org,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 3/6] pwm: renesas: Remove unused include
Message-ID: <20231212112821.vbic3mbh56qgna2c@pengutronix.de>
References: <cover.1702369869.git.sean@mess.org>
 <4c135f9cd23592b1646a4151e86ef4ea0321d4ef.1702369869.git.sean@mess.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uykb7rxpafu6virh"
Content-Disposition: inline
In-Reply-To: <4c135f9cd23592b1646a4151e86ef4ea0321d4ef.1702369869.git.sean@mess.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uykb7rxpafu6virh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 08:34:02AM +0000, Sean Young wrote:
> No mutex is used in this driver.
>=20
> Signed-off-by: Sean Young <sean@mess.org>
> ---
>  drivers/pwm/pwm-renesas-tpu.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/pwm/pwm-renesas-tpu.c b/drivers/pwm/pwm-renesas-tpu.c
> index ce92db1f85113..28265fdfc92a9 100644
> --- a/drivers/pwm/pwm-renesas-tpu.c
> +++ b/drivers/pwm/pwm-renesas-tpu.c
> @@ -11,7 +11,6 @@
>  #include <linux/init.h>
>  #include <linux/ioport.h>
>  #include <linux/module.h>
> -#include <linux/mutex.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--uykb7rxpafu6virh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmV4Q9QACgkQj4D7WH0S
/k6T1gf8DYnJ6/LEMypHNG6LNLKj38OsJuhDhfr030e9rnmVIgmz8u9FTU+XzWeV
4qiTZdzx+C1xpG0And36TRlobsRPRbE6WUncrXT2Rlh5hfUdmvXBs3ws9d+1vlB8
qfdfZW3+VYdymk8hJbsxvmun/dgiYIRMs6E2bCDa9q0tPHmciFXjOaVVntfO/maZ
+ic+DXEH7aiIrNCuBQ/OZsLJVTpQZhW8/Ybk5peGTPqAwvNC+0yxwNNlAmn03nya
d+t3aJCJYKM+k5Bt2kwtFs8IpttM98+opKKfU+3AP3FjfYrr3TLIUy0Ikcogpg4i
7tgc56Gfwls/Ie8xdeYvwrzcUrsQqg==
=7adZ
-----END PGP SIGNATURE-----

--uykb7rxpafu6virh--
