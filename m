Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4510757745
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 11:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbjGRJAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 05:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjGRJAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 05:00:31 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAEAFE4C
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 02:00:29 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qLgZI-0006qK-91; Tue, 18 Jul 2023 11:00:28 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qLgZG-000KZF-Sg; Tue, 18 Jul 2023 11:00:26 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qLgZG-005oLv-0G; Tue, 18 Jul 2023 11:00:26 +0200
Date:   Tue, 18 Jul 2023 11:00:23 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Randy Dunlap <rd.dunlab@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lee Jones <lee@kernel.org>
Subject: Re: [PATCH] pwm: fi pwm-rz-mtu3.c build errors
Message-ID: <20230718090023.wo6m6ffzaifgctkj@pengutronix.de>
References: <8a4de6c6-8d7c-a115-2a14-d264d6d28ccf@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7oh2zo6fvw2hzrdc"
Content-Disposition: inline
In-Reply-To: <8a4de6c6-8d7c-a115-2a14-d264d6d28ccf@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7oh2zo6fvw2hzrdc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Jul 17, 2023 at 10:59:02PM -0700, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
>=20
> When (MFD) RZ_MTU3=3Dm and PWM_RZ_MTU3=3Dy, there are numerous build erro=
rs:
>=20
> ld: vmlinux.o: in function `rz_mtu3_pwm_config':
> drivers/pwm/pwm-rz-mtu3.c:374: undefined reference to `rz_mtu3_disable'
> ld: drivers/pwm/pwm-rz-mtu3.c:377: undefined reference to `rz_mtu3_8bit_c=
h_write'
> ld: vmlinux.o: in function `rz_mtu3_pwm_write_tgr_registers':
> drivers/pwm/pwm-rz-mtu3.c:110: undefined reference to `rz_mtu3_16bit_ch_w=
rite'
> ld: vmlinux.o: in function `rz_mtu3_pwm_config':
> drivers/pwm/pwm-rz-mtu3.c:382: undefined reference to `rz_mtu3_8bit_ch_wr=
ite'
> ld: vmlinux.o: in function `rz_mtu3_pwm_write_tgr_registers':
> drivers/pwm/pwm-rz-mtu3.c:110: undefined reference to `rz_mtu3_16bit_ch_w=
rite'
> ld: drivers/pwm/pwm-rz-mtu3.c:111: undefined reference to `rz_mtu3_16bit_=
ch_write'
> ld: vmlinux.o: in function `rz_mtu3_pwm_config':
> drivers/pwm/pwm-rz-mtu3.c:397: undefined reference to `rz_mtu3_enable'
> ld: vmlinux.o: in function `rz_mtu3_pwm_disable':
> drivers/pwm/pwm-rz-mtu3.c:259: undefined reference to `rz_mtu3_8bit_ch_wr=
ite'
> ld: drivers/pwm/pwm-rz-mtu3.c:264: undefined reference to `rz_mtu3_disabl=
e'
> ld: vmlinux.o: in function `rz_mtu3_pwm_enable':
> drivers/pwm/pwm-rz-mtu3.c:230: undefined reference to `rz_mtu3_8bit_ch_wr=
ite'
> ld: drivers/pwm/pwm-rz-mtu3.c:234: undefined reference to `rz_mtu3_8bit_c=
h_write'
> ld: drivers/pwm/pwm-rz-mtu3.c:238: undefined reference to `rz_mtu3_enable'
> ld: vmlinux.o: in function `rz_mtu3_pwm_is_ch_enabled':
> drivers/pwm/pwm-rz-mtu3.c:155: undefined reference to `rz_mtu3_is_enabled'
> ld: drivers/pwm/pwm-rz-mtu3.c:162: undefined reference to `rz_mtu3_8bit_c=
h_read'
> ld: vmlinux.o: in function `rz_mtu3_pwm_read_tgr_registers':
> drivers/pwm/pwm-rz-mtu3.c:102: undefined reference to `rz_mtu3_16bit_ch_r=
ead'
> ld: drivers/pwm/pwm-rz-mtu3.c:102: undefined reference to `rz_mtu3_16bit_=
ch_read'
> ld: drivers/pwm/pwm-rz-mtu3.c:103: undefined reference to `rz_mtu3_16bit_=
ch_read'
> ld: vmlinux.o: in function `rz_mtu3_pwm_get_state':
> drivers/pwm/pwm-rz-mtu3.c:296: undefined reference to `rz_mtu3_8bit_ch_re=
ad'
>=20
> Modify the dependencies of PWM_RZ_MTU3 so that COMPILE_TEST is
> still allowed but PWM_RZ_MTU3 depends on RZ_MTU3 if it is being built
> but also allow the latter not to be built.
>=20
> Fixes: 254d3a727421 ("pwm: Add Renesas RZ/G2L MTU3a PWM driver")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>
> Cc: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: linux-pwm@vger.kernel.org

