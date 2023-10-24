Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 897817D4F27
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 13:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232755AbjJXLqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 07:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbjJXLqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 07:46:01 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10061E8
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 04:45:59 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qvFr8-0000Fe-N7; Tue, 24 Oct 2023 13:45:54 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qvFr5-003vwf-5s; Tue, 24 Oct 2023 13:45:51 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qvFr4-005Dz2-SD; Tue, 24 Oct 2023 13:45:50 +0200
Date:   Tue, 24 Oct 2023 13:45:45 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     William Qiu <william.qiu@starfivetech.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org,
        Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Hal Feng <hal.feng@starfivetech.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v6 2/4] pwm: opencores: Add PWM driver support
Message-ID: <20231024114545.73ljfceuon2blkxz@pengutronix.de>
References: <20231020103741.557735-1-william.qiu@starfivetech.com>
 <20231020103741.557735-3-william.qiu@starfivetech.com>
 <20231020112539.gctx5uj2rrhryulo@pengutronix.de>
 <b2ef7299-5d5a-4ef7-89fd-04b6130cb227@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="w2zicncd2z4lq4pb"
Content-Disposition: inline
In-Reply-To: <b2ef7299-5d5a-4ef7-89fd-04b6130cb227@starfivetech.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--w2zicncd2z4lq4pb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello William,

On Tue, Oct 24, 2023 at 05:16:49PM +0800, William Qiu wrote:
> On 2023/10/20 19:25, Uwe Kleine-K=F6nig wrote:
> > Hello,
> >=20
> > On Fri, Oct 20, 2023 at 06:37:39PM +0800, William Qiu wrote:
> >> Add Pulse Width Modulation driver support for OpenCores.
> >>=20
> >> Co-developed-by: Hal Feng <hal.feng@starfivetech.com>
> >> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> >> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> >> ---
> >>  MAINTAINERS              |   7 ++
> >>  drivers/pwm/Kconfig      |  11 ++
> >>  drivers/pwm/Makefile     |   1 +
> >>  drivers/pwm/pwm-ocores.c | 211 +++++++++++++++++++++++++++++++++++++++
> >>  4 files changed, 230 insertions(+)
> >>  create mode 100644 drivers/pwm/pwm-ocores.c
> >>=20
> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> index 6c4cce45a09d..321af8fa7aad 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -16003,6 +16003,13 @@ F:	Documentation/i2c/busses/i2c-ocores.rst
> >>  F:	drivers/i2c/busses/i2c-ocores.c
> >>  F:	include/linux/platform_data/i2c-ocores.h
> >>=20
> >> +OPENCORES PWM DRIVER
> >> +M:	William Qiu <william.qiu@starfivetech.com>
> >> +M:	Hal Feng <hal.feng@starfivetech.com>
> >> +S:	Supported
> >> +F:	Documentation/devicetree/bindings/pwm/opencores,pwm-ocores.yaml
> >> +F:	drivers/pwm/pwm-ocores.c
> >> +
> >>  OPENRISC ARCHITECTURE
> >>  M:	Jonas Bonn <jonas@southpole.se>
> >>  M:	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> >> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> >> index 8ebcddf91f7b..cbfbf227d957 100644
> >> --- a/drivers/pwm/Kconfig
> >> +++ b/drivers/pwm/Kconfig
> >> @@ -434,6 +434,17 @@ config PWM_NTXEC
> >>  	  controller found in certain e-book readers designed by the original
> >>  	  design manufacturer Netronix.
> >>=20
> >> +config PWM_OCORES
> >> +	tristate "Opencores PWM support"
> >> +	depends on HAS_IOMEM && OF
> >> +	depends on COMMON_CLK && RESET_CONTROLLER
> >=20
> > Would it make sense to add something like:
> >=20
> > 	depends on ARCH_SOMETHING || COMPILE_TEST
> >=20
> > here?
> >=20
> But there is no mention of architectural limitations in the OpenCores's
> specification.

I already guessed that. Still it probably makes no sense to enable that
option on most machines. The PWM device found in i.MX SoCs can
theoretically also be implemented on AT91 or S390x. In practice it
isn't, so there is a dependency on ARCH_MXC || COMPILE_TEST.

Consider the role of someone who does a kernel bump for a certain
machine (on one end of the spectrum) or a distribution kernel (on the
other end).

If you take a 6.5 x86_64 allmodconfig + COMPILE_TEST=3Dn and upgrade to
v6.6-rc7 and do an oldconfig, you get 90 questions[1].

Just looking quickly through this list, among them are:

	DRM support for Loongson Graphics (DRM_LOONGSON) [N/m/?] (NEW)=20
	Xilinx AXI DMAS Engine (XILINX_DMA) [N/m/y/?] (NEW)
	Clock driver for Renesas VersaClock 3 devices (COMMON_CLK_VC3) [N/m/y/?] (=
NEW)
	Realtek RT1017 SDCA Codec - SDW (SND_SOC_RT1017_SDCA_SDW) [N/m/?] (NEW)

I didn't check in detail and maybe one or the other is valid on x86_64,
but I'd be surprised if you find two that are sensible to enable on
x86_64 to support a real machine.

While I think Kconfig cannot be held responsible to only allow
generating "real world sensible" configurations, we should work a bit
harder to rule out the obvious violators and make it easy for people
configuring the kernel where sensible.

In my book it's better to have a too strong dependency at first for a
new driver (but allow it with COMPILE_TEST). Someone who as a device
needing that driver will find it out and speak up. However if you allow
to enable the driver everywhere, many people will disable the driver
(maybe using yes '' | make oldconfig), some will spend time to research
about this option to find which machines actually have such a device and
if the machine(s) they care about are in this set. This is a waste of
time and opportunities. (And note, this isn't only about people spending
time to decide if they enable or disable PWM_OCORES, this is also about
people who use yes '' because there are too many questions and so they
might miss the handful of useful ones.)

Best regards
Uwe

[1] measured using

	yes '' | make oldconfig

and counting the occurrences of "(NEW)".

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--w2zicncd2z4lq4pb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmU3rmQACgkQj4D7WH0S
/k5J/Qf+NrB4b444Ylur3Cvou63Nqg11EseoPk/INOD1fQCFZc/DgsqpNDFCfOcr
8Z+nDdgC1dDs024syUcHnjgMK0ssOP6qBTNJ0OKUpkk+kS+E0grO2U5iZcMGpLtc
e/ZMQ0fepTQ3PasKQdJ0PpgfMjkDVHTdEL9YwxW/RAm0IJsq7dwnRDQPVRtxrNlr
oRvKzcODshrZX2C+3FQqCCIVhk2oySokKzCRGC0RHA1kLSf1aujl8wIs7/d9jlcy
8dv/boJGK/pqtQFKHmtAYAqDC8KzbMiHNgdaOwLla+y+HrI74xsB18BXJM/zARW6
sHBLPQDsmP7NCAVB+pjYC+s9KbnJAg==
=FO4l
-----END PGP SIGNATURE-----

--w2zicncd2z4lq4pb--
