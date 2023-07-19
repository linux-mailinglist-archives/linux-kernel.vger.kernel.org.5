Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B79E75A1ED
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 00:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjGSWak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 18:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjGSWag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 18:30:36 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C16F1BF0;
        Wed, 19 Jul 2023 15:30:34 -0700 (PDT)
Received: from mercury (unknown [185.209.196.239])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DF2DE6607058;
        Wed, 19 Jul 2023 23:30:32 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689805833;
        bh=+kf7RoDivTxamgEcoW6Au+YH65J2a8+x+Q1W6naqTd0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Crowx33tiA1ZszqiIpnxygnHyfnjM68Sv6gGo3eOwU4048AtB6megzV41TdG7003e
         wK6g+4BoWKC3V6fz8J1mN50/vWgcq+FC+WV145TneGEdmHihPD4E3vQWqNhp3N8uLS
         3tmX4sRASjDNI7gOnI/KBhJd3UsAt5qEa2G0PL2yRPgOFBB1lUqS8ggsdFKMubHrKO
         jMHKtMUwaNSfUFncWG0xK2tE3g9izJveNslEGhU/MRTCKePlnTwXZDXmcr9jWpnBDY
         RRuEBFLDJAvcCoX4mXY6ZfpqhfcGn+3C1Pp1uGUlFfzRfz7o8p+WTSebgiayh/6n5E
         ZgmkB5sVNIlNg==
Received: by mercury (Postfix, from userid 1000)
        id D2FE31062877; Thu, 20 Jul 2023 00:30:30 +0200 (CEST)
Date:   Thu, 20 Jul 2023 00:30:30 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mtd@lists.infradead.org, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-oxnas@groups.io,
        Arnd Bergmann <arnd@arndb.de>,
        Daniel Golle <daniel@makrotopia.org>
Subject: Re: [PATCH v2 12/15] power: reset: oxnas-restart: remove obsolete
 restart driver
Message-ID: <20230719223030.5yvdm3stj4lojlg6@mercury.elektranox.org>
References: <20230630-topic-oxnas-upstream-remove-v2-0-fb6ab3dea87c@linaro.org>
 <20230630-topic-oxnas-upstream-remove-v2-12-fb6ab3dea87c@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lyw6wy7zr4wdlke6"
