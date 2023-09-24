Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A918B7AC70D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 09:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjIXHww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 03:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjIXHwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 03:52:51 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50EA0109;
        Sun, 24 Sep 2023 00:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
 t=1695541918; x=1696146718; i=j.neuschaefer@gmx.net;
 bh=l762rpL78XJX6kJZnEmaPG5CMPXGEcWFqwe5ttBK0r8=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
 b=YpFDgI6h/z+QyCVPCCDi/zKyUeTBlS/nGbSI2K7R99GYwz2fPg1iegitN57/RyxtXCqQLSI/RM5
 kwpBTkRtqLmCwMAhRby29OwfHxllkI0YWYUAJKpC5l4jpqTUKQYQ5uGhMiBtcqTyfswZUEwXuGh1H
 +olWxxZVRZHEExoSX2nZKJgOW1ao5BB0x3zHjHWrhrIKStFLe/9583O/Ibhb3iiquWvqMwomv0RUn
 F4RgVsxPJX51Xs/64s5LdPuVAsN4xZhrZeSZMHVBdD1EGS30PRaQB+bNILyN9Ia27apmZcrSNdQAa
 w+8WSf08umwiLn6NuFDg0yajl3RrXxvFDO5w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([89.0.47.152]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MaJ3t-1rDfAJ29Yb-00WCWT; Sun, 24
 Sep 2023 09:51:58 +0200
Date:   Sun, 24 Sep 2023 09:51:55 +0200
From:   =?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     linux-clk@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Conor Dooley <conor+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>, Arnd Bergmann <arnd@arndb.de>,
        Jacky Huang <ychuang3@nuvoton.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v9 3/3] clk: wpcm450: Add Nuvoton WPCM450 clock/reset
 controller driver
Message-ID: <ZQ/qm2QH0kbz+2Vx@probook>
References: <20230923143438.1895461-1-j.neuschaefer@gmx.net>
 <20230923143438.1895461-4-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pBFYjzjBf1TpgkI2"
Content-Disposition: inline
In-Reply-To: <20230923143438.1895461-4-j.neuschaefer@gmx.net>
X-Provags-ID: V03:K1:UrCyJY5yKXyKetG4NIlBC/9FZ3CNGXjUHb2ZVmhgA1GCm6ilD0x
 IxDyp6S6rVpCvSXbwgO9GrzOBV4sKQ/OAaAi4d57UW1+JkUn+bFtPrtTxwtKlH22rg8YP0N
 vc+GVX+XTmM1BegsDCVctoZKP2iE4YIZdV5j2Plg5K22Pzd2vV2qc0pwvwrZvX63bRNBK+I
 J4AXUWaEv6fDZ0NS4eNnA==
UI-OutboundReport: notjunk:1;M01:P0:8FTVNRtf2kg=;UaoUthIli/bLoGv10ARCskyds6F
 Ykp1XreM4CWzIAbcbGdJZqoaJq+aKfSH5To3wb248/JLJda8zu90HsGGJqzcdTjLlg4v8wc5a
 vjM2Tw8QTNTTWEwCB0lubvDQJK4DcmpSrhiCTr85bjsD0W5NOiPtFE3RpFyAfERyy0Zn4BOXN
 fVWqOBxr7zFRO96M1iTlaC5DDLhsr5bJ4RmbO1FJ9TFpQrpbp5kZrHxRhTLy6gOAvIZVzYLNp
 PIn1bvM8oNqHPjrxCN80SxLKaqdZ+LU1c06oC1B1alApiTVAP8eMzD5//MOTkEcrxWxG2vk7v
 UYxvb4XKGqt9hf9mKKFV4wE/VrH2MGzOFWtOOGRxCP7lvzbs/DGp5E4Fck4ZELSHHpdusljqg
 ENa7k8opDEuNt9R7GIsDH8U1lFN9TK0Qe/JToM1Y5f6cqVEIcrTlLmo+OF6jQOemWrfynWYqB
 9VymakxI1+4cpcLfZ5TghB3Ztd8vjQcevEjLj3er+lkl9CYns2uSPbhsFC9nmsxQant1OmAUZ
 iONnAGoIhb/D5fMIfacelzBSrl8BLpDFA/DAKRJiHd4a4S4WFFVtjVX0rDNTGRIS20ALEyctd
 ZwOSiZqJplTIMBnBv774X3z4s9x9L3CvGOjSDNEimhbmXE2TaRW8odTvq2czuteU+9I/bAY0G
 stO6PuvjwbQjFLsUzskpIUG3kDnNLFP91AE5DHXNRQuuwYMmhbaSlnlItREbkMu5VDLoo4PBo
 kBR1VqIhBG8LQooUPnH1Qc/t/MXEiph1i59aL6tKE6yjvnfFJvdZ+n0LEawFDu7BIi3TLkJSG
 yypBLalJeLKeT/6S/Ono8+BeHmrCDOWIYzMS0A4JdsT0kUVGf2EwpefknMnNxoeNcbBUIKUQK
 ZN9EeaC4fk2tzXlgdNom9+6B68wONyRcaVrYmG2V0/ytx3sijXgrYk82EhbYhZyMQq6LZ1z/B
 b1+hpw==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pBFYjzjBf1TpgkI2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 23, 2023 at 04:34:38PM +0200, Jonathan Neusch=C3=A4fer wrote:
