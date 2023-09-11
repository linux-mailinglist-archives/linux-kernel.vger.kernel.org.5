Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D303E79B020
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240741AbjIKVt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237654AbjIKNFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 09:05:30 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753A5DF
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 06:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1694437526; x=1725973526;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SMSvAIK8f24bxto0iuALkwzOXDi8ggcjv/HOf5OUMyk=;
  b=k+VdmTfLDceV7nYACQaP9x2UQQQfcTPjS8R4nPSrUt/fJagBhboSRnnA
   bLNpJULT6/6y6EoExhvViLKS9vxGxoW467sG8l4+T/YBp8AfWSAuYkxLo
   hHriLFLmj/niKuQphTXVxxy0c775Ib/9LdSCzZSf3s4esDW3hCPkNrvSH
   9rjRna+gBmOgI4IxT4F/UU+F+jvjZex8C2dRMnERBxM7KMWczAW4jXQsu
   ZABJCfoxDs4QldJVBZOa+riKeSW9RACtX251mUx1fn7imhtWiUch0/7BQ
   LwBcSHQwtVdOCwJsKM72GwZ0CwCtbQcHI/zd5wHSgyYu+mL1C+tDot7HO
   w==;
X-CSE-ConnectionGUID: VDayhyd4Rw2TIoz7MS5k0Q==
X-CSE-MsgGUID: 1DSYGvUiRcaFtXRwQG1SZw==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="asc'?scan'208";a="3886195"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Sep 2023 06:05:23 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 11 Sep 2023 06:05:23 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex01.mchp-main.com (10.10.85.143)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 11 Sep 2023 06:05:21 -0700
Date:   Mon, 11 Sep 2023 14:05:06 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Jinyu Tang <tangjinyu@tinylab.org>
CC:     <william.qiu@starfivetech.com>, <hal.feng@starfivetech.com>,
        <palmer@dabbelt.com>, <apatel@ventanamicro.com>,
        <ttjjyystupid@163.com>, <falcon@tinylab.org>,
        <wangjiexun@tinylab.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] riscv: defconfig : add CONFIG_MMC_DW for starfive
Message-ID: <20230911-uneaten-shuffling-27c862d5fb10@wendy>
References: <20230911125955.8937-1-tangjinyu@tinylab.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5zK+w15ftwOdzKYN"
Content-Disposition: inline
In-Reply-To: <20230911125955.8937-1-tangjinyu@tinylab.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--5zK+w15ftwOdzKYN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 11, 2023 at 08:59:55PM +0800, Jinyu Tang wrote:
> If these config not set, mmc can't run for jh7110, rootfs can't
> be found when using SD card. So set CONFIG_MMC_DW=3Dy like arm64
> defconfig, and set CONFIG_MMC_DW_STARFIVE=3Dy for starfive. Then
> starfive vf2 can start SD card rootfs with mainline defconfig and
> dtb.
>=20
> Signed-off-by: Jinyu Tang <tangjinyu@tinylab.org>
> ---
>  arch/riscv/configs/defconfig | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> index ab86ec3b9..0664b92d1 100644
> --- a/arch/riscv/configs/defconfig
> +++ b/arch/riscv/configs/defconfig
> @@ -170,6 +170,8 @@ CONFIG_MMC_SDHCI_PLTFM=3Dy
>  CONFIG_MMC_SDHCI_CADENCE=3Dy
>  CONFIG_MMC_SPI=3Dy
>  CONFIG_MMC_SUNXI=3Dy
> +CONFIG_MMC_DW=3Dy
> +CONFIG_MMC_DW_STARFIVE=3Dy

Is this where savedefconfig puts them? The order here looks different to
the arm64 defconfig.

Thanks,
Conor.

>  CONFIG_RTC_CLASS=3Dy
>  CONFIG_RTC_DRV_SUN6I=3Dy
>  CONFIG_DMADEVICES=3Dy
> --=20
> 2.39.2
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

--5zK+w15ftwOdzKYN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZP8QgQAKCRB4tDGHoIJi
0u/kAP0VaymayQ4ZAvwWzzzA6lrwMVpsmhM3WvJUeveCP5FEAgD+O6xt7cT5wC+X
dKTvwNOFq60zyYKn/kFF3XNdxk6l8Ag=
=Dg11
-----END PGP SIGNATURE-----

--5zK+w15ftwOdzKYN--
