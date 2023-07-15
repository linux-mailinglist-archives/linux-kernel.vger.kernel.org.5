Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67AC2754BB3
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 21:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjGOTXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 15:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjGOTXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 15:23:08 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 171552682
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 12:23:08 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qKkqw-0001V1-85; Sat, 15 Jul 2023 21:22:50 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qKkqu-00Edbx-6K; Sat, 15 Jul 2023 21:22:48 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qKkqt-0058Nn-Ab; Sat, 15 Jul 2023 21:22:47 +0200
Date:   Sat, 15 Jul 2023 21:22:45 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Stanislav Jakubek <stano.jakubek@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: pwm: brcm,kona-pwm: convert to YAML
Message-ID: <20230715192245.kkwqny65vwo446ao@pengutronix.de>
References: <20230618142327.GA20367@standask-GA-A55M-S2HP>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wug6vutjpxwbvcrw"
Content-Disposition: inline
In-Reply-To: <20230618142327.GA20367@standask-GA-A55M-S2HP>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wug6vutjpxwbvcrw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Sun, Jun 18, 2023 at 04:23:27PM +0200, Stanislav Jakubek wrote:
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - brcm,bcm11351-pwm
> +      - const: brcm,kona-pwm

This is not the simplest way to express the currently supported
combination. I assume that's done this way in the expectation that the
set of SoCs with a compatible PWM will grow?

Well, fine for me:

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Thanks!
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--wug6vutjpxwbvcrw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmSy8gQACgkQj4D7WH0S
/k6K9gf+KlfaOq9JFDtz/RODqay66Tw6o5hOMQ2dsFM/EWCYbM48FGMYF1xqATmI
mPnqm9qe4OHm+b2upeTV9C/eEGcL+vnwH5v+jyt3GUyZF9o+YFp9k1RXIpMotKjX
RZFocnyTgyKsQORYaNg2GA+ocl5dzvyjpGylNLJYWOwRppeS2LYxq2kr1jxVS77H
CkVJVrukhEqEXUhWPwyYgg+hI6PQlqMzG7bWRsD5OEEJg8PLTEG7SsK2J9zq/Mwy
u4+5FVEHbP1q+I7iAPkOTAL7Ccu3ho+Fsit1fmlm4ste1EjinzccVV+vI+iBrUE1
CL/5aXkJ/emWM0+AoxiEuyYzNqRNaA==
=7jOe
-----END PGP SIGNATURE-----

--wug6vutjpxwbvcrw--
