Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2A880053D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 09:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjLAIPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 03:15:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjLAIPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 03:15:33 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA9910FF;
        Fri,  1 Dec 2023 00:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1701418537; x=1732954537;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bw+d6DVoFBhYwlcfEXxwrFXPCJ47jz00O2lp5sLdxQU=;
  b=EHqjH+3eU12jJ4vVTvSzUgnI10Nak6MLOC6ghYyM8/I8zFhzaue5cnmz
   4aqy5quVnkeJSO+7gmSWNN63iCTX9PmX7uPJU2JzXP1kGqjK1FSaP3OYi
   2axSlXET3J6E28dtH2sDA2p1KocBznxTPKZLSVHJwgABGkMlVYm9/rwMK
   ZhfX3PA8a/fJDcAOJ1u8QqpFwYXC5LHYaW+qldH+mkwHHVFE7N9IbC9RB
   nm2NNDH4MRcskAIZ4/fq7pq5MC9VX/ZWluncrx6RTJO+PP+BeAKUQZu7z
   wwMf78hwJ60iK8hWzxQSNvrchxEntmjVyGJ8ZZyN9mkXG6YCjs9X5J9xV
   w==;
X-CSE-ConnectionGUID: 8NWGosepROaemE1JvcyAxg==
X-CSE-MsgGUID: 6cv+BFDoStSadV0BuZ6SGA==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.04,241,1695711600"; 
   d="asc'?scan'208";a="179731420"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Dec 2023 01:15:36 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 1 Dec 2023 01:15:07 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Fri, 1 Dec 2023 01:15:03 -0700
Date:   Fri, 1 Dec 2023 08:14:34 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Inochi Amaoto <inochiama@outlook.com>
CC:     Conor Dooley <conor@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Chao Wei <chao.wei@sophgo.com>,
        Chen Wang <unicorn_wang@outlook.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Anup Patel <anup@brainfault.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v4 0/7] Add Huashan Pi board support
Message-ID: <20231201-strung-mandarin-110a322468c9@wendy>
References: <20231201-nullify-overhand-9fb99d0752ad@spud>
 <IA1PR20MB4953FCB8B9BA4F2910B25C66BB81A@IA1PR20MB4953.namprd20.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3d/9vWDbStkm+ob+"
Content-Disposition: inline
In-Reply-To: <IA1PR20MB4953FCB8B9BA4F2910B25C66BB81A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--3d/9vWDbStkm+ob+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 01, 2023 at 09:02:59AM +0800, Inochi Amaoto wrote:
> >
> >On Fri, Dec 01, 2023 at 07:21:29AM +0800, Inochi Amaoto wrote:
> >>>
> >>> On Thu, 19 Oct 2023 07:18:00 +0800, Inochi Amaoto wrote:
> >>>> Huashan Pi board is an embedded development platform based on the
> >>>> CV1812H chip. Add minimal device tree files for this board.
> >>>> Currently, it can boot to a basic shell.
> >>>>
> >>>> NOTE: this series is based on the Jisheng's Milk-V Duo patch.
> >>>>
> >>>> Link: https://en.sophgo.com/product/introduce/huashan.html
> >>>> Link: https://en.sophgo.com/product/introduce/cv181xH.html
> >>>> Link: https://lore.kernel.org/linux-riscv/20231006121449.721-1-jszha=
ng@kernel.org/
> >>>>
> >>>> [...]
> >>>
> >>> Applied to riscv-dt-for-next, thanks! LMK if something looks not as
> >>> expected.
> >>>
> >>> [1/7] dt-bindings: interrupt-controller: Add SOPHGO CV1812H plic
> >>>      https://git.kernel.org/conor/c/21a34e63afcc
> >>> [2/7] dt-bindings: timer: Add SOPHGO CV1812H clint
> >>>      https://git.kernel.org/conor/c/06ea2a1968a9
> >>> [3/7] dt-bindings: riscv: Add SOPHGO Huashan Pi board compatibles
> >>>      https://git.kernel.org/conor/c/d7b92027834e
> >>> [4/7] riscv: dts: sophgo: Separate compatible specific for CV1800B soc
> >>>      https://git.kernel.org/conor/c/5b5dce3951b2
> >>> [5/7] riscv: dts: sophgo: cv18xx: Add gpio devices
> >>>      https://git.kernel.org/conor/c/dd791b45c866
> >>> [6/7] riscv: dts: sophgo: add initial CV1812H SoC device tree
> >>>      https://git.kernel.org/conor/c/681ec684a741
> >>> [7/7] riscv: dts: sophgo: add Huashan Pi board device tree
> >>>      https://git.kernel.org/conor/c/2c36b0cfb408

> >> Thanks for the confirmation. But I suggest to revert these patches.
> >> Several days ago, Sophgo informed me that CV1810 series will be
> >> renamed. And the Huashan Pi will switch to the chip with new name.
> >> To avoid unnecessary conflict, please drop these patch and I will
> >> prepare a new patch once the renamed chip is launched.
> >
> >This is a board that exists, that you (and possibly others) have, right?
> >
>=20
> Yes, of course.

I dunno then. It sounds from your message that this is purely a rebrand
of the SoCs, so since people already have these boards, I'd rather not.
We should be able to support both since it's just a naming change,
right?

--3d/9vWDbStkm+ob+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZWmV5QAKCRB4tDGHoIJi
0vcFAQDgeICmWjiy8Yc/NGfhgrWHTLbA5RI4Wt+75lTYul+c+wEA0R20dynPdgEB
58MAnospqjCPP2YBN5PeK/vwMVpNGQw=
=SEje
-----END PGP SIGNATURE-----

--3d/9vWDbStkm+ob+--
