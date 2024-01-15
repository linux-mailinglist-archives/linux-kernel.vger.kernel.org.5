Return-Path: <linux-kernel+bounces-26498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4288782E227
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 22:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5520B1C22235
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 21:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E3A1B277;
	Mon, 15 Jan 2024 21:18:21 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AD61B270
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 21:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rPULS-0000Ix-3d; Mon, 15 Jan 2024 22:18:10 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rPULQ-0006FH-R8; Mon, 15 Jan 2024 22:18:08 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rPULQ-000PRz-2Q;
	Mon, 15 Jan 2024 22:18:08 +0100
Date: Mon, 15 Jan 2024 22:18:04 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Trevor Gamblin <tgamblin@baylibre.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	michael.hennerich@analog.com, nuno.sa@analog.com, devicetree@vger.kernel.org, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Subject: Re: [PATCH 2/2] pwm: Add driver for AXI PWM generator
Message-ID: <gbessnmierg5gvdguhwauoe2mxr3krwcfk2afhazrqvz45md64@itbchezepncg>
References: <20240115201222.1423626-1-tgamblin@baylibre.com>
 <20240115201222.1423626-3-tgamblin@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tx74ann2b5ciakvj"
Content-Disposition: inline
In-Reply-To: <20240115201222.1423626-3-tgamblin@baylibre.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--tx74ann2b5ciakvj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Jan 15, 2024 at 03:12:21PM -0500, Trevor Gamblin wrote:
> From: Drew Fustini <dfustini@baylibre.com>
>=20
> Add support for the Analog Devices AXI PWM Generator. This device is an
> FPGA-implemented peripheral used as PWM signal generator and can be
> interfaced with AXI4. The register map of this peripheral makes it
> possible to configure the period and duty cycle of the output signal.
>=20
> Link: https://wiki.analog.com/resources/fpga/docs/axi_pwm_gen
> Co-developed-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> Co-developed-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Drew Fustini <dfustini@baylibre.com>
> Co-developed-by: Trevor Gamblin <tgamblin@baylibre.com>
> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
> ---
>  MAINTAINERS                  |   1 +
>  drivers/pwm/Kconfig          |  12 ++
>  drivers/pwm/Makefile         |   1 +
>  drivers/pwm/pwm-axi-pwmgen.c | 229 +++++++++++++++++++++++++++++++++++
>  4 files changed, 243 insertions(+)
>  create mode 100644 drivers/pwm/pwm-axi-pwmgen.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7b0f3aec5381..3abe90dec82e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3422,6 +3422,7 @@ L:	linux-pwm@vger.kernel.org
>  S:	Supported
>  W:	https://ez.analog.com/linux-software-drivers
>  F:	Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml
> +F:	drivers/pwm/pwm-axi-pwmgen.c
> =20
>  AXXIA I2C CONTROLLER
>  M:	Krzysztof Adamski <krzysztof.adamski@nokia.com>
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 4b956d661755..b105c0db4936 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -98,6 +98,18 @@ config PWM_ATMEL_TCB
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-atmel-tcb.
> =20
> +config PWM_AXI_PWMGEN
> +	tristate "Analog Devices AXI PWM generator"
> +	select REGMAP_MMIO

Assuming you won't find the device on all machines, can you please add a
reasonable dependency to not annoy users?

