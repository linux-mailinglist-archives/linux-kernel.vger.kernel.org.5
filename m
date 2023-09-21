Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20D3A7AA460
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 00:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232911AbjIUWHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 18:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbjIUWGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 18:06:52 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B629007
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 14:24:54 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qjRA8-0002Zq-KA; Thu, 21 Sep 2023 23:24:40 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qjRA6-00816n-Gu; Thu, 21 Sep 2023 23:24:38 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qjRA6-003jKa-4g; Thu, 21 Sep 2023 23:24:38 +0200
Date:   Thu, 21 Sep 2023 23:24:38 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Aleksandr Shubin <privatesub2@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v6 2/3] pwm: Add Allwinner's D1/T113-S3/R329 SoCs PWM
 support
Message-ID: <20230921212438.dq66fcwgrgqrg57d@pengutronix.de>
References: <20230824114038.891493-1-privatesub2@gmail.com>
 <20230824114038.891493-3-privatesub2@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ird3aryfheitd4gg"
Content-Disposition: inline
In-Reply-To: <20230824114038.891493-3-privatesub2@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ird3aryfheitd4gg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Aleksandr,

On Thu, Aug 24, 2023 at 02:40:26PM +0300, Aleksandr Shubin wrote:
> Allwinner's D1, T113-S3 and R329 SoCs have a quite different PWM
> controllers with ones supported by pwm-sun4i driver.
>=20
> This patch adds a PWM controller driver for Allwinner's D1,
> T113-S3 and R329 SoCs. The main difference between these SoCs
> is the number of channels defined by the DT property.
>=20
> Signed-off-by: Aleksandr Shubin <privatesub2@gmail.com>
> ---
>  drivers/pwm/Kconfig      |  10 ++
>  drivers/pwm/Makefile     |   1 +
>  drivers/pwm/pwm-sun20i.c | 328 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 339 insertions(+)
>  create mode 100644 drivers/pwm/pwm-sun20i.c
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 8df861b1f4a3..05c48a36969e 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -594,6 +594,16 @@ config PWM_SUN4I
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-sun4i.
> =20
> +config PWM_SUN20I
> +	tristate "Allwinner D1/T113s/R329 PWM support"
> +	depends on ARCH_SUNXI || COMPILE_TEST
> +	depends on COMMON_CLK
> +	help
> +	  Generic PWM framework driver for Allwinner D1/T113s/R329 SoCs.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-sun20i.
> +
>  config PWM_SUNPLUS
>  	tristate "Sunplus PWM support"
>  	depends on ARCH_SUNPLUS || COMPILE_TEST
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 19899b912e00..cea872e22c78 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -55,6 +55,7 @@ obj-$(CONFIG_PWM_STM32)		+=3D pwm-stm32.o
>  obj-$(CONFIG_PWM_STM32_LP)	+=3D pwm-stm32-lp.o
>  obj-$(CONFIG_PWM_STMPE)		+=3D pwm-stmpe.o
>  obj-$(CONFIG_PWM_SUN4I)		+=3D pwm-sun4i.o
> +obj-$(CONFIG_PWM_SUN20I)	+=3D pwm-sun20i.o
>  obj-$(CONFIG_PWM_SUNPLUS)	+=3D pwm-sunplus.o
>  obj-$(CONFIG_PWM_TEGRA)		+=3D pwm-tegra.o
>  obj-$(CONFIG_PWM_TIECAP)	+=3D pwm-tiecap.o
> diff --git a/drivers/pwm/pwm-sun20i.c b/drivers/pwm/pwm-sun20i.c
> new file mode 100644
> index 000000000000..20e6b7b5b62e
> --- /dev/null
> +++ b/drivers/pwm/pwm-sun20i.c
> @@ -0,0 +1,328 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * PWM Controller Driver for sunxi platforms (D1, T113-S3 and R329)
> + *
> + * Limitations:
> + * - When the parameters change, current running period will not be comp=
leted
> + *   and run new settings immediately.
> + * - It output HIGH-Z state when PWM channel disabled.
> + *
> + * Copyright (c) 2023 Aleksandr Shubin <privatesub2@gmail.com>
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/pwm.h>
> +#include <linux/reset.h>
> +
> +#define PWM_CLK_CFG(chan)		(0x20 + (((chan) >> 1) * 0x4))
> +#define PWM_CLK_CFG_SRC			GENMASK(8, 7)
> +#define PWM_CLK_CFG_DIV_M		GENMASK(3, 0)
> +
> +#define PWM_CLK_GATE			0x40
> +#define PWM_CLK_GATE_BYPASS(chan)	BIT((chan) - 16)

