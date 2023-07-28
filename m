Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54C517670B0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 17:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236823AbjG1Pgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 11:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237366AbjG1Pgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 11:36:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CACC24490
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 08:36:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 22B956217E
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 15:36:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61A74C433C8;
        Fri, 28 Jul 2023 15:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690558594;
        bh=cVKgEOIxXOzJuQZUsbb4DX8RCXpaEiXPOTckWWF6TlY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M4N203+JtHBDwkk+OelwXxD/1pzlc7xTp2rsw2TLdvif1Q15rVnfkAWF5o8rH72kS
         yrBpa3OJvgGqjq3w1U64le+CSbLTZSb9oBl0x/FAIOhnwV9VnlttitBg3Ov7Vs5L08
         QSCaTrCkXmXFBUfv2QCV6QN2++Da78m24qJ2qspM8klWIHjoFohky6wC8iLwJIkYD2
         MPZwFzhCG7HXJq88WdKMVXH3zz+CcEAL09nIZ428SOJNR5mLLCxMWAiDhoimz+zejR
         xVMVT5R3lJLQbUVqJT7NR3sbRnAfSzE6rnuxZUHHNrFUFygPOlxM7yBYTynsyGE+59
         SIccOAtWpOeHw==
Date:   Fri, 28 Jul 2023 16:36:31 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com
Subject: Re: [PATCH] MAINTAINERS: update Claudiu Beznea's email address
Message-ID: <20230728-hypertext-nullify-50c9f318db85@spud>
References: <20230714183852.8370-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nO8shPH/+ajVjh+F"
Content-Disposition: inline
In-Reply-To: <20230714183852.8370-1-claudiu.beznea@tuxon.dev>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nO8shPH/+ajVjh+F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Claudiu,

On Fri, Jul 14, 2023 at 09:38:52PM +0300, Claudiu Beznea wrote:
> Update MAINTAINERS entries with a valid email address as the Microchip
> one is no longer valid.

I'm not sure how you want this patch to get to the soc tree (I figure it
should grow a cc to the soc maintainer alias & be resent) but in the
meantime I applied this directly to at91-next so that at least patches
generated against linux-next will arrive in your inbox.

Thanks,
Conor.

