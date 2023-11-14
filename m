Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE857EAF48
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 12:34:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232598AbjKNLed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 06:34:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232085AbjKNLec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 06:34:32 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B821BE
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 03:34:29 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r2rgI-00066n-9u; Tue, 14 Nov 2023 12:34:10 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r2rgG-008ytE-MN; Tue, 14 Nov 2023 12:34:08 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r2rgG-001K07-Cd; Tue, 14 Nov 2023 12:34:08 +0100
Date:   Tue, 14 Nov 2023 12:34:08 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Devi Priya <quic_devipriy@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        thierry.reding@gmail.com, baruch@tkos.co.il,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH 0/4] Enable pwm support for IPQ5332 & IPQ9574 SoCs
Message-ID: <20231114113408.f7xvbvmhvf256jis@pengutronix.de>
References: <20231006045317.1056625-1-quic_devipriy@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3wbsy6jm65ldlr2s"
Content-Disposition: inline
In-Reply-To: <20231006045317.1056625-1-quic_devipriy@quicinc.com>
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


--3wbsy6jm65ldlr2s
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 06, 2023 at 10:23:13AM +0530, Devi Priya wrote:
> Enable pwm support for IPQ5332 & IPQ9574 SoCs and document the
> pwm compatibles.
> While at it, use qcom,ipq6018-pwm as the fallback compatible and extend t=
he
> simple-mfd support for ipq5332 & ipq9574 targets.
>=20
> This series depends on the below series which adds support
> for the PWM driver on IPQ targets:
> https://lore.kernel.org/linux-arm-msm/20231005160550.2423075-1-quic_devip=
riy@quicinc.com/

Given this dependency, I suggest you add the patches from this series to
the next revision of the IPQ base series.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--3wbsy6jm65ldlr2s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVTWy8ACgkQj4D7WH0S
/k4UvAf7B9DckIZWg1K3ifzsa+9ogP0hip9vJ46qYWw7pn+SwRGNyx/H60eYzD8e
nLc/dCllG6IvI/JyZSDvBcgZZouKSaeheZpEWRyhcXzRTbJrtFId0gGpSr6fJ2Wx
rhMSV6isay4bfhkGilPV3ne/iQeEtUl+hoSFkICK7QW1n0yB9stsgXylOhyZsUq5
DLjIqqGTlTkqUTJqLz/KbEHg71X4XUE8FDIyO/O9DC4joIpXmr9I7g80SZmtRmi7
eFFRkPzlz7gRoRm6tfmoYaCMNK4y/BLKI0ZBjaqhbSSHRe0PAY8nFEc1JqmT2mk0
tUsXZm/AjfZWChyV5t/9b57x6Cg2YQ==
=WCAE
-----END PGP SIGNATURE-----

--3wbsy6jm65ldlr2s--
