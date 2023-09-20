Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 988597A7599
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 10:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbjITIR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 04:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbjITIR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 04:17:57 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C784292;
        Wed, 20 Sep 2023 01:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1695197871; x=1726733871;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uscGBvmgvNEc+s+JZQTVBQ0oYKPyV4d4IvX6BfOqdrY=;
  b=oYvOOBsnJ7l/6dtoQPgDfdTDdDnRAVOg5gm756PHaPjEVSR9Il09AisN
   v9ircF4GyXEXqTbJwBbTRgLgZFtpw25My42wnVKKG4v/pCwUoiYJHJXHZ
   u8nGwgFReQRWJq3809ZbRwt4KItQmJ7+VlfJGSTw174A+49T3haMlYJaO
   j4R35XRf0XUD2yzobqk6lj5/A9N1sYM1tb01z3Mu6+MS6rDrVvzesBWQT
   VbcbUHK1axmEKCTdyfwDvzhwJYtHQ+imW2ylWfeLvppml5r5uoAdcFidv
   ND8pvlFm4PIbP5b/kxAvnDzDicBaawEBK+mhJrxINwEq5or3Wb2ioI69/
   A==;
X-CSE-ConnectionGUID: G6ieCjkyQ2aMLIcShOg63A==
X-CSE-MsgGUID: fFvmlZASSraejIWgrHECZg==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="asc'?scan'208";a="5607864"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Sep 2023 01:17:39 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 20 Sep 2023 01:17:13 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 20 Sep 2023 01:17:10 -0700
Date:   Wed, 20 Sep 2023 09:16:53 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Chen Wang <unicornxw@gmail.com>
CC:     <aou@eecs.berkeley.edu>, <chao.wei@sophgo.com>, <conor@kernel.org>,
        <devicetree@vger.kernel.org>, <emil.renner.berthing@canonical.com>,
        <guoren@kernel.org>, <jszhang@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <palmer@dabbelt.com>, <paul.walmsley@sifive.com>,
        <robh+dt@kernel.org>, <xiaoguang.xing@sophgo.com>,
        Chen Wang <wangchen20@iscas.ac.cn>
Subject: Re: [PATCH v2 10/11] riscv: dts: sophgo: add Milk-V Pioneer board
 device tree
Message-ID: <20230920-papyrus-corned-e121fb9dd7b1@wendy>
References: <cover.1695189879.git.wangchen20@iscas.ac.cn>
 <e9ff83e4fac9a9ebd217ef10e5f8d3260342102b.1695189879.git.wangchen20@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="DKUtOVTQQHokYjGs"
Content-Disposition: inline
In-Reply-To: <e9ff83e4fac9a9ebd217ef10e5f8d3260342102b.1695189879.git.wangchen20@iscas.ac.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--DKUtOVTQQHokYjGs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Wed, Sep 20, 2023 at 02:40:53PM +0800, Chen Wang wrote:
> Milk-V Pioneer [1] is a developer motherboard based on SOPHON
> SG2042 in a standard mATX form factor.

> It is a good
> choice for RISC-V developers and hardware pioneers to
> experience the cutting edge technology of RISC-V.

I'd rather we didn't put advertising into commit messages.

> Currently only support booting into console with only uart
> enabled, other features will be added soon later.
>=20
> [1]: https://milkv.io/pioneer

Make this a link tag please

Link: https://milkv.io/pioneer [1]
> Acked-by: Xiaoguang Xing <xiaoguang.xing@sophgo.com>
> Signed-off-by: Chen Wang <wangchen20@iscas.ac.cn>
> ---
>  arch/riscv/boot/dts/Makefile                  |  1 +
>  arch/riscv/boot/dts/sophgo/Makefile           |  3 +++
>  .../boot/dts/sophgo/sg2042-milkv-pioneer.dts  | 19 +++++++++++++++++++
>  3 files changed, 23 insertions(+)
>  create mode 100644 arch/riscv/boot/dts/sophgo/Makefile
>  create mode 100644 arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
>=20
> diff --git a/arch/riscv/boot/dts/Makefile b/arch/riscv/boot/dts/Makefile
> index f60a280abb15..94788486f13e 100644
> --- a/arch/riscv/boot/dts/Makefile
> +++ b/arch/riscv/boot/dts/Makefile
> @@ -6,5 +6,6 @@ subdir-y +=3D renesas
>  subdir-y +=3D sifive
>  subdir-y +=3D starfive
>  subdir-y +=3D thead
> +subdir-y +=3D sophgo

Alphanumerical order please.

Thanks,
Conor.

> =20
>  obj-$(CONFIG_BUILTIN_DTB) :=3D $(addsuffix /, $(subdir-y))
> diff --git a/arch/riscv/boot/dts/sophgo/Makefile b/arch/riscv/boot/dts/so=
phgo/Makefile
> new file mode 100644
> index 000000000000..5a471b19df22
> --- /dev/null
> +++ b/arch/riscv/boot/dts/sophgo/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
> +dtb-$(CONFIG_ARCH_SOPHGO) +=3D sg2042-milkv-pioneer.dtb
> +
> diff --git a/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts b/arch/r=
iscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
> new file mode 100644
> index 000000000000..d6e8c0285d1e
> --- /dev/null
> +++ b/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
> @@ -0,0 +1,19 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +/*
> + * Copyright (C) 2022 Sophgo Technology Inc. All rights reserved.
> + */
> +
> +#include "sg2042.dtsi"
> +
> +/ {
> +	model =3D "Milk-V Pioneer";
> +	compatible =3D "milkv,pioneer", "sophgo,sg2042";
> +
> +	chosen: chosen {
> +		stdout-path =3D "serial0";
> +	};
> +};
> +
> +&uart0 {
> +	status =3D "okay";
> +};
> --=20
> 2.25.1
>=20

--DKUtOVTQQHokYjGs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQqqagAKCRB4tDGHoIJi
0kvOAP9pT8N0unm3d9107Xii5Hc5v6uDLVvVjIg3qUcN0aE6swD/ZyuhzMbHo9vI
DVlBtRVexx2a45InVtBHxBpRyfyUrQ0=
=pTAC
-----END PGP SIGNATURE-----

--DKUtOVTQQHokYjGs--