Really? With chan =3D=3D 0 this gives you BIT(-16).

> +#define PWM_CLK_GATE_GATING(chan)	BIT(chan)
> +
> +#define PWM_ENABLE			0x80
> +#define PWM_ENABLE_EN(chan)		BIT(chan)
> +
> +#define PWM_CTL(chan)			(0x100 + (chan) * 0x20)
> +#define PWM_CTL_ACT_STA			BIT(8)
> +#define PWM_CTL_PRESCAL_K		GENMASK(7, 0)
> +
> +#define PWM_PERIOD(chan)		(0x104 + (chan) * 0x20)
> +#define PWM_PERIOD_ENTIRE_CYCLE		GENMASK(31, 16)
> +#define PWM_PERIOD_ACT_CYCLE		GENMASK(15, 0)
> +
> +#define PWM_MAGIC			(255 * 65535 + 2 * 65534 + 1)

A comment about PWM_MAGIC would be nice.

I'd like to have these register defines prefixed with (say) SUN20I_,
otherwise the names are too generic and likely overlap with other
defines.

> +struct sun20i_pwm_chip {
> +	struct clk *clk_bus, *clk_hosc, *clk_apb0;
> +	struct reset_control *rst;
> +	struct pwm_chip chip;
> +	void __iomem *base;
> +	/* Mutex to protect pwm apply state */
> +	struct mutex mutex;
> +};
> +
> +static inline struct sun20i_pwm_chip *to_sun20i_pwm_chip(struct pwm_chip=
 *chip)
