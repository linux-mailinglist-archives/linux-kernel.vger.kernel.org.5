Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 245837A172F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 09:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbjIOHWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 03:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232263AbjIOHWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 03:22:01 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0F4E0;
        Fri, 15 Sep 2023 00:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1694762512; x=1726298512;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=M4MdyYvS188dmohfyr3Ng6SXGiimV/7aAt2AMiSOjC0=;
  b=vg2V5pHV6MAgsCJ1zi1Y7Q3HGMyrCPnJsNceYu9m+2nD//CERESmd0/C
   4CyssiMQhnmhHBiE0l9H39Xb2thdVW0BhT8HMshJ1KlEt3BGRlqP2YEwk
   urrwLlRgfuVVttMM9/69Rl7J0KR2x2e6LXRZBx/TVFujSdHtAAvrBH6Iz
   4n6v3KkT+GnC3bsgXAYNVZzQEDau0IECnD3q2rKsH5a+aK4LxzX7QT3H7
   FPRiwgHcvhoRzDh/FwgG1U1V5yKGj9HK0yMh/J5O77VHkixIQZ/yYdjmR
   z3blDWYCdiCt/X22CPTYC5K1m6sP0Q5vFGItitbvFDy42jtrc3SWnnzur
   Q==;
X-CSE-ConnectionGUID: qjf/CPgLSIiOkW0KeB76sA==
X-CSE-MsgGUID: vmFXfJT0Q7+3bnF21wV70g==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.02,148,1688454000"; 
   d="asc'?scan'208";a="4992792"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Sep 2023 00:21:51 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 15 Sep 2023 00:21:38 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex03.mchp-main.com (10.10.85.151)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Fri, 15 Sep 2023 00:21:35 -0700
Date:   Fri, 15 Sep 2023 08:21:19 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Wang Chen <unicornxw@gmail.com>
CC:     <linux-riscv@lists.infradead.org>, <conor@kernel.org>,
        <aou@eecs.berkeley.edu>, <krzysztof.kozlowski+dt@linaro.org>,
        <palmer@dabbelt.com>, <paul.walmsley@sifive.com>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jszhang@kernel.org>,
        <guoren@kernel.org>, <chao.wei@sophgo.com>,
        <xiaoguang.xing@sophgo.com>, Wang Chen <wangchen20@iscas.ac.cn>
Subject: Re: [PATCH 01/12] riscv: Add SOPHGO SOC family Kconfig support
Message-ID: <20230915-groovy-fragile-8c3a3a7b038e@wendy>
References: <20230915071005.117575-1-wangchen20@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ENGkoMse754EbNpY"
Content-Disposition: inline
In-Reply-To: <20230915071005.117575-1-wangchen20@iscas.ac.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--ENGkoMse754EbNpY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Yo,

On Fri, Sep 15, 2023 at 03:10:05PM +0800, Wang Chen wrote:
> From: "xiaoguang.xing" <xiaoguang.xing@sophgo.com>

This needs to be a name, not the contents of their email address.
Probably just needs the . swapped for a space?

> The first SoC in the SOPHGO series is SG2042, which contains 64 RISC-V
> cores.
>=20
> Signed-off-by: xiaoguang.xing <xiaoguang.xing@sophgo.com>
> Signed-off-by: Wang Chen <wangchen20@iscas.ac.cn>
> ---
>  arch/riscv/Kconfig.socs | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> index 6833d01e2e70..fc7b5e6c7def 100644
> --- a/arch/riscv/Kconfig.socs
> +++ b/arch/riscv/Kconfig.socs
> @@ -110,4 +110,14 @@ config SOC_CANAAN_K210_DTB_SOURCE
> =20
>  endif # ARCH_CANAAN
> =20
> +config ARCH_SOPHGO
> +	bool "Sophgo SoCs"
> +	select SIFIVE_PLIC

This should not be needed, this should be selected at the arch level.

> +	help
> +	  This enables support for Sophgo SoC platform hardware.
> +	  SOPHGO is committed to become a provider of universal
> +	  computing power, focusing on the development and
> +	  promotion of computing power products such as AI and
> +	  RISC-V CPU.

This is not a place for marketing blurbs, please take a look at the
other entries.
Also, this should not be placed at the end of the list, it should be
before ARCH_SUNXI.

Thanks,
Conor.

> +
>  endmenu # "SoC selection"
> --=20
> 2.25.1
>=20

--ENGkoMse754EbNpY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQQF6QAKCRB4tDGHoIJi
0oTJAP9c52u8XECYZvn+Qt9RdRvorAS3pVREBUDao12bLGJQcQEAxhTfNeJImtXF
WhPAFatMpxtY1G/qD8E+TiVnTwgm4Qo=
=FBOL
-----END PGP SIGNATURE-----

--ENGkoMse754EbNpY--