> +	help
> +	  This enables support for the Analog Devices AXI PWM generator.
> +
> +	  This is a configurable PWM generator with variable pulse width and
> +	  period.
> +
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called pwm-axi-pwmgen.
> +
>  config PWM_BCM_IPROC
>  	tristate "iProc PWM support"
>  	depends on ARCH_BCM_IPROC || COMPILE_TEST
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index c5ec9e168ee7..8322089954e9 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -6,6 +6,7 @@ obj-$(CONFIG_PWM_APPLE)		+=3D pwm-apple.o
>  obj-$(CONFIG_PWM_ATMEL)		+=3D pwm-atmel.o
>  obj-$(CONFIG_PWM_ATMEL_HLCDC_PWM)	+=3D pwm-atmel-hlcdc.o
>  obj-$(CONFIG_PWM_ATMEL_TCB)	+=3D pwm-atmel-tcb.o
> +obj-$(CONFIG_PWM_AXI_PWMGEN)	+=3D pwm-axi-pwmgen.o
>  obj-$(CONFIG_PWM_BCM_IPROC)	+=3D pwm-bcm-iproc.o
>  obj-$(CONFIG_PWM_BCM_KONA)	+=3D pwm-bcm-kona.o
>  obj-$(CONFIG_PWM_BCM2835)	+=3D pwm-bcm2835.o
> diff --git a/drivers/pwm/pwm-axi-pwmgen.c b/drivers/pwm/pwm-axi-pwmgen.c
> new file mode 100644
> index 000000000000..5e91636b88b4
> --- /dev/null
> +++ b/drivers/pwm/pwm-axi-pwmgen.c
> @@ -0,0 +1,229 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Analog Devices AXI PWM generator
> + *
> + * Copyright 2024 Analog Devices Inc.
> + * Copyright 2024 Baylibre SAS
> + */
> +#include <linux/bits.h>
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +
> +#define AXI_PWMGEN_NPWM			4
> +#define AXI_PWMGEN_REG_CORE_VERSION	0x00
> +#define AXI_PWMGEN_REG_ID		0x04
> +#define AXI_PWMGEN_REG_SCRATCHPAD	0x08
> +#define AXI_PWMGEN_REG_CORE_MAGIC	0x0C
> +#define AXI_PWMGEN_REG_CONFIG		0x10
> +#define AXI_PWMGEN_REG_NPWM		0x14
> +#define AXI_PWMGEN_CH_PERIOD_BASE	0x40
> +#define AXI_PWMGEN_CH_DUTY_BASE		0x44
> +#define AXI_PWMGEN_CH_OFFSET_BASE	0x48
> +#define AXI_PWMGEN_CHX_PERIOD(ch)	(AXI_PWMGEN_CH_PERIOD_BASE + (12 * (ch=
)))
> +#define AXI_PWMGEN_CHX_DUTY(ch)		(AXI_PWMGEN_CH_DUTY_BASE + (12 * (ch)))
> +#define AXI_PWMGEN_CHX_OFFSET(ch)	(AXI_PWMGEN_CH_OFFSET_BASE + (12 * (ch=
)))

I'd drop the name AXI_PWMGEN_CH_PERIOD_BASE and just hard code it in the
definition of AXI_PWMGEN_CHX_PERIOD. Ditto for the two other macros.

> +#define AXI_PWMGEN_TEST_DATA		0x5A0F0081