>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> ---
>  MAINTAINERS | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3be1bdfe8ecc..0be71ca1cbb2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2337,7 +2337,7 @@ F:	drivers/phy/mediatek/
>  ARM/MICROCHIP (ARM64) SoC support
>  M:	Conor Dooley <conor@kernel.org>
>  M:	Nicolas Ferre <nicolas.ferre@microchip.com>
> -M:	Claudiu Beznea <claudiu.beznea@microchip.com>
> +M:	Claudiu Beznea <claudiu.beznea@tuxon.dev>
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>  S:	Supported
>  T:	git https://git.kernel.org/pub/scm/linux/kernel/git/at91/linux.git
> @@ -2346,7 +2346,7 @@ F:	arch/arm64/boot/dts/microchip/
>  ARM/Microchip (AT91) SoC support
>  M:	Nicolas Ferre <nicolas.ferre@microchip.com>
>  M:	Alexandre Belloni <alexandre.belloni@bootlin.com>
> -M:	Claudiu Beznea <claudiu.beznea@microchip.com>
> +M:	Claudiu Beznea <claudiu.beznea@tuxon.dev>
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>  S:	Supported
>  W:	http://www.linux4sam.org
> @@ -3248,7 +3248,7 @@ F:	include/uapi/linux/atm*
> =20
>  ATMEL MACB ETHERNET DRIVER
>  M:	Nicolas Ferre <nicolas.ferre@microchip.com>
> -M:	Claudiu Beznea <claudiu.beznea@microchip.com>
> +M:	Claudiu Beznea <claudiu.beznea@tuxon.dev>
>  S:	Supported
>  F:	drivers/net/ethernet/cadence/
> =20
> @@ -13778,7 +13778,7 @@ F:	Documentation/devicetree/bindings/serial/atmel=
,at91-usart.yaml
>  F:	drivers/spi/spi-at91-usart.c
> =20
>  MICROCHIP AUDIO ASOC DRIVERS
> -M:	Claudiu Beznea <claudiu.beznea@microchip.com>
> +M:	Claudiu Beznea <claudiu.beznea@tuxon.dev>
>  L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
>  S:	Supported
>  F:	Documentation/devicetree/bindings/sound/atmel*
> @@ -13801,7 +13801,7 @@ S:	Maintained
>  F:	drivers/crypto/atmel-ecc.*
> =20
>  MICROCHIP EIC DRIVER
> -M:	Claudiu Beznea <claudiu.beznea@microchip.com>
> +M:	Claudiu Beznea <claudiu.beznea@tuxon.dev>
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>  S:	Supported
>  F:	Documentation/devicetree/bindings/interrupt-controller/microchip,sama=
7g5-eic.yaml
> @@ -13874,7 +13874,7 @@ F:	drivers/video/fbdev/atmel_lcdfb.c
>  F:	include/video/atmel_lcdc.h
> =20
>  MICROCHIP MCP16502 PMIC DRIVER
> -M:	Claudiu Beznea <claudiu.beznea@microchip.com>
> +M:	Claudiu Beznea <claudiu.beznea@tuxon.dev>
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>  S:	Supported
>  F:	Documentation/devicetree/bindings/regulator/mcp16502-regulator.txt
> @@ -13901,7 +13901,7 @@ F:	Documentation/devicetree/bindings/mtd/atmel-na=
nd.txt
>  F:	drivers/mtd/nand/raw/atmel/*
> =20
>  MICROCHIP OTPC DRIVER
> -M:	Claudiu Beznea <claudiu.beznea@microchip.com>
> +M:	Claudiu Beznea <claudiu.beznea@tuxon.dev>
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>  S:	Supported
>  F:	Documentation/devicetree/bindings/nvmem/microchip,sama7g5-otpc.yaml
> @@ -13940,7 +13940,7 @@ F:	Documentation/devicetree/bindings/fpga/microch=
ip,mpf-spi-fpga-mgr.yaml
>  F:	drivers/fpga/microchip-spi.c
> =20
>  MICROCHIP PWM DRIVER
> -M:	Claudiu Beznea <claudiu.beznea@microchip.com>
> +M:	Claudiu Beznea <claudiu.beznea@tuxon.dev>
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>  L:	linux-pwm@vger.kernel.org
>  S:	Supported
> @@ -13956,7 +13956,7 @@ F:	drivers/iio/adc/at91-sama5d2_adc.c
>  F:	include/dt-bindings/iio/adc/at91-sama5d2_adc.h
> =20
>  MICROCHIP SAMA5D2-COMPATIBLE SHUTDOWN CONTROLLER
> -M:	Claudiu Beznea <claudiu.beznea@microchip.com>
> +M:	Claudiu Beznea <claudiu.beznea@tuxon.dev>
>  S:	Supported
>  F:	Documentation/devicetree/bindings/power/reset/atmel,sama5d2-shdwc.yaml
>  F:	drivers/power/reset/at91-sama5d2_shdwc.c
> @@ -13973,7 +13973,7 @@ S:	Supported
>  F:	drivers/spi/spi-atmel.*
> =20
>  MICROCHIP SSC DRIVER
> -M:	Claudiu Beznea <claudiu.beznea@microchip.com>
> +M:	Claudiu Beznea <claudiu.beznea@tuxon.dev>
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>  S:	Supported
>  F:	Documentation/devicetree/bindings/misc/atmel-ssc.txt
> @@ -14002,7 +14002,7 @@ F:	drivers/usb/gadget/udc/atmel_usba_udc.*
> =20
>  MICROCHIP WILC1000 WIFI DRIVER
>  M:	Ajay Singh <ajay.kathat@microchip.com>
> -M:	Claudiu Beznea <claudiu.beznea@microchip.com>
> +M:	Claudiu Beznea <claudiu.beznea@tuxon.dev>
>  L:	linux-wireless@vger.kernel.org
>  S:	Supported
>  F:	drivers/net/wireless/microchip/wilc1000/
> --=20
> 2.39.2
>=20

--nO8shPH/+ajVjh+F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMPgfgAKCRB4tDGHoIJi
0pgHAQCnr/Zt/CbsyTwyE4YSzq8I6WAtLupcTnBCptbc+8sgEwEAiNnu2G4R3RzF
H+FnI4Fvrm1B+aWKU3E9L0DJIynXZgo=
=Vihg
-----END PGP SIGNATURE-----

--nO8shPH/+ajVjh+F--
