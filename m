Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69DD976BAFC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 19:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234426AbjHARTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 13:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232246AbjHARTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 13:19:09 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D3E2136;
        Tue,  1 Aug 2023 10:19:06 -0700 (PDT)
Received: from mercury (dyndsl-091-248-215-079.ewe-ip-backbone.de [91.248.215.79])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D2CB96606F8A;
        Tue,  1 Aug 2023 18:19:04 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1690910344;
        bh=JmWNk3Diy87M33B8/qg48ijXK4ta3WZHyEplai7DYaI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bhbFZ5yL8U86M4NFvrGhbmG/G7SLYNMhhWqB+buyo+Z7H6/TtpCd5vtaL5JzrFKAd
         Qa+vvP02GpJvICl9MWH6Q8FdEh9ZKgSNedTMYjYHmawl2ieWVxpayPmsSugU0/HZn0
         fVH9GQVjBo0Yoyn0ENC03i9gNxL7E+zsrClKQb6VuAZM7AoRB5qb8REq+Eysd+EoRk
         QDGZ6X00+h008iHhILOw4tLyK3kFPpXaLlEdBa7RDMVwfq5OxJBcwiO7KjAvL+GDzm
         jA3Z6FmPl0WtDKCIwaS3wVFOXFzYImZZBfsNx5hjoIHKIXckiN8bjSTq8oWrnHnhHx
         7AcGesXTi/0PA==
Received: by mercury (Postfix, from userid 1000)
        id BB3891062B88; Tue,  1 Aug 2023 19:19:02 +0200 (CEST)
Date:   Tue, 1 Aug 2023 19:19:02 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Elaine Zhang <zhangqing@rock-chips.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        kever.yang@rock-chips.com, heiko@sntech.de,
        linux-clk@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, huangtao@rock-chips.com
Subject: Re: [PATCH v2 2/3] dt-bindings: clock: rk3588: export PCLK_VO1GRF
 clk id
Message-ID: <20230801171902.42zjwdarh7jma5pl@mercury.elektranox.org>
References: <20230801074357.10770-1-zhangqing@rock-chips.com>
 <20230801074357.10770-3-zhangqing@rock-chips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lgnnwlnqehn6d4lc"
Content-Disposition: inline
In-Reply-To: <20230801074357.10770-3-zhangqing@rock-chips.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lgnnwlnqehn6d4lc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Aug 01, 2023 at 03:43:56PM +0800, Elaine Zhang wrote:
> add PCLK_VO1GRF clk id.
>=20
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> ---

Fixes: f204a60e545c ("dt-bindings: clock: add rk3588 clock definitions")
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

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
> =20
>  /* scmi-clocks indices */
> =20
> --=20
> 2.17.1
>=20

--lgnnwlnqehn6d4lc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmTJPnkACgkQ2O7X88g7
+pq0SA/8D5BwNKYQ1zyMBMxEg78h9su6o0/i2eyr05sjGRQh+BcFOkA3fdpIZshu
q0o/RL5ygIOOHbh7sq7dZ9Gcfm+YOgb1jWFLti+XLRILBrmZaNNtKQhCI/rbe2Tx
88oFQInz6mg7Qfu+Ge11kk0xorFFmPHRiGwyN6c+c7R2bzV3SCGS0qCpwUI5KLdl
vOPySBx5Z/+tObdF2fQmro4XtLGDDrihN4No+NXVIFje5qOfs8JUk0uoEXJsC19N
IQeatwjy1Z2EY6ezi6h/iK4HFl23kdqgW+nIthlyDq6TXLblaTMOR5+jI7hnINV3
BSFNJWldBSp/V7p7PDnhfU8vluJEHRTlrKoVp47bK3NL3eq/fKh7Uf6Fs4BCgNzJ
S8zd5rL/oDGBOqESlTBOCh3jYOXDNsaNjfolw3nWEbSvZixBhxtMciAotOoxUQc0
5lmwYb8jtzI63HWpC0+jGmyp9TocGKXE9hRCofJgJzMGQfeX9edQyd1JyEK5jRIY
sfvRLXF0e+cKduBn36G91I0VPrBE4CEzCWq5aA9hyQICJQ/RuV4iKOHMQsr6s1A8
EliSWQNbmfeXzy4gDfrCjeZ1oLKRlOQL2qSW5uUQmCtDX9pzwmjoNt/AXL+jH05n
viXHqSX9mYtyh3h9Z5JwpbWyio0lQ0h8xKZFxtfNeSe5zthgHjk=
=nkHN
-----END PGP SIGNATURE-----

--lgnnwlnqehn6d4lc--