Content-Disposition: inline
In-Reply-To: <20230630-topic-oxnas-upstream-remove-v2-12-fb6ab3dea87c@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lyw6wy7zr4wdlke6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jun 30, 2023 at 06:58:37PM +0200, Neil Armstrong wrote:
> Due to lack of maintenance and stall of development for a few years now,
> and since no new features will ever be added upstream, remove support
> for OX810 and OX820 restart feature.
>=20
> Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Daniel Golle <daniel@makrotopia.org>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/reset/Kconfig         |   7 --
>  drivers/power/reset/Makefile        |   1 -
>  drivers/power/reset/oxnas-restart.c | 233 ------------------------------=
------
>  3 files changed, 241 deletions(-)
>=20
> diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> index fff07b2bd77b..59e1ebb7842e 100644
> --- a/drivers/power/reset/Kconfig
> +++ b/drivers/power/reset/Kconfig
> @@ -148,13 +148,6 @@ config POWER_RESET_ODROID_GO_ULTRA_POWEROFF
>  	help
>  	  This driver supports Power off for Odroid Go Ultra device.
> =20
> -config POWER_RESET_OXNAS
> -	bool "OXNAS SoC restart driver"
> -	depends on ARCH_OXNAS
> -	default MACH_OX820
> -	help
> -	  Restart support for OXNAS/PLXTECH OX820 SoC.
> -
>  config POWER_RESET_PIIX4_POWEROFF
>  	tristate "Intel PIIX4 power-off driver"
>  	depends on PCI
> diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
> index d763e6735ee3..a95d1bd275d1 100644
> --- a/drivers/power/reset/Makefile
> +++ b/drivers/power/reset/Makefile
> @@ -14,7 +14,6 @@ obj-$(CONFIG_POWER_RESET_HISI) +=3D hisi-reboot.o
>  obj-$(CONFIG_POWER_RESET_LINKSTATION) +=3D linkstation-poweroff.o
>  obj-$(CONFIG_POWER_RESET_MSM) +=3D msm-poweroff.o
>  obj-$(CONFIG_POWER_RESET_MT6323) +=3D mt6323-poweroff.o
> -obj-$(CONFIG_POWER_RESET_OXNAS) +=3D oxnas-restart.o
>  obj-$(CONFIG_POWER_RESET_QCOM_PON) +=3D qcom-pon.o
>  obj-$(CONFIG_POWER_RESET_OCELOT_RESET) +=3D ocelot-reset.o
>  obj-$(CONFIG_POWER_RESET_ODROID_GO_ULTRA_POWEROFF) +=3D odroid-go-ultra-=
poweroff.o
> diff --git a/drivers/power/reset/oxnas-restart.c b/drivers/power/reset/ox=
nas-restart.c
> deleted file mode 100644
> index 13090bec058a..000000000000
> --- a/drivers/power/reset/oxnas-restart.c
> +++ /dev/null
> @@ -1,233 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0)
> -/*
> - * oxnas SoC reset driver
> - * based on:
> - * Microsemi MIPS SoC reset driver
> - * and ox820_assert_system_reset() written by Ma Hajun <mahaijuns@gmail.=
com>
> - *
> - * Copyright (c) 2013 Ma Hajun <mahaijuns@gmail.com>
> - * Copyright (c) 2017 Microsemi Corporation
> - * Copyright (c) 2020 Daniel Golle <daniel@makrotopia.org>
> - */
> -#include <linux/delay.h>
> -#include <linux/io.h>
> -#include <linux/notifier.h>
> -#include <linux/mfd/syscon.h>
> -#include <linux/of_address.h>
> -#include <linux/of_device.h>
> -#include <linux/platform_device.h>
> -#include <linux/reboot.h>
> -#include <linux/regmap.h>
> -
> -/* bit numbers of reset control register */
> -#define OX820_SYS_CTRL_RST_SCU                0
> -#define OX820_SYS_CTRL_RST_COPRO              1
> -#define OX820_SYS_CTRL_RST_ARM0               2
> -#define OX820_SYS_CTRL_RST_ARM1               3
> -#define OX820_SYS_CTRL_RST_USBHS              4
> -#define OX820_SYS_CTRL_RST_USBHSPHYA          5
> -#define OX820_SYS_CTRL_RST_MACA               6
> -#define OX820_SYS_CTRL_RST_MAC                OX820_SYS_CTRL_RST_MACA
> -#define OX820_SYS_CTRL_RST_PCIEA              7
> -#define OX820_SYS_CTRL_RST_SGDMA              8
> -#define OX820_SYS_CTRL_RST_CIPHER             9
> -#define OX820_SYS_CTRL_RST_DDR                10
> -#define OX820_SYS_CTRL_RST_SATA               11
> -#define OX820_SYS_CTRL_RST_SATA_LINK          12
> -#define OX820_SYS_CTRL_RST_SATA_PHY           13
> -#define OX820_SYS_CTRL_RST_PCIEPHY            14
> -#define OX820_SYS_CTRL_RST_STATIC             15
> -#define OX820_SYS_CTRL_RST_GPIO               16
> -#define OX820_SYS_CTRL_RST_UART1              17
> -#define OX820_SYS_CTRL_RST_UART2              18
> -#define OX820_SYS_CTRL_RST_MISC               19
> -#define OX820_SYS_CTRL_RST_I2S                20
> -#define OX820_SYS_CTRL_RST_SD                 21
> -#define OX820_SYS_CTRL_RST_MACB               22
> -#define OX820_SYS_CTRL_RST_PCIEB              23
> -#define OX820_SYS_CTRL_RST_VIDEO              24
> -#define OX820_SYS_CTRL_RST_DDR_PHY            25
> -#define OX820_SYS_CTRL_RST_USBHSPHYB          26
> -#define OX820_SYS_CTRL_RST_USBDEV             27
> -#define OX820_SYS_CTRL_RST_ARMDBG             29
> -#define OX820_SYS_CTRL_RST_PLLA               30
> -#define OX820_SYS_CTRL_RST_PLLB               31
> -
> -/* bit numbers of clock control register */
> -#define OX820_SYS_CTRL_CLK_COPRO              0
> -#define OX820_SYS_CTRL_CLK_DMA                1
> -#define OX820_SYS_CTRL_CLK_CIPHER             2
> -#define OX820_SYS_CTRL_CLK_SD                 3
> -#define OX820_SYS_CTRL_CLK_SATA               4
> -#define OX820_SYS_CTRL_CLK_I2S                5
> -#define OX820_SYS_CTRL_CLK_USBHS              6
> -#define OX820_SYS_CTRL_CLK_MACA               7
> -#define OX820_SYS_CTRL_CLK_MAC                OX820_SYS_CTRL_CLK_MACA
> -#define OX820_SYS_CTRL_CLK_PCIEA              8
> -#define OX820_SYS_CTRL_CLK_STATIC             9
> -#define OX820_SYS_CTRL_CLK_MACB               10
> -#define OX820_SYS_CTRL_CLK_PCIEB              11
> -#define OX820_SYS_CTRL_CLK_REF600             12
> -#define OX820_SYS_CTRL_CLK_USBDEV             13
> -#define OX820_SYS_CTRL_CLK_DDR                14
> -#define OX820_SYS_CTRL_CLK_DDRPHY             15
> -#define OX820_SYS_CTRL_CLK_DDRCK              16
> -
> -/* Regmap offsets */
> -#define OX820_CLK_SET_REGOFFSET               0x2c
> -#define OX820_CLK_CLR_REGOFFSET               0x30
> -#define OX820_RST_SET_REGOFFSET               0x34
> -#define OX820_RST_CLR_REGOFFSET               0x38
> -#define OX820_SECONDARY_SEL_REGOFFSET         0x14
> -#define OX820_TERTIARY_SEL_REGOFFSET          0x8c
> -#define OX820_QUATERNARY_SEL_REGOFFSET        0x94
> -#define OX820_DEBUG_SEL_REGOFFSET             0x9c
> -#define OX820_ALTERNATIVE_SEL_REGOFFSET       0xa4
> -#define OX820_PULLUP_SEL_REGOFFSET            0xac
> -#define OX820_SEC_SECONDARY_SEL_REGOFFSET     0x100014
> -#define OX820_SEC_TERTIARY_SEL_REGOFFSET      0x10008c
> -#define OX820_SEC_QUATERNARY_SEL_REGOFFSET    0x100094
> -#define OX820_SEC_DEBUG_SEL_REGOFFSET         0x10009c
> -#define OX820_SEC_ALTERNATIVE_SEL_REGOFFSET   0x1000a4
> -#define OX820_SEC_PULLUP_SEL_REGOFFSET        0x1000ac
> -
> -struct oxnas_restart_context {
> -	struct regmap *sys_ctrl;
> -	struct notifier_block restart_handler;
> -};
> -
> -static int ox820_restart_handle(struct notifier_block *this,
> -				 unsigned long mode, void *cmd)
> -{
> -	struct oxnas_restart_context *ctx =3D container_of(this, struct
> -							oxnas_restart_context,
> -							restart_handler);
> -	u32 value;
> -
> -	/*
> -	 * Assert reset to cores as per power on defaults
> -	 * Don't touch the DDR interface as things will come to an impromptu
> -	 * stop NB Possibly should be asserting reset for PLLB, but there are
> -	 * timing concerns here according to the docs
> -	 */
> -	value =3D BIT(OX820_SYS_CTRL_RST_COPRO)		|
> -		BIT(OX820_SYS_CTRL_RST_USBHS)		|
> -		BIT(OX820_SYS_CTRL_RST_USBHSPHYA)	|
> -		BIT(OX820_SYS_CTRL_RST_MACA)		|
> -		BIT(OX820_SYS_CTRL_RST_PCIEA)		|
> -		BIT(OX820_SYS_CTRL_RST_SGDMA)		|
> -		BIT(OX820_SYS_CTRL_RST_CIPHER)		|
> -		BIT(OX820_SYS_CTRL_RST_SATA)		|
> -		BIT(OX820_SYS_CTRL_RST_SATA_LINK)	|
> -		BIT(OX820_SYS_CTRL_RST_SATA_PHY)	|
> -		BIT(OX820_SYS_CTRL_RST_PCIEPHY)		|
> -		BIT(OX820_SYS_CTRL_RST_STATIC)		|
> -		BIT(OX820_SYS_CTRL_RST_UART1)		|
> -		BIT(OX820_SYS_CTRL_RST_UART2)		|
> -		BIT(OX820_SYS_CTRL_RST_MISC)		|
> -		BIT(OX820_SYS_CTRL_RST_I2S)		|
> -		BIT(OX820_SYS_CTRL_RST_SD)		|
> -		BIT(OX820_SYS_CTRL_RST_MACB)		|
> -		BIT(OX820_SYS_CTRL_RST_PCIEB)		|
> -		BIT(OX820_SYS_CTRL_RST_VIDEO)		|
> -		BIT(OX820_SYS_CTRL_RST_USBHSPHYB)	|
> -		BIT(OX820_SYS_CTRL_RST_USBDEV);
> -
> -	regmap_write(ctx->sys_ctrl, OX820_RST_SET_REGOFFSET, value);
> -
> -	/* Release reset to cores as per power on defaults */
> -	regmap_write(ctx->sys_ctrl, OX820_RST_CLR_REGOFFSET,
> -			BIT(OX820_SYS_CTRL_RST_GPIO));
> -
> -	/*
> -	 * Disable clocks to cores as per power-on defaults - must leave DDR
> -	 * related clocks enabled otherwise we'll stop rather abruptly.
> -	 */
> -	value =3D BIT(OX820_SYS_CTRL_CLK_COPRO)		|
> -		BIT(OX820_SYS_CTRL_CLK_DMA)		|
> -		BIT(OX820_SYS_CTRL_CLK_CIPHER)		|
> -		BIT(OX820_SYS_CTRL_CLK_SD)		|
> -		BIT(OX820_SYS_CTRL_CLK_SATA)		|
> -		BIT(OX820_SYS_CTRL_CLK_I2S)		|
> -		BIT(OX820_SYS_CTRL_CLK_USBHS)		|
> -		BIT(OX820_SYS_CTRL_CLK_MAC)		|
> -		BIT(OX820_SYS_CTRL_CLK_PCIEA)		|
> -		BIT(OX820_SYS_CTRL_CLK_STATIC)		|
> -		BIT(OX820_SYS_CTRL_CLK_MACB)		|
> -		BIT(OX820_SYS_CTRL_CLK_PCIEB)		|
> -		BIT(OX820_SYS_CTRL_CLK_REF600)		|
> -		BIT(OX820_SYS_CTRL_CLK_USBDEV);
> -
> -	regmap_write(ctx->sys_ctrl, OX820_CLK_CLR_REGOFFSET, value);
> -
> -	/* Enable clocks to cores as per power-on defaults */
> -
> -	/* Set sys-control pin mux'ing as per power-on defaults */
> -	regmap_write(ctx->sys_ctrl, OX820_SECONDARY_SEL_REGOFFSET, 0);
> -	regmap_write(ctx->sys_ctrl, OX820_TERTIARY_SEL_REGOFFSET, 0);
> -	regmap_write(ctx->sys_ctrl, OX820_QUATERNARY_SEL_REGOFFSET, 0);
> -	regmap_write(ctx->sys_ctrl, OX820_DEBUG_SEL_REGOFFSET, 0);
> -	regmap_write(ctx->sys_ctrl, OX820_ALTERNATIVE_SEL_REGOFFSET, 0);
> -	regmap_write(ctx->sys_ctrl, OX820_PULLUP_SEL_REGOFFSET, 0);
> -
> -	regmap_write(ctx->sys_ctrl, OX820_SEC_SECONDARY_SEL_REGOFFSET, 0);
> -	regmap_write(ctx->sys_ctrl, OX820_SEC_TERTIARY_SEL_REGOFFSET, 0);
> -	regmap_write(ctx->sys_ctrl, OX820_SEC_QUATERNARY_SEL_REGOFFSET, 0);
> -	regmap_write(ctx->sys_ctrl, OX820_SEC_DEBUG_SEL_REGOFFSET, 0);
> -	regmap_write(ctx->sys_ctrl, OX820_SEC_ALTERNATIVE_SEL_REGOFFSET, 0);
> -	regmap_write(ctx->sys_ctrl, OX820_SEC_PULLUP_SEL_REGOFFSET, 0);
> -
> -	/*
> -	 * No need to save any state, as the ROM loader can determine whether
> -	 * reset is due to power cycling or programatic action, just hit the
> -	 * (self-clearing) CPU reset bit of the block reset register
> -	 */
> -	value =3D
> -		BIT(OX820_SYS_CTRL_RST_SCU) |
> -		BIT(OX820_SYS_CTRL_RST_ARM0) |
> -		BIT(OX820_SYS_CTRL_RST_ARM1);
> -
> -	regmap_write(ctx->sys_ctrl, OX820_RST_SET_REGOFFSET, value);
> -
> -	pr_emerg("Unable to restart system\n");
> -	return NOTIFY_DONE;
> -}
> -
> -static int ox820_restart_probe(struct platform_device *pdev)
> -{
> -	struct oxnas_restart_context *ctx;
> -	struct regmap *sys_ctrl;
> -	struct device *dev =3D &pdev->dev;
> -	int err =3D 0;
> -
> -	sys_ctrl =3D syscon_node_to_regmap(pdev->dev.of_node);
> -	if (IS_ERR(sys_ctrl))
> -		return PTR_ERR(sys_ctrl);
> -
> -	ctx =3D devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_KERNEL);
> -	if (!ctx)
> -		return -ENOMEM;
> -
> -	ctx->sys_ctrl =3D sys_ctrl;
> -	ctx->restart_handler.notifier_call =3D ox820_restart_handle;
> -	ctx->restart_handler.priority =3D 192;
> -	err =3D register_restart_handler(&ctx->restart_handler);
> -	if (err)
> -		dev_err(dev, "can't register restart notifier (err=3D%d)\n", err);
> -
> -	return err;
> -}
> -
> -static const struct of_device_id ox820_restart_of_match[] =3D {
> -	{ .compatible =3D "oxsemi,ox820-sys-ctrl" },
> -	{}
> -};
> -
> -static struct platform_driver ox820_restart_driver =3D {
> -	.probe =3D ox820_restart_probe,
> -	.driver =3D {
> -		.name =3D "ox820-chip-reset",
> -		.of_match_table =3D ox820_restart_of_match,
> -	},
> -};
> -builtin_platform_driver(ox820_restart_driver);
>=20
> --=20
> 2.34.1
>=20

