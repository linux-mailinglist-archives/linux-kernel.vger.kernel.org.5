Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A27B77B46A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 10:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234822AbjHNImE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 04:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234849AbjHNIlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 04:41:36 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED2612D;
        Mon, 14 Aug 2023 01:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=s31663417; t=1692002431; x=1692607231; i=j.neuschaefer@gmx.net;
 bh=2K/XkJrgpN3vuj+6RdSORsI1BXDQCSMHXV1Szx8sgmk=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
 b=WF5s2Thc7cvYs7GNHS7wJfbaaeZ4iTHsjp3zY4bMtT+mSF6xxMwQcm9C122oY1YUC+aXmF1
 mKl1U0S8qh+XcgrXMR34WGA1zNciM8AKRBXrV1MdMPswvlxMj/pgO1Y+3N8OCSCRimIzZg2GD
 L4NhcMMNqMGfjTcjLoKnVSM1bKfwYCDEcCqeISpHH22jryOolpBJYGjg20qgBBi5IFY3l3xCL
 klMx8phTW2c1gHZFZ93NDNfogOrhf8ydqB43vnsnEO9LfUx9+rZcCh9ybgv4Rieq8PyqSbyEH
 /lPv5VSDsHXfAgvsnolIoKs5O+rn0pqbUJhkbt43G6rgGDZgkd+w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([151.216.154.44]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MS3mt-1qKdSm0XvP-00TYkC; Mon, 14
 Aug 2023 10:40:31 +0200
Date:   Mon, 14 Aug 2023 10:40:24 +0200
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Brad Larson <blarson@amd.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-spi@vger.kernel.org,
        adrian.hunter@intel.com, alcooperx@gmail.com,
        andy.shevchenko@gmail.com, arnd@arndb.de,
        brendan.higgins@linux.dev, briannorris@chromium.org,
        catalin.marinas@arm.com, conor+dt@kernel.org, davidgow@google.com,
        gsomlo@gmail.com, gerg@linux-m68k.org, hal.feng@starfivetech.com,
        hasegawa-hitomi@fujitsu.com, j.neuschaefer@gmx.net, joel@jms.id.au,
        kernel@esmil.dk, krzk@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        lee.jones@linaro.org, broonie@kernel.org, p.zabel@pengutronix.de,
        rdunlap@infradead.org, robh+dt@kernel.org, samuel@sholland.org,
        fancer.lancer@gmail.com, skhan@linuxfoundation.org,
        suravee.suthikulpanit@amd.com, thomas.lendacky@amd.com,
        tonyhuang.sunplus@gmail.com, ulf.hansson@linaro.org,
        vaishnav.a@ti.com, walker.chen@starfivetech.com, will@kernel.org,
        zhuyinbo@loongson.cn, devicetree@vger.kernel.org
Subject: Re: [PATCH v15 4/6] arm64: Add config for AMD Pensando SoC platforms
Message-ID: <ZNnoeAG8MevNTjtV@probook>
References: <20230811180519.29644-1-blarson@amd.com>
 <20230811180519.29644-5-blarson@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XYsAN1UlC/mQ0xME"
Content-Disposition: inline
In-Reply-To: <20230811180519.29644-5-blarson@amd.com>
X-Provags-ID: V03:K1:lwjMjHcgCwopMPNO3RHBqMhBTQVVrX6Y1pvovSF3ruOUwvmVFIr
 8ZOvvrhwjCsc6HqxCKe101L3rmQ4SNB20EkR9qOQqa3VIXZ4iZbgaP5TH/b5bCvdcG2vnV9
 Ux6m+ZmDWudbwKCZ5lyurc3vIqu+Go9R+gXdBNmlJwaQkWlXQVp4iXZuJ5kvPAVZRaRS2TK
 99LtsSfUGwaxfTIOej7Fw==
UI-OutboundReport: notjunk:1;M01:P0:/qYxMKe3OHg=;PaOznS2Z5KXlxz5twqP1LAmE2SI
 MtCcUFvIllQHP0w1Mz+MytTE9pEpibQEyGaQwUzs8vEmdanwYr5hpDNsSlg8Q7Zj5DmvWDAFq
 ehw/mdwibGw4wlt4o7YzJpUbEX9tEb1Y7guWqzpG/65va57axiYRxjg3DqKxndETliO37PUqZ
 QR3stsumcFxnttJW4Z4/BKjMHMoMFTvfO0fMPMLSY5aflPvDRxvJFB4Exs7jpg4YBbiUxM4XR
 192r5zaPMoAdRcowuciR6vaT/ToQhf+BjNYGJD/GayxBitptERDXlAu0WXHhljASBw/ZcQ35x
 tbpCL7BVcd1Yyk7qNLMmMcEHS49Y0JiwPh8XsctLqE59/FqbyNxRsZg0w9n+bf0+5jKIJ+SG7
 0LYladW1HoZvSUGppc1ZXM/L8y1JUlU5/Vs1AvGoUgLKmyDy5UBNnHIyKCU1pJucrQ9d7tEK4
 SYHQIgPrNUZsBb+Oz6bqq4kFcauVevb9Itmw4ot6i13Yb0rf+GCgvpQ3jeA1beH5wykYtAOAX
 mGOiozNIGqAbUdl/XjaHTEKOHv0bFU/hUBCKXc2q0pKDRikAGqHpBkXKiH4MTQVUHbh1RnByl
 L+pdyoWiIF4wmol0sM5ahhYoygsu58jfbx1YCfXFOjqn/8Xx//XrBgUWqXTFg6WkIKUBSP146
 e1qR4olUUeizlS+qCIYKxW1ie8Y0jmAX3AFLhDGH42c0bFod7qbZGKrBIvqQsET3/AkbQuERq
 1/Qx2A9qKYbLdU2YWe5Ftjmr1peWtZSf62YR7Y55yzXrLqzUFodSTyndd/ewHOJGIU30W0p/v
 grcGphBY6qYDl7RRqYyGNaz8aUbSq6QOIJ5OAP4kv408/c0iddVqm9NkSgJW0jf3HERqBMlYG
 pWr31rNTWgONMgHMT4NaJrCWb73Ic1mo/QTd5fxQiA2pQTadlzik5KpaAhZNwEt1LNd3zRDDW
 ow7ydA==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XYsAN1UlC/mQ0xME
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 11, 2023 at 11:05:17AM -0700, Brad Larson wrote:
> Add ARCH_PENSANDO configuration option for AMD Pensando SoC
> based platforms.
>=20
> Signed-off-by: Brad Larson <blarson@amd.com>
> ---
[...]
> +config ARCH_PENSANDO
> +	bool "AMD Pensando Platforms"
> +	help
> +	  This enables support for the ARMv8 based AMD Pensando SoC
> +	  family to include the Elba SoC.
> +
> +	  AMD Pensando SoCs support a range of Distributed Services
> +	  Cards in PCIe format installed into servers.  The Elba
> +	  SoC includes 16 A-72 CPU cores, 144 programmable P4
> +	  cores for a minimal latency/jitter datapath, and network

Out of curiosity, what are A-72 and P4?

A-72 sounds like Arm Cortex A-72, P4 seems to refer to the P4
programming language (https://opennetworking.org/p4/).

Perhaps something like:

+	  Cards in PCIe format installed into servers.  The Elba
+	  SoC includes 16 Cortex A-72 CPU cores, 144 P4-programmable
+	  cores for a minimal latency/jitter datapath, and network


Best regards,
Jonathan

--XYsAN1UlC/mQ0xME
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmTZ6FAACgkQCDBEmo7z
X9sKFhAAmdVFgdeCmbbPCdJBBh7ERbEnmD9Rno2fvPOgRXkpxsqfIYdArVSs9wZk
t5g50oR3atllgAwMgB8RJTuWOJ0vJEvi5mMSlWyH/MmyFMRRSTvGj6SW6YzZN7cK
gN221BWvCXiTMWhWoeNmKEAlCLJdhmuLcZEJFfxWDLEs9sKNVfuL0lIQ2gKNkfar
JqEo+4AuioCApIbvl5ICQVYQTxkrjLIc+mkVAzsSY2CiznkPGJbewvEtO0IZ5p/0
wA4A1bdzS/Pzc0+EPPnOva4tPIq834OXvpxbZrAuwTI0TnwpN5Tnonwtkpkq4UFB
qYBfpq73lshpboICe63vGiSTD4SmOWmwgx5xQVuWmIjMT1/JC9rQGGbXPUmF68/t
l8E33x1VqL8duagQTnSohmP5XSpYHM2EYLlezaeDYkl57+NHg+reCuMwqeqtdiHK
iWYQfV+teJXhHJVwUjzA6SEYB+gHifpB0wfNydzMr2dCmC7/yLIyA+0tgCxE1f/1
cxLYAX4+oUIwTc0dw2JQScSN/oCNRH+PXSmfFEfpLlfQCLQXJtdgVVCY84DMiN6I
n3tajQ1oHp3qeMQ3y13ek418dUDjLDjufdulmKFdgeC5tDgagXzPUPeYxEY4JhX5
0k0MKwKIxo4VT5L3Tg3f5O6OCTpdQWB2SL/G3xBtKF3JPzAp0Bc=
=MOKU
-----END PGP SIGNATURE-----

--XYsAN1UlC/mQ0xME--
