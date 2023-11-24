Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC0797F73EA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 13:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbjKXMge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 07:36:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbjKXMgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 07:36:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B451B6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 04:36:39 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62F25C433C9;
        Fri, 24 Nov 2023 12:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700829399;
        bh=iBs/ElE00ZyViC4c51swbIBIFHOSqvLccbbeT1AqVhQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e4tHQasD1uiBgjppYsnvSsVLtBZ9TQ/izusSKXRVoWvDcvG0eAgkyQIZHqHQF94uo
         2swUm2B5piBcScLzvcZCI+8HS2Bm42aYhatjDrfqVBjsJa+tqiElsoXd9kDJxd3WWe
         8fZNN2/LuPaXYBjsN84OBryouoLRKQaQGQVNh7YMzz+6Ljkp2lWvgzq6TC+NcQScdc
         1hZS1y1XM8RFpGnA+sRtd/5cN6Z8JkZ+b2veHsJ/ZRVYxJtRSZuWZTtyDzhmyEkZaM
         a9a7gnwnC4HAuYKLPIg6jWciEdAgvft2rybjDAy/9WHSMa2J+R9P++vV4u0zy2Ypj/
         u08VbCLPORCjg==
Date:   Fri, 24 Nov 2023 12:36:32 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Nicolas Belin <nbelin@baylibre.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Remi Pommarel <repk@triplefau.lt>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-phy@lists.infradead.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v9 04/12] dt-bindings: phy:
 amlogic,g12a-mipi-dphy-analog: drop unneeded reg property and example
Message-ID: <20231124-felt-tip-everybody-f2a6836e52af@spud>
References: <20231124-amlogic-v6-4-upstream-dsi-ccf-vim3-v9-0-95256ed139e6@linaro.org>
 <20231124-amlogic-v6-4-upstream-dsi-ccf-vim3-v9-4-95256ed139e6@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rgdN8ghBXlvRBfQ2"
Content-Disposition: inline
In-Reply-To: <20231124-amlogic-v6-4-upstream-dsi-ccf-vim3-v9-4-95256ed139e6@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rgdN8ghBXlvRBfQ2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 24, 2023 at 09:41:15AM +0100, Neil Armstrong wrote:
> The amlogic,g12a-mipi-dphy-analog is a feature of the simple-mfd
> amlogic,meson-axg-hhi-sysctrl system control register zone which is an
> intermixed registers zone, thus it's very hard to define clear ranges for
> each SoC controlled features even if possible.
>=20
> The amlogic,g12a-mipi-dphy-analog was wrongly documented as an independent
> register range, which is not the reality, thus fix the bindings by droppi=
ng
> the reg property now it's referred from amlogic,meson-gx-hhi-sysctrl.yaml
> and documented as a subnode of amlogic,meson-axg-hhi-sysctrl.
>=20
> Also drop the unnecessary example, the top level bindings example should
> be enough.
>=20
> Fixes: 76ab79f9726c ("dt-bindings: phy: add Amlogic G12A Analog MIPI D-PH=
Y bindings")
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

I feel like I left a tag on this one before, but I can't remember.
Perhaps I missed the conclusion to the discussion to the discussion with
Rob about whether having "reg" was desirable that lead to a tag being
dropped?

> ---
>  .../bindings/phy/amlogic,g12a-mipi-dphy-analog.yaml          | 12 ------=
------
>  1 file changed, 12 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/phy/amlogic,g12a-mipi-dphy=
-analog.yaml b/Documentation/devicetree/bindings/phy/amlogic,g12a-mipi-dphy=
-analog.yaml
> index c8c83acfb871..81c2654b7e57 100644
> --- a/Documentation/devicetree/bindings/phy/amlogic,g12a-mipi-dphy-analog=
=2Eyaml
> +++ b/Documentation/devicetree/bindings/phy/amlogic,g12a-mipi-dphy-analog=
=2Eyaml
> @@ -16,20 +16,8 @@ properties:
>    "#phy-cells":
>      const: 0
> =20
> -  reg:
> -    maxItems: 1
> -
>  required:
>    - compatible
> -  - reg
>    - "#phy-cells"
> =20
>  additionalProperties: false
> -
> -examples:
> -  - |
> -    phy@0 {
> -          compatible =3D "amlogic,g12a-mipi-dphy-analog";
> -          reg =3D <0x0 0xc>;
> -          #phy-cells =3D <0>;
> -    };
>=20
> --=20
> 2.34.1
>=20

--rgdN8ghBXlvRBfQ2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZWCYzwAKCRB4tDGHoIJi
0kCXAP9TU7U/tv4849X5YXYCr5KDY41jG8O0rTLgEd5q1geeoQD9GC0EX/4K+IRA
uJv3CY2TNiiph0000bxb3dqFwAVvRQM=
=UdAc
-----END PGP SIGNATURE-----

--rgdN8ghBXlvRBfQ2--