--lyw6wy7zr4wdlke6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmS4Y/sACgkQ2O7X88g7
+pqWORAAhnuSzBSgSarcodT3gxHpEZgAj/XnfVKr1PDfxOVhyV17RiZPStEXlbYU
ODsrFEhVjIN9BuagUVjIWf0yRJ6NjhCQr9JuO9+y0MIlKRPZmVnlEzYiyReYPgPi
EazV0/RhPRCoqUOUlrjrn0UYBXiISj+O6Ig/sbwZ76KLycaUEFVSqP9bJawa/T3a
C/jNg2qVjDcwUJ22g/xidwXNNg7ie8kOggyA0uyp7y2MHm1eRL8O403sZh7v7wZZ
MI2bXkQxg8iBnXLTWQ1g7Dbrt60LjO9PEqbe7bKsGkoIA5pVltMy0YKh+FeH8S3h
VIXaCIbRA/uJXQPsolubLQOP6rQDrGOLyNLp7bjP8gRyvbE76poixd1/KGmXLNkV
KRXq3cuBhDU8jtpXhh3E9IsLkaHwXS/xxcu7HXWRDF2e5kY3mQyyARkXpe4SUPkx
CiGnUTg4TB+2z9Y7QbNrVNErzoMmNTFjr0ZQ/O72jRtrpNTnXmQSOeEQET7TgcXf
Ywif3RIUkvt/uskyQogTpHd6gJHII4kQ1czwfQ8gMKXH/2r5yHx5u+KY2NpYB+7K
lKMQVweY52wdFPat9xsqorHcHE+jE3PujNQD8ryr3IV8luVWh6ND5KjwFGXx5WHY
/51coHqpHCKUvUTtlMkSdHChPpnHNW54ieSDwzrTvksDmd1nKSs=
=rMk0
-----END PGP SIGNATURE-----

--lyw6wy7zr4wdlke6--