> +{
> +	return container_of(chip, struct sun20i_pwm_chip, chip);
> +}
> +
> +static inline u32 sun20i_pwm_readl(struct sun20i_pwm_chip *chip,
> +				   unsigned long offset)
> +{
> +	return readl(chip->base + offset);
> +}
> +
> +static inline void sun20i_pwm_writel(struct sun20i_pwm_chip *chip,
> +				     u32 val, unsigned long offset)
> +{
> +	writel(val, chip->base + offset);
> +}
> +
> +static int sun20i_pwm_get_state(struct pwm_chip *chip,
> +				struct pwm_device *pwm,
> +				struct pwm_state *state)
> +{
> +	struct sun20i_pwm_chip *sun20i_chip =3D to_sun20i_pwm_chip(chip);
> +	u16 ent_cycle, act_cycle, prescal;
> +	u64 clk_rate, tmp;
> +	u8 div_id;
> +	u32 val;
> +
> +	mutex_lock(&sun20i_chip->mutex);
> +
> +	val =3D sun20i_pwm_readl(sun20i_chip, PWM_CLK_CFG(pwm->hwpwm));
> +	div_id =3D FIELD_GET(PWM_CLK_CFG_DIV_M, val);
> +	if (FIELD_GET(PWM_CLK_CFG_SRC, val) =3D=3D 0)
> +		clk_rate =3D clk_get_rate(sun20i_chip->clk_hosc);
> +	else
> +		clk_rate =3D clk_get_rate(sun20i_chip->clk_apb0);
> +
> +	val =3D sun20i_pwm_readl(sun20i_chip, PWM_CTL(pwm->hwpwm));
> +	state->polarity =3D (PWM_CTL_ACT_STA & val) ? PWM_POLARITY_NORMAL : PWM=
_POLARITY_INVERSED;
> +
> +	prescal =3D FIELD_GET(PWM_CTL_PRESCAL_K, val) + 1;
> +
> +	val =3D sun20i_pwm_readl(sun20i_chip, PWM_ENABLE);
> +	state->enabled =3D (PWM_ENABLE_EN(pwm->hwpwm) & val) ? true : false;
> +
> +	val =3D sun20i_pwm_readl(sun20i_chip, PWM_PERIOD(pwm->hwpwm));

You can release the lock already here (or even after PWM_ENABLE is
read?)

> +	act_cycle =3D FIELD_GET(PWM_PERIOD_ACT_CYCLE, val);
> +	ent_cycle =3D FIELD_GET(PWM_PERIOD_ENTIRE_CYCLE, val);
> +
> +	/*
> +	 * The duration of the active phase should not be longer
> +	 * than the duration of the period
> +	 */
> +	if (act_cycle > ent_cycle)
> +		act_cycle =3D ent_cycle;
> +
> +	tmp =3D ((u64)(act_cycle) * prescal << div_id) * NSEC_PER_SEC;

act_cycle is a 16 bit value, prescal is <=3D 256 and div_id is <=3D 15. So
the maximal value tmp has to hold is 0x1dcd47329b00000000. This doesn't
fit into an u64. You need something like mul_u64_u64_div64_roundup here.

> +	state->duty_cycle =3D DIV_ROUND_UP_ULL(tmp, clk_rate);
> +	tmp =3D ((u64)(ent_cycle) * prescal << div_id) * NSEC_PER_SEC;
> +	state->period =3D DIV_ROUND_UP_ULL(tmp, clk_rate);
> +	mutex_unlock(&sun20i_chip->mutex);
> +
> +	return 0;
> +}
> +
> +static int sun20i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pw=
m,
> +			    const struct pwm_state *state)
> +{
> +	struct sun20i_pwm_chip *sun20i_chip =3D to_sun20i_pwm_chip(chip);
> +	u32 clk_gate, clk_cfg, pwm_en, ctl, period;
> +	u64 bus_rate, hosc_rate, clk_div, val;
> +	u32 prescaler, div_m;
> +	bool use_bus_clk;
> +	int ret =3D 0;
> +
> +	mutex_lock(&sun20i_chip->mutex);
> +
> +	pwm_en =3D sun20i_pwm_readl(sun20i_chip, PWM_ENABLE);
> +
> +	if (state->enabled !=3D pwm->state.enabled)
> +		clk_gate =3D sun20i_pwm_readl(sun20i_chip, PWM_CLK_GATE);
> +
> +	if (state->enabled !=3D pwm->state.enabled && !state->enabled) {
> +		clk_gate &=3D ~PWM_CLK_GATE_GATING(pwm->hwpwm);
> +		pwm_en &=3D ~PWM_ENABLE_EN(pwm->hwpwm);
> +		sun20i_pwm_writel(sun20i_chip, pwm_en, PWM_ENABLE);
> +		sun20i_pwm_writel(sun20i_chip, clk_gate, PWM_CLK_GATE);

Does ENABLE configure if the output pin is driven?

> +	}

You can these to like:

	if (state->enabled !=3D pwm->state.enabled) {
		clk_gate =3D ...
		if (!state->enabled) {
			...
		}
	}

> +
> +	if (state->polarity !=3D pwm->state.polarity ||
> +	    state->duty_cycle !=3D pwm->state.duty_cycle ||
> +	    state->period !=3D pwm->state.period) {
> +		ctl =3D sun20i_pwm_readl(sun20i_chip, PWM_CTL(pwm->hwpwm));
> +		clk_cfg =3D sun20i_pwm_readl(sun20i_chip, PWM_CLK_CFG(pwm->hwpwm));
> +		hosc_rate =3D clk_get_rate(sun20i_chip->clk_hosc);
> +		bus_rate =3D clk_get_rate(sun20i_chip->clk_apb0);
> +		if (pwm_en & PWM_ENABLE_EN(pwm->hwpwm ^ 1)) {
> +			/* if the neighbor channel is enable, check period only */
> +			use_bus_clk =3D FIELD_GET(PWM_CLK_CFG_SRC, clk_cfg) !=3D 0;
> +			val =3D state->period * (use_bus_clk ? bus_rate : hosc_rate);

This can overflow.

> +			do_div(val, NSEC_PER_SEC);
> +
> +			div_m =3D FIELD_GET(PWM_CLK_CFG_DIV_M, clk_cfg);
> +		} else {
> +			/* check period and select clock source */
> +			use_bus_clk =3D false;
> +			val =3D state->period * hosc_rate;
> +			do_div(val, NSEC_PER_SEC);
> +			if (val <=3D 1) {
> +				use_bus_clk =3D true;
> +				val =3D state->period * bus_rate;
> +				do_div(val, NSEC_PER_SEC);
> +				if (val <=3D 1) {
> +					ret =3D -EINVAL;
> +					goto unlock_mutex;
> +				}
> +			}
> +			div_m =3D fls(DIV_ROUND_DOWN_ULL(val, PWM_MAGIC));
> +			if (div_m >=3D 9) {

What is 9 here? Something like DIV_M_MAX? There are a few other
constants that might deserve a name.

> +				ret =3D -EINVAL;
> +				goto unlock_mutex;
> +			}
> +
> +			/* set up the CLK_DIV_M and clock CLK_SRC */
> +			clk_cfg =3D FIELD_PREP(PWM_CLK_CFG_DIV_M, div_m);
> +			clk_cfg |=3D FIELD_PREP(PWM_CLK_CFG_SRC, use_bus_clk);
> +
> +			sun20i_pwm_writel(sun20i_chip, clk_cfg, PWM_CLK_CFG(pwm->hwpwm));
> +		}
> +
> +		/* calculate prescaler, PWM entire cycle */
> +		clk_div =3D val >> div_m;
> +		if (clk_div <=3D 65534) {
> +			prescaler =3D 0;
> +		} else {
> +			prescaler =3D DIV_ROUND_UP_ULL(clk_div - 65534, 65535);

This looks strange. The result is the same as
DIV_ROUND_DOWN_ULL(clk_div, 65535) which by the way also does the right
thing for clk_div <=3D 65534.

> +			if (prescaler >=3D 256) {
> +				ret =3D -EINVAL;
> +				goto unlock_mutex;

If this happens the requested period is too big, right? Please use

	prescaler =3D 255;

then and proceed. (The idea is to configure the biggest period that is
not bigger than the requested period.)

> +			}
> +			do_div(clk_div, prescaler + 1);
> +		}
> +
> +		period =3D FIELD_PREP(PWM_PERIOD_ENTIRE_CYCLE, clk_div);
> +
> +		/* set duty cycle */
> +		val =3D state->duty_cycle * (use_bus_clk ? bus_rate : hosc_rate);
> +		do_div(val, NSEC_PER_SEC);
> +		clk_div =3D val >> div_m;
> +		do_div(clk_div, prescaler + 1);
> +
> +		/*
> +		 * The formula of the output period and the duty-cycle for PWM are as =
follows.
> +		 * T period =3D (PWM01_CLK / PWM0_PRESCALE_K)^-1 * (PPR0.PWM_ENTIRE_CY=
CLE + 1)
> +		 * T high-level =3D (PWM01_CLK / PWM0_PRESCALE_K)^-1 * PPR0.PWM_ACT_CY=
CLE
> +		 * Duty-cycle =3D T high-level / T period
> +		 * In accordance with this formula, in order to set the duty-cycle to =
100%,
> +		 * it is necessary that PWM_ACT_CYCLE >=3D PWM_ENTIRE_CYCLE + 1
> +		 */
> +		if (state->duty_cycle =3D=3D state->period)
> +			clk_div++;

Can it happen, that clk_div gets too big here?

> +		period |=3D FIELD_PREP(PWM_PERIOD_ACT_CYCLE, clk_div);

It's a bit irritating (to me at least) that the variable "period" holds
the configuration for the duty_cycle. Maybe call it "reg_period" or
similar to not confuse it with state->period?

> +		sun20i_pwm_writel(sun20i_chip, period, PWM_PERIOD(pwm->hwpwm));
> +
> +		ctl =3D FIELD_PREP(PWM_CTL_PRESCAL_K, prescaler);
> +		if (state->polarity =3D=3D PWM_POLARITY_NORMAL)
> +			ctl |=3D PWM_CTL_ACT_STA;
> +
> +		sun20i_pwm_writel(sun20i_chip, ctl, PWM_CTL(pwm->hwpwm));

Is there a glitch if you switch polarity? i.e. after period is written a
few lines above, a new period starts already and if you then invert
PWM_CTL_ACT_STA, the output immediately switches polarity? If so that's
something to mention in the Limitations section.

> +	}
> +[...]
> +static int sun20i_pwm_probe(struct platform_device *pdev)
> +{
> +	struct sun20i_pwm_chip *sun20i_chip;
> +	int ret;
> +
> +	sun20i_chip =3D devm_kzalloc(&pdev->dev, sizeof(*sun20i_chip), GFP_KERN=
EL);
> +	if (!sun20i_chip)
> +		return -ENOMEM;
> +
> +	sun20i_chip->base =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(sun20i_chip->base))
> +		return PTR_ERR(sun20i_chip->base);
> +
> +	sun20i_chip->clk_bus =3D devm_clk_get_enabled(&pdev->dev, "bus");
> +	if (IS_ERR(sun20i_chip->clk_bus))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(sun20i_chip->clk_bus),
> +				     "failed to get bus clock\n");
> +
> +	sun20i_chip->clk_hosc =3D devm_clk_get_enabled(&pdev->dev, "hosc");
> +	if (IS_ERR(sun20i_chip->clk_hosc))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(sun20i_chip->clk_hosc),
> +				     "failed to get hosc clock\n");
> +
> +	sun20i_chip->clk_apb0 =3D devm_clk_get_enabled(&pdev->dev, "apb0");
> +	if (IS_ERR(sun20i_chip->clk_apb0))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(sun20i_chip->clk_apb0),
> +				     "failed to get apb0 clock\n");
> +
> +	sun20i_chip->rst =3D devm_reset_control_get_exclusive(&pdev->dev, NULL);
> +	if (IS_ERR(sun20i_chip->rst))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(sun20i_chip->rst),
> +				     "failed to get bus reset\n");
> +
> +	ret =3D of_property_read_u32(pdev->dev.of_node, "allwinner,pwm-channels=
",
> +				   &sun20i_chip->chip.npwm);
> +	if (ret)
> +		sun20i_chip->chip.npwm =3D 8;

The register layout allows npwm <=3D 16 only, right? I suggest to add a
check for that.

> +	/* Deassert reset */
> +	ret =3D reset_control_deassert(sun20i_chip->rst);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret, "failed to deassert reset\n");

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ird3aryfheitd4gg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmUMtJUACgkQj4D7WH0S
/k6azwgApTmUlNIYDGMXRNzNZSsgvR/Zfp6VrntxfPWuAllZmGSe6dr+QBl0W8Fc
qzzMN4oo4qsDu14JtqV2ku4knKmq+ZEsCPCVt4FTfSdnfEOzYKuohuiFJJ9HPDBz
0/d89Flu7df2VYlJKiFkWjl8zTFoNkG1/55HnGcOt9PkI8LnGiM8Qtfn70TrbL9L
s2Ck20qI8u4vLxjWPdK9oe1QGN5Ed+QlLiHk8vJPoaaPeuHZBte9zKiIrg+NMCHz
M54tvFtMmKmLUEPVTK3l7KqAVEBZ0WltjFcokCJQnEW171IlsmcQmFZuoah7ox56
aM41r7POmJuHoxj7znYzM73IMfmW3Q==
=8wCX
-----END PGP SIGNATURE-----

--ird3aryfheitd4gg--