While testing here I hit another (unrelated) problem:

drivers/pinctrl/renesas/pinctrl-rzg2l.c: In function =E2=80=98rzg2l_gpio_fr=
ee=E2=80=99:
drivers/pinctrl/renesas/pinctrl-rzg2l.c:917:37: error: =E2=80=98struct gpio=
_chip=E2=80=99 has no member named =E2=80=98irq=E2=80=99
  917 |         virq =3D irq_find_mapping(chip->irq.domain, offset);
      |                                     ^~

Did someone address that one already? I guess PINCTRL_RZG2L should
select GPIOLIB_IRQCHIP. Also RZ_MTU3 should select MFD_CORE as I hit:

	aarch64-linux-gnu-ld: rz-mtu3.c:(.text+0x544): undefined reference to `mfd=
_remove_devices'

Commit 654c293e1687b31819f9bf1ac71b5a85a8053210 added RZ_MTU3 as bool,
and it's still bool in 254d3a72742. I think the problem started only
with b8b28b718ddd ("mfd: Add module build support for RZ/G2L MTU3a").

The patch looks fine, but the commit log needs some adaption.

The following patch would fix the build failure, too:

diff --git a/include/linux/mfd/rz-mtu3.h b/include/linux/mfd/rz-mtu3.h
index c5173bc06270..4f15c0dead60 100644
--- a/include/linux/mfd/rz-mtu3.h
+++ b/include/linux/mfd/rz-mtu3.h
@@ -151,7 +151,7 @@ struct rz_mtu3 {
 	void *priv_data;
 };
=20
-#if IS_ENABLED(CONFIG_RZ_MTU3)
+#if IS_REACHABLE(CONFIG_RZ_MTU3)
 static inline bool rz_mtu3_request_channel(struct rz_mtu3_channel *ch)
 {
 	mutex_lock(&ch->lock);


maybe doing that additionally is a good idea? (Well, not entirely sure
as the above setting then would result in a non-functioning PWM driver.
Maybe that's worse than a build failure?)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--7oh2zo6fvw2hzrdc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmS2VKYACgkQj4D7WH0S
/k5r4Qf/WPJW5a1+eaEyMYnF/9wG23kXGfsmgQP6c6rZDe3GkKYVCw41i+9ceMJ0
J6As+jEdrEiomf9S3i66eik76jYdzI8vTlTPTUdvBtMETrqmDEGoGZHNlqwDGotY
QrLlUfnf8vnNYGVk6WskAvfgHoPNn2dei/EdptTD1htty3FbUb45l/8L84i4cAof
cztJOBP/11zTte4Tx1z2l0nhCGtWfEEboqv/c90z7MrecamYkdpgxDoSallD2ckt
yfY2jUHRcBYm6AwdxeGAjB4jX8NMTaVsIE0ylZRfCX7dYtY2+tBM+uaAPVLTIwsu
d28eyGChibI5qbwjmQQLdAVISNKs4A==
=wk8g
-----END PGP SIGNATURE-----

--7oh2zo6fvw2hzrdc--
