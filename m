Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 287AB76ABE7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 11:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbjHAJDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 05:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232299AbjHAJCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 05:02:18 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7AA213E
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 02:02:03 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qQlFi-0003XY-79; Tue, 01 Aug 2023 11:01:14 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 5AC192004E9;
        Tue,  1 Aug 2023 09:01:05 +0000 (UTC)
Date:   Tue, 1 Aug 2023 11:01:04 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Shenwei Wang <shenwei.wang@nxp.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Vinod Koul <vkoul@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Jose Abreu <joabreu@synopsys.com>, imx@lists.linux.dev,
        Simon Horman <simon.horman@corigine.com>,
        Frank Li <frank.li@nxp.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Fabio Estevam <festevam@gmail.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        Jerome Brunet <jbrunet@baylibre.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Wong Vee Khee <veekhee@apple.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Revanth Kumar Uppala <ruppala@nvidia.com>,
        Jochen Henneberg <jh@henneberg-systemdesign.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH v3 net 2/2] net: stmmac: dwmac-imx: pause the TXC clock
 in fixed-link
Message-ID: <20230801-casket-sterling-db0e49f154cf-mkl@pengutronix.de>
References: <20230731161929.2341584-1-shenwei.wang@nxp.com>
 <20230731161929.2341584-3-shenwei.wang@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="o4t5srmxt4zkvbfp"
Content-Disposition: inline
In-Reply-To: <20230731161929.2341584-3-shenwei.wang@nxp.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--o4t5srmxt4zkvbfp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 31.07.2023 11:19:29, Shenwei Wang wrote:
> When using a fixed-link setup, certain devices like the SJA1105 require a
> small pause in the TXC clock line to enable their internal tunable
> delay line (TDL).
>=20
> To satisfy this requirement, this patch temporarily disables the TX clock,
> and restarts it after a required period. This provides the required
> silent interval on the clock line for SJA1105 to complete the frequency
> transition and enable the internal TDLs.
>=20
> So far we have only enabled this feature on the i.MX93 platform.
>=20
> Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
> Reviewed-by: Frank Li <frank.li@nxp.com>
> ---
>  .../net/ethernet/stmicro/stmmac/dwmac-imx.c   | 42 +++++++++++++++++++
>  1 file changed, 42 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c b/drivers/ne=
t/ethernet/stmicro/stmmac/dwmac-imx.c
> index 53ee5a42c071..2e4173d099f3 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
> @@ -32,6 +32,7 @@
>  #define GPR_ENET_QOS_RGMII_EN		(0x1 << 21)
> =20
>  #define MX93_GPR_ENET_QOS_INTF_MODE_MASK	GENMASK(3, 0)
> +#define MX93_GPR_ENET_QOS_INTF_MASK		GENMASK(3, 1)
>  #define MX93_GPR_ENET_QOS_INTF_SEL_MII		(0x0 << 1)
>  #define MX93_GPR_ENET_QOS_INTF_SEL_RMII		(0x4 << 1)
>  #define MX93_GPR_ENET_QOS_INTF_SEL_RGMII	(0x1 << 1)
> @@ -40,6 +41,7 @@
>  #define DMA_BUS_MODE			0x00001000
>  #define DMA_BUS_MODE_SFT_RESET		(0x1 << 0)
>  #define RMII_RESET_SPEED		(0x3 << 14)
> +#define CTRL_SPEED_MASK			GENMASK(15, 14)
> =20
>  struct imx_dwmac_ops {
>  	u32 addr_width;
> @@ -56,6 +58,7 @@ struct imx_priv_data {
>  	struct regmap *intf_regmap;
>  	u32 intf_reg_off;
>  	bool rmii_refclk_ext;
> +	void __iomem *base_addr;
> =20
>  	const struct imx_dwmac_ops *ops;
>  	struct plat_stmmacenet_data *plat_dat;
> @@ -212,6 +215,42 @@ static void imx_dwmac_fix_speed(void *priv, uint spe=
ed, uint mode)
>  		dev_err(dwmac->dev, "failed to set tx rate %lu\n", rate);
>  }
> =20
> +static void imx_dwmac_fix_speed_mx93(void *priv, uint speed, uint mode)
> +{
> +	struct imx_priv_data *dwmac =3D priv;
> +	int ctrl, old_ctrl, iface;

regmap_read() wants a pointer to an "unsigned int".

> +
> +	imx_dwmac_fix_speed(priv, speed, mode);
> +
> +	if (!dwmac || mode !=3D MLO_AN_FIXED)
> +		return;
> +
> +	if (regmap_read(dwmac->intf_regmap, dwmac->intf_reg_off, &iface))
> +		return;
> +
> +	iface &=3D MX93_GPR_ENET_QOS_INTF_MASK;
> +	if (iface !=3D MX93_GPR_ENET_QOS_INTF_SEL_RGMII)
> +		return;
> +
> +	old_ctrl =3D readl(dwmac->base_addr + MAC_CTRL_REG);
> +	ctrl =3D old_ctrl & ~CTRL_SPEED_MASK;
> +	regmap_update_bits(dwmac->intf_regmap, dwmac->intf_reg_off,
> +			   MX93_GPR_ENET_QOS_INTF_MODE_MASK, 0);
> +	writel(ctrl, dwmac->base_addr + MAC_CTRL_REG);
> +
> +	/* Ensure the settings for CTRL are applied and avoid CPU/Compiler
> +	 * reordering.
> +	 */
> +	wmb();
> +
> +	usleep_range(10, 20);
> +	iface |=3D MX93_GPR_ENET_QOS_CLK_GEN_EN;
> +	regmap_update_bits(dwmac->intf_regmap, dwmac->intf_reg_off,
> +			   MX93_GPR_ENET_QOS_INTF_MODE_MASK, iface);
> +
> +	writel(old_ctrl, dwmac->base_addr + MAC_CTRL_REG);
> +}

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--o4t5srmxt4zkvbfp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmTIyc4ACgkQvlAcSiqK
BOhPxwf9HHFOUC0eUgsX05gNkklEhVe6d9mHGi+9XMQabv1kE7r0DR26UXTr1zJJ
7QEgBjYhAsV2UUZrvVOrkdfOlJeHUjNYw1SoCWXwhL12XS53cpTT6NFJubHX6FAz
qkyWpe9yJoplJv5iPw9ytKUnyfdv00/s1N3R0Xt6WPUsmvZBmdAKr+jAaIEhYNdS
G8C5mw4vSxM+C02gPgE0n6IRnjiH+FWGAfLsUbDQ5RtySwHCitWh9SSlhtp1SR0a
CYQMjQ/caR6IfLBhmdzTrRl3e7IfXQWoSYVERLNGIu3OnKKeqpe561OdnlxVOD6S
bO8xpuS/V3HwwpAnE3MNcNI7+IMjlw==
=3m5o
-----END PGP SIGNATURE-----

--o4t5srmxt4zkvbfp--
