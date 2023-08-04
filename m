Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F12657704F0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 17:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbjHDPiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 11:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbjHDPiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 11:38:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D357649CB;
        Fri,  4 Aug 2023 08:38:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A92F6202B;
        Fri,  4 Aug 2023 15:38:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B15AC433C8;
        Fri,  4 Aug 2023 15:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691163495;
        bh=t4F+m0azHkadYsutPkh75iCV6olf/pJ7y0Pbspodwio=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s3LWYBXP0DQCJ8gWTRlGS+DLuDNG91JnVUqj6fIwyYQ+K/ZrE+Mf+5akzN9HDNSsM
         AlrELznaKCwhcSAZJBIdBxmoyVZYYz+BqXgKziIikEOcaTShqV9YhIuU/Qw+4xwOhV
         dP3KswXwcY3JV6Xpd9idcxJLE/sHQJye5zPAIqwIVMW1uMYllspZXdh6XBYwjVzvQa
         v3W9wiRmou7leVNioc8L1c1r+yrjoFid7gIEH7u+TptlFC4hBp+SU+dn4e4bBn5YX0
         P4y/DADmXFXhRTNNa5dDHRmSzILx1OsbjX62EzkrsdGyGqtNb3dHbc0A7OMRJGHpzH
         j6D+8RkWlFHtA==
Date:   Fri, 4 Aug 2023 16:38:10 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Elaine Zhang <zhangqing@rock-chips.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        kever.yang@rock-chips.com, heiko@sntech.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, huangtao@rock-chips.com
Subject: Re: [RESEND PATCH v3 3/4] dt-bindings: clock: rk3588: export
 PCLK_VO1GRF clk id
Message-ID: <20230804-colonial-balsamic-c97491ebec12@spud>
References: <20230804025101.28438-1-zhangqing@rock-chips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lK93WBiQtkbGzRv8"
Content-Disposition: inline
In-Reply-To: <20230804025101.28438-1-zhangqing@rock-chips.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lK93WBiQtkbGzRv8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 04, 2023 at 10:51:01AM +0800, Elaine Zhang wrote:
> add PCLK_VO1GRF clk id.
>=20
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> ---
>  include/dt-bindings/clock/rockchip,rk3588-cru.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/dt-bindings/clock/rockchip,rk3588-cru.h b/include/dt=
-bindings/clock/rockchip,rk3588-cru.h
> index b5616bca7b44..864a321ab362 100644
> --- a/include/dt-bindings/clock/rockchip,rk3588-cru.h
> +++ b/include/dt-bindings/clock/rockchip,rk3588-cru.h
> @@ -733,8 +733,9 @@
>  #define ACLK_AV1_PRE			718
>  #define PCLK_AV1_PRE			719
>  #define HCLK_SDIO_PRE			720
> +#define PCLK_VO1GRF			721
> =20
> -#define CLK_NR_CLKS			(HCLK_SDIO_PRE + 1)
> +#define CLK_NR_CLKS			(PCLK_VO1GRF + 1)

I only got this patch & not the rest of the series, so no idea what's
going in those patches, but since CLK_NR_CLKS was put in a dt-binding
header, is that value not now part of the ABI?

Thanks,
Conor.

> =20
>  /* scmi-clocks indices */
> =20
> --=20
> 2.17.1
>=20

--lK93WBiQtkbGzRv8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZM0bYgAKCRB4tDGHoIJi
0ivZAQCx292j0WpUPtQm1NKlAx/CxxoK2bk0EqWwWc0QshsvGwD/aj8I8l6Qv8Xn
VBq+pNEmZJBYuho1YQFAV5jlcDIbmAM=
=eTnE
-----END PGP SIGNATURE-----

--lK93WBiQtkbGzRv8--