Is this a documented constant, or just a random (as in xkcd#221) value?

> +#define AXI_PWMGEN_LOAD_CONFIG		BIT(1)
> +#define AXI_PWMGEN_RESET		BIT(0)
> +#define AXI_PWMGEN_MAX_REGISTER		0x6C
> +
> +struct axi_pwmgen {
> +	struct pwm_chip		chip;
> +	struct clk		*clk;
> +	struct regmap		*regmap;
> +
> +	/* Used to store the period when the channel is disabled */
> +	unsigned int		ch_period[AXI_PWMGEN_NPWM];
> +	bool			ch_enabled[AXI_PWMGEN_NPWM];
> +};

I'm not a fan of this alignment. If you don't have a strong opinion here
please just use a single space here. (I would expect you to not have a
strong opinion as other structs in this driver are not aligned in this
way.)

> +
> +static const struct regmap_config axi_pwm_regmap_config =3D {
> +	.reg_bits =3D 32,
> +	.reg_stride =3D 4,
> +	.val_bits =3D 32,
> +	.max_register =3D AXI_PWMGEN_MAX_REGISTER,
> +};
> +
> +static struct axi_pwmgen *to_axi_pwmgen(struct pwm_chip *chip)

I'm a big fan of common symbol prefixes. I suggest to rename
axi_pwm_regmap_config to axi_pwmgen_regmap_config and to_axi_pwmgen to
axi_pwmgen_from_chip.

> +{
> +	return container_of(chip, struct axi_pwmgen, chip);
> +}
> +
> +static int axi_pwmgen_apply(struct pwm_chip *chip, struct pwm_device *de=
vice,
> +			    const struct pwm_state *state)
> +{
> +	struct axi_pwmgen *pwm =3D to_axi_pwmgen(chip);

Please pick a different name. "pwm" is reserved for pwm_device
variables. (And please use it for these.) A typical name would be
"ddata", or "pc" or "apg". (Maybe also rename axi_pwmgen to
axi_pwmgen_ddata?)

> +	unsigned long clk_rate_hz =3D clk_get_rate(pwm->clk);
> +	unsigned int ch =3D device->hwpwm;
> +	struct regmap *regmap =3D pwm->regmap;
> +	u64 period_cnt, duty_cnt;
> +	int ret;

You didn't check for state->polarity. You should however. Also
=2Eget_state() needs to assign that one.

> +	if (!clk_rate_hz)
> +		return -EINVAL;
> +
> +	period_cnt =3D DIV_ROUND_UP_ULL(state->period * clk_rate_hz, NSEC_PER_S=
EC);

The multiplication might overflow. Please use mul_u64_u64_div_u64() (or
one of its variant) and error out on clk_rate_hz > NSEC_PER_SEC.

Also round-up is wrong. I would expect that enabling PWM_DEBUG and
enough testing should tell you that. .apply is supposed to implement the
biggest period not bigger than the requested one. So you have to round
down here.

> +	if (period_cnt > UINT_MAX)
> +		return -EINVAL;

That's wrong. Please continue with period_cnd =3D UINT_MAX here.

Instead you should probably error out on period_cnt =3D=3D 0.

> +	pwm->ch_period[ch] =3D period_cnt;
> +	pwm->ch_enabled[ch] =3D state->enabled;
> +	ret =3D regmap_write(regmap, AXI_PWMGEN_CHX_PERIOD(ch), state->enabled =
? period_cnt : 0);
> +	if (ret)
> +		return ret;
> +
> +	duty_cnt =3D DIV_ROUND_UP_ULL(state->duty_cycle * clk_rate_hz, NSEC_PER=
_SEC);
> +	ret =3D regmap_write(regmap, AXI_PWMGEN_CHX_DUTY(ch), duty_cnt);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_write(regmap, AXI_PWMGEN_REG_CONFIG, AXI_PWMGEN_LOAD_CONF=
IG);

I assume this means that the writes above are to shadow registers and on
this write they are latched into the hardware. So there is no glitch?!

Does this wait for the currently running period to complete before
switching to the new configuration?

Please document these two hardware properties in a "Limitations"
paragraph at the top of the driver. See other drivers for the format.

> +}
> +
> +static int axi_pwmgen_get_state(struct pwm_chip *chip, struct pwm_device=
 *device,
> +				struct pwm_state *state)
> +{
> +	struct axi_pwmgen *pwm =3D to_axi_pwmgen(chip);
> +	unsigned long clk_rate_hz =3D clk_get_rate(pwm->clk);
> +	struct regmap *regmap =3D pwm->regmap;
> +	unsigned int ch =3D device->hwpwm;
> +	u32 cnt;
> +	int ret;
> +
> +	if (!clk_rate_hz) {
> +		dev_err(device->chip->dev, "axi pwm clock has no frequency\n");
> +		return -EINVAL;
> +	}
> +
> +	state->enabled =3D pwm->ch_enabled[ch];
> +
> +	if (state->enabled) {
> +		ret =3D regmap_read(regmap, AXI_PWMGEN_CHX_PERIOD(ch), &cnt);
> +		if (ret)
> +			return ret;
> +	} else {
> +		cnt =3D pwm->ch_period[ch];
> +	}

If state->enabled is false, state->period is (or should) be ignored by
the caller, so there shouldn't be a need to track ch_period.

Also ch_enabled shouldn't be needed. Just reporting
AXI_PWMGEN_CHX_PERIOD(ch) =3D=3D 0 as disabled should work fine?!

I think then you also don't need to artificially limit npwm to four.

> +	state->period =3D DIV_ROUND_CLOSEST_ULL((u64)cnt * NSEC_PER_SEC, clk_ra=
te_hz);

As feeding the result for .get_state() to .apply() should not modify the
hardware state, you have to round up here.

> +	ret =3D regmap_read(regmap, AXI_PWMGEN_CHX_DUTY(ch), &cnt);
> +	if (ret)
> +		return ret;
> +
> +	state->duty_cycle =3D DIV_ROUND_CLOSEST_ULL((u64)cnt * NSEC_PER_SEC, cl=
k_rate_hz);

ditto.

> +	return 0;
> +}
> +
> +static const struct pwm_ops axi_pwmgen_pwm_ops =3D {
> +	.apply =3D axi_pwmgen_apply,
> +	.get_state =3D axi_pwmgen_get_state,
> +};
> +
> +static int axi_pwmgen_setup(struct axi_pwmgen *pwm, struct device *dev)
> +{
> +	struct regmap *regmap =3D pwm->regmap;
> +	int idx;
> +	int ret;
> +	u32 val;
> +
> +	ret =3D regmap_write(regmap, AXI_PWMGEN_REG_SCRATCHPAD, AXI_PWMGEN_TEST=
_DATA);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_read(regmap, AXI_PWMGEN_REG_SCRATCHPAD, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (val !=3D AXI_PWMGEN_TEST_DATA)
> +		return dev_err_probe(dev, -EIO, "failed to access the device registers=
\n");
> +
> +	ret =3D regmap_read(regmap, AXI_PWMGEN_REG_NPWM, &pwm->chip.npwm);
> +	if (ret)
> +		return ret;
> +
> +	if (pwm->chip.npwm > AXI_PWMGEN_NPWM) {
> +		dev_warn(dev, "driver is limited to %d channels but hardware reported =
%u\n",
> +				AXI_PWMGEN_NPWM, pwm->chip.npwm);
> +		pwm->chip.npwm =3D AXI_PWMGEN_NPWM;
> +	}
> +
> +	/* Disable all the outputs */

Please don't. If the bootloader setup a splash screen, loading the pwm
driver shouldn't disable the backlight. So please don't touch the
configuration in .probe().

> +	for (idx =3D 0; idx < pwm->chip.npwm; idx++) {
> +		ret =3D regmap_write(regmap, AXI_PWMGEN_CHX_PERIOD(idx), 0);
> +		if (ret)
> +			return ret;
> +
> +		ret =3D regmap_write(regmap, AXI_PWMGEN_CHX_DUTY(idx), 0);
> +		if (ret)
> +			return ret;
> +
> +		ret =3D regmap_write(regmap, AXI_PWMGEN_CHX_OFFSET(idx), 0);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	/* Enable the core */
> +	return regmap_update_bits(regmap, AXI_PWMGEN_REG_CONFIG, AXI_PWMGEN_RES=
ET, 0);
> +}
> +
> +static int axi_pwmgen_probe(struct platform_device *pdev)
> +{
> +	struct axi_pwmgen *pwm;
> +	void __iomem *io_base;
> +	int ret;
> +
> +	pwm =3D devm_kzalloc(&pdev->dev, sizeof(*pwm), GFP_KERNEL);
> +	if (!pwm)
> +		return -ENOMEM;
> +
> +	io_base =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(io_base))
> +		return PTR_ERR(io_base);
> +
> +	pwm->regmap =3D devm_regmap_init_mmio(&pdev->dev, io_base, &axi_pwm_reg=
map_config);
> +	if (IS_ERR(pwm->regmap))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(pwm->regmap),
> +				     "failed to init register map\n");
> +
> +	pwm->clk =3D devm_clk_get_enabled(&pdev->dev, NULL);
> +	if (IS_ERR(pwm->clk))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(pwm->clk), "failed to get clo=
ck\n");

Please call clk_rate_exclusive_get() on pwm->clk and cache the rate in
struct axi_pwmgen.

> +	pwm->chip.dev =3D &pdev->dev;
> +	pwm->chip.ops =3D &axi_pwmgen_pwm_ops;
> +	pwm->chip.base =3D -1;

Don't assign .base.

> +
> +	ret =3D axi_pwmgen_setup(pwm, &pdev->dev);
> +	if (ret < 0)
> +		return ret;
> +
> +	return devm_pwmchip_add(&pdev->dev, &pwm->chip);
> +}
> +
> +static const struct of_device_id axi_pwmgen_ids[] =3D {
> +	{ .compatible =3D "adi,axi-pwmgen-1.00.a" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, axi_pwmgen_ids);
> +
> +static struct platform_driver axi_pwmgen_driver =3D {
> +	.driver =3D {
> +		.name =3D "axi-pwmgen",
> +		.of_match_table =3D axi_pwmgen_ids,
> +	},
> +	.probe =3D axi_pwmgen_probe,
> +};
> +

Drop this empty line.

> +module_platform_driver(axi_pwmgen_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Sergiu Cuciurean <sergiu.cuciurean@analog.com>");
> +MODULE_DESCRIPTION("Driver for the Analog Devices AXI PWM generator");

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--tx74ann2b5ciakvj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmWloQsACgkQj4D7WH0S
/k4XNwf+LaA/Rztj4bxdTeyCwVjj2DybwiI4EVDVrHmafVlK9E4oTnIm15gREru/
0GVon1F2izw10EvlcEBsuW8fI/MNWhgqooHt2RIrhN9sTjiYkmC21eSwZ5vhTM8b
ww43oQKvSXtiKcLkwdLybhVBzS1DgZkWfoePC2zYJ/NMVBkYS1kHuaUHBX22BUhS
9eKW82FkpGMs/hvim7yf4RlolDe4/NykegdCsFuZqOIpadwgrQ2nB0IQ0som8EPg
z7sbilsd4hnRD1BGa0d7F/wMvnS8HH/2yHPRyj+zZ6/pzKDIMlr4XIx436SKj26N
WhHlpBXfGbV9YQdFdtyP7vYz0HjaKQ==
=x9+i
-----END PGP SIGNATURE-----

--tx74ann2b5ciakvj--