> This driver implements the following features w.r.t. the clock and reset
> controller in the WPCM450 SoC:
>=20
> - It calculates the rates for all clocks managed by the clock controller
> - It leaves the clock tree mostly unchanged, except that it enables/
>   disables clock gates based on usage.
> - It exposes the reset lines managed by the controller using the
>   Generic Reset Controller subsystem
>=20
> NOTE: If the driver and the corresponding devicetree node are present,
>       the driver will disable "unused" clocks. This is problem until
>       the clock relations are properly declared in the devicetree (in a
>       later patch). Until then, the clk_ignore_unused kernel parameter
>       can be used as a workaround.
>=20
> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> ---
[...]
> +config CLK_WPCM450
> +	bool "Nuvoton WPCM450 clock/reset controller support"
> +	default y
> +	help
> +	  Build the clock and reset controller driver for the WPCM450 SoC.
> +
[...]
>  config RESET_SIMPLE
>  	bool "Simple Reset Controller Driver" if COMPILE_TEST || EXPERT
> -	default ARCH_ASPEED || ARCH_BCMBCA || ARCH_BITMAIN || ARCH_REALTEK || A=
RCH_STM32 || (ARCH_INTEL_SOCFPGA && ARM64) || ARCH_SUNXI || ARC
> +	default ARCH_ASPEED || ARCH_BCMBCA || ARCH_BITMAIN || ARCH_REALTEK || A=
RCH_STM32 || (ARCH_INTEL_SOCFPGA && ARM64) || ARCH_SUNXI || ARC || ARCH_WPC=
M450

Considering the build bot failures and the fragility of adding tons of
platforms to this "default" line, I think I'll just select RESET_CONTROLLER
and RESET_SIMPLE from CLK_WPCM450.

Jonathan

--pBFYjzjBf1TpgkI2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmUP6m4ACgkQCDBEmo7z
X9s7NA/+Kb7kcTcnrZ5q9OcEGS0N4Gl5A8Zn58D+GlGntd/3PFbp4EIq+wZJKrrh
eiIuAP6NToGOQbEBfFFBcUU+4qloCorKoQcWeY5rgoBLntU2Lyj9BTk4Mcj3YhH9
Lm11A3S0QJQqkYmbHZD6xgAYKA+oP9bMQJd6gz2y7o8dAiXYGP1uNuRI7c58ArKD
EmBQ3HaGiT2vwxuK0Gg1cc8EsCC1ygaKTf2B5tr/jopZb0sc21fA6cWb++iDVipk
chYyGTroDuUI8ClBOUzAvVDK2/AMps85WPqCndf2WAva6z6BT3EnJp8O6biguSrw
lf/yHeMBeIuHFOfD1ZNdEw7cpH9wQGn4adIuLGjIt10a5Bi9tVIX1eCKIJs1JGn6
AkRFgkw6/SYvEdF1q28x3oxLIsFFy2N1rJ1troUUaNUFTC0pyzC7S96tf/uva3fg
nLb/+X1qO0WSHIQQ9D4C+CuQ//KfRvWflX0cFY7H60MO+LaD0cNc3tmVrJpCb32B
Io/2VV2p0OfuSPaRd8dVgGSHfXpC3ncZOUGnSMGfSyrbLyRlq2VtsRrROD1kqOoW
amLSqiskO9amsmn3IXzbD9Hd/ytUwy4zXpk6R/TaK4X9GMJ1fA0g8sx7CH2KafV4
gunw8+m8zQMM53M/IaymQqYdEIISme1PsyiJA/9Et6bih2IL5sI=
=Dm6m
-----END PGP SIGNATURE-----

--pBFYjzjBf1TpgkI2--
