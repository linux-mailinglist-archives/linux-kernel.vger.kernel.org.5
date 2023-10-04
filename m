Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 171777B81A0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 16:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242729AbjJDODJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 10:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242645AbjJDODI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 10:03:08 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F58A1
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 07:03:05 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qo2Si-0007mV-CC; Wed, 04 Oct 2023 16:02:52 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qo2Sh-00B3H0-R7; Wed, 04 Oct 2023 16:02:51 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qo2Sh-0090zY-Hq; Wed, 04 Oct 2023 16:02:51 +0200
Date:   Wed, 4 Oct 2023 16:02:51 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 1/2] dt-bindings: pwm: Add T-HEAD PWM controller
Message-ID: <20231004140251.smwazlizo5nmpz2a@pengutronix.de>
References: <20231004092731.1362-1-jszhang@kernel.org>
 <20231004092731.1362-2-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yyfa3baivxpuqfl7"
Content-Disposition: inline
In-Reply-To: <20231004092731.1362-2-jszhang@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yyfa3baivxpuqfl7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Oct 04, 2023 at 05:27:30PM +0800, Jisheng Zhang wrote:
> +  "#pwm-cells":
> +    const: 2

Please make this a 3.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--yyfa3baivxpuqfl7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmUdcIUACgkQj4D7WH0S
/k4h8Qf+Ia6dnze4AFsN9pYFc9wi8+dnrkfW8vPHngsUX7UMRjp24RuetCeLpPNf
zdAp8DHO10gQMncXwM/JXMlLg+OC7PJ3YhdFLq6HZbLrvwO0sOITHr5q087tpaRN
h27NkHMGILH3rYFSqni0nRxNCH+gwbrZ8OpAyCO1XjwtCYWTBpp/E+V+VZAxQUyd
Q8j2aoCE9p4+vJvCYoUomWm9S3b0UT/6Odw/mAbrghFXaTx+8YUDznQPuQx+pBQB
H4ZFpmHmkTJ42/cU6Q2yGxwmjkmhWyPfusUesmbOpV9QKj7aGuFXBE5N6PZ2Uu3I
KaxuEG8+CwEWzxuQDssUrTrXf8JGpQ==
=2coh
-----END PGP SIGNATURE-----

--yyfa3baivxpuqfl7--
