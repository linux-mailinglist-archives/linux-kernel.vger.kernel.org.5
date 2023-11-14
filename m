Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CDE57EB5CB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 18:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233865AbjKNRrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 12:47:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbjKNRrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 12:47:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 616A6110
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 09:47:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CAAAC433CA;
        Tue, 14 Nov 2023 17:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699984058;
        bh=D9KzSEK2MNUlw54aT4akCNMjbWc04nlocOCzra8qnEs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZVNPcPm9Kvz2KPrx2w7zth7Hu6Ge58GrV2+G/LwiEnMdI6P+da59r2GZoYtlJfeiY
         mki4tmtRxIRX7AvZ7KBfDEFi7Ewxyw2d6AwEmJe9WRhvL+lzD0L7cGThdr2tUI3t/l
         RGl86ZwmnWSkG6WDi5avj/bP6gLQk3Tim7eh7hwHLW/LT058UQo5ngvoyH4nt29Cbo
         ozUtdZU1OIYMSD2R6iDEbmA0dh3twWaCg44U7vwfWa2PH6S7mNjqdCSZEY051w9LOj
         itJK1ErevAMpwf7xCFoej/TtvpDeAZKoYW700O4x+3GkQVQGZnPn1F0iD24wsbxYjY
         Bd3FOvB/Q5LCw==
Date:   Tue, 14 Nov 2023 17:47:34 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Daniel Scally <dan.scally@ideasonboard.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] dt-bindings: clock: g12a-clkc: add MIPI ISP & CSI
 PHY clock ids
Message-ID: <20231114-lash-singer-ddf33f11bc4c@squawk>
References: <20231114-topic-amlogic-upstream-isp-clocks-v1-0-223958791501@linaro.org>
 <20231114-topic-amlogic-upstream-isp-clocks-v1-1-223958791501@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Mg1UK2b3qj7ouDpz"
Content-Disposition: inline
In-Reply-To: <20231114-topic-amlogic-upstream-isp-clocks-v1-1-223958791501@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Mg1UK2b3qj7ouDpz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 14, 2023 at 11:14:43AM +0100, Neil Armstrong wrote:
> Add MIPI ISP & CSI PHY clock ids to G12A clock bindings header
>=20
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor,

> ---
>  include/dt-bindings/clock/g12a-clkc.h | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/include/dt-bindings/clock/g12a-clkc.h b/include/dt-bindings/=
clock/g12a-clkc.h
> index 636d713f95ff..fd09819da2ec 100644
> --- a/include/dt-bindings/clock/g12a-clkc.h
> +++ b/include/dt-bindings/clock/g12a-clkc.h
> @@ -281,5 +281,11 @@
>  #define CLKID_MIPI_DSI_PXCLK			270
>  #define CLKID_CTS_ENCL				271
>  #define CLKID_CTS_ENCL_SEL			272
> +#define CLKID_MIPI_ISP_DIV			273
> +#define CLKID_MIPI_ISP_SEL			274
> +#define CLKID_MIPI_ISP				275
> +#define CLKID_MIPI_ISP_GATE			276
> +#define CLKID_MIPI_ISP_CSI_PHY0			277
> +#define CLKID_MIPI_ISP_CSI_PHY1			278
> =20
>  #endif /* __G12A_CLKC_H */
>=20
> --=20
> 2.34.1
>=20

--Mg1UK2b3qj7ouDpz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZVOysgAKCRB4tDGHoIJi
0hqQAP4hX+8A/W3JLgzC4C6VHY0eRmE1mwCTvgaeXnGFdMFyggEA0jDMrTecaNnW
13R4LiJbI3EwIg6VMuKZ9z0Plz5r2g4=
=wOqs
-----END PGP SIGNATURE-----

--Mg1UK2b3qj7ouDpz--
