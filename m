Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD91B7A1A95
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 11:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233585AbjIOJad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 05:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232633AbjIOJaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 05:30:30 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749C8CED;
        Fri, 15 Sep 2023 02:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1694770225; x=1726306225;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZxrVsRDpUNvxd12RQOucpkAkUdoy3mk3RtU+h+psW7c=;
  b=Kb+e7OstiirIj/RxcOOEhdNaf4//q0WxA8Jc2R0ZeODLIG9cslCy8I9E
   9LSnmURFd3gEMIDPovlVL59qYiUL8AC7OzMxzWHgEmJBGpVORv9hZOY4V
   hNc2USO9NVs4aqoUWhWidRht15WQE9CPwB45SilEfKZ15c8JkLxcQUQLe
   EWYgnFsTgSKcWGXwMlu7FaPSAeZynHenS2nfUHQBrITx/4ayHGuNxmZ9e
   NzN1iGtkOeR2PnsVu21MfAt53aj/mOG4lSIym3FEdqC5UXmj1zbUHAJWn
   6HdlvahzYw1Ln7QCIJBo+Jv3bifZzH7qSSd3YCAbGttMkvb9y2wwsOPM6
   A==;
X-CSE-ConnectionGUID: G+JhttbMRHS/WWWcCiUIww==
X-CSE-MsgGUID: XyI0AJRFQVq2neUO9r88Pw==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.02,148,1688454000"; 
   d="asc'?scan'208";a="4701469"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Sep 2023 02:30:24 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 15 Sep 2023 02:29:28 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Fri, 15 Sep 2023 02:29:26 -0700
Date:   Fri, 15 Sep 2023 10:29:10 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Walker Chen <walker.chen@starfivetech.com>,
        Conor Dooley <conor@kernel.org>
Subject: Re: [PATCH v2 13/17] pmdomain: starfive: Move Kconfig file to the
 pmdomain subsystem
Message-ID: <20230915-lark-gangrene-b7cbd445b511@wendy>
References: <20230915092003.658361-1-ulf.hansson@linaro.org>
 <20230915092003.658361-14-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1ZlFlc8C7bX0329f"
Content-Disposition: inline
In-Reply-To: <20230915092003.658361-14-ulf.hansson@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--1ZlFlc8C7bX0329f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 15, 2023 at 11:19:59AM +0200, Ulf Hansson wrote:
> The Kconfig belongs closer to the corresponding implementation, hence let=
's
> move it from the soc subsystem to the pmdomain subsystem.

Thanks for updating the MAINTAINERS bits.

> Cc: Walker Chen <walker.chen@starfivetech.com>
> Cc: Conor Dooley <conor@kernel.org>
> Acked-by: Conor Dooley <conor@kernel.org>

Unless my macro changed without me noticing, I don't think that's
the email address I used for the ack. Just to be sure:
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  MAINTAINERS                                | 3 +--
>  drivers/pmdomain/Kconfig                   | 1 +
>  drivers/{soc =3D> pmdomain}/starfive/Kconfig | 0
>  drivers/soc/Kconfig                        | 1 -
>  4 files changed, 2 insertions(+), 3 deletions(-)
>  rename drivers/{soc =3D> pmdomain}/starfive/Kconfig (100%)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6b491ebcf790..40744fefed3d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20515,7 +20515,7 @@ M:	Walker Chen <walker.chen@starfivetech.com>
>  M:	Changhuang Liang <changhuang.liang@starfivetech.com>
>  S:	Supported
>  F:	Documentation/devicetree/bindings/power/starfive*
> -F:	drivers/pmdomain/starfive/jh71xx-pmu.c
> +F:	drivers/pmdomain/starfive/
>  F:	include/dt-bindings/power/starfive,jh7110-pmu.h
> =20
>  STARFIVE SOC DRIVERS
> @@ -20523,7 +20523,6 @@ M:	Conor Dooley <conor@kernel.org>
>  S:	Maintained
>  T:	git https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/
>  F:	Documentation/devicetree/bindings/soc/starfive/
> -F:	drivers/soc/starfive/
> =20
>  STARFIVE TRNG DRIVER
>  M:	Jia Jie Ho <jiajie.ho@starfivetech.com>
> diff --git a/drivers/pmdomain/Kconfig b/drivers/pmdomain/Kconfig
> index 08f8a3aa9805..2286c36076db 100644
> --- a/drivers/pmdomain/Kconfig
> +++ b/drivers/pmdomain/Kconfig
> @@ -12,5 +12,6 @@ source "drivers/pmdomain/renesas/Kconfig"
>  source "drivers/pmdomain/rockchip/Kconfig"
>  source "drivers/pmdomain/samsung/Kconfig"
>  source "drivers/pmdomain/st/Kconfig"
> +source "drivers/pmdomain/starfive/Kconfig"
> =20
>  endmenu
> diff --git a/drivers/soc/starfive/Kconfig b/drivers/pmdomain/starfive/Kco=
nfig
> similarity index 100%
> rename from drivers/soc/starfive/Kconfig
> rename to drivers/pmdomain/starfive/Kconfig
> diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
> index 8b46da40f107..10a9ff84ff41 100644
> --- a/drivers/soc/Kconfig
> +++ b/drivers/soc/Kconfig
> @@ -23,7 +23,6 @@ source "drivers/soc/renesas/Kconfig"
>  source "drivers/soc/rockchip/Kconfig"
>  source "drivers/soc/samsung/Kconfig"
>  source "drivers/soc/sifive/Kconfig"
> -source "drivers/soc/starfive/Kconfig"
>  source "drivers/soc/sunxi/Kconfig"
>  source "drivers/soc/tegra/Kconfig"
>  source "drivers/soc/ti/Kconfig"
> --=20
> 2.34.1
>=20

--1ZlFlc8C7bX0329f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQQj5gAKCRB4tDGHoIJi
0ni0APwKcNwJSKsOPvp2+jVoNLd8F/Qp3atCKUuE1/sjfqR/dwEA88V4E7km/zn5
cyWfek8D2WHLjgQjfvInsrZjiWvA7Ac=
=9J6Y
-----END PGP SIGNATURE-----

--1ZlFlc8C7bX0329f--
