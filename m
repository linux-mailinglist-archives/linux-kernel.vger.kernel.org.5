Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1463F7792F0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 17:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236314AbjHKPXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 11:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235703AbjHKPXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 11:23:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB7BEA;
        Fri, 11 Aug 2023 08:23:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 31E5267502;
        Fri, 11 Aug 2023 15:23:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AACAC433C8;
        Fri, 11 Aug 2023 15:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691767397;
        bh=Ho1BktKQry1AwZyk/Ld1JPf/6FoMBAMsShd58BTrNlc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YVBghkm3FHPG5Dgi7xPj5oiBZy10jMZCVSWPzxepGH5oGgD5CI6TKwVI3GmKqRmvf
         0jzxjyG86cvwq4H5NmQ980iHTMwX6InwM5hUIYQDYJ3otzpwhyT9z/40/MYG9JW8T7
         CqyApFfDatLO+aX2PXNJLwZriAANUThq71KZex+mN3R+UDc+5vTjLEoIzgijLLbo+q
         3P0gS1tmH40C0XyFr0nGjngIoOcFvYUz6MLgTZx1ON4Cb5OHawplAbh3035tLjjOuf
         Az9rFgHUDBAUoaCLLcveUKz75BAknEt1bE43oUl3rrrIXDmaUY/uOWChyZ/gQQC6eC
         PZdYf1PZtOtNw==
Date:   Fri, 11 Aug 2023 16:23:11 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Martin Botka <martin.botka@somainline.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Andre Przywara <andre.przywara@arm.com>,
        Alan Ma <tech@biqu3d.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: [PATCH 1/3] dt-bindings: nvmem: SID: Add binding for H616 SID
 controller
Message-ID: <20230811-slighted-myspace-2088c599a53b@spud>
References: <20230811-sid-h616-v1-0-d1dfc9f47b19@somainline.org>
 <20230811-sid-h616-v1-1-d1dfc9f47b19@somainline.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="skCicSOVDML5Sf8Z"
Content-Disposition: inline
In-Reply-To: <20230811-sid-h616-v1-1-d1dfc9f47b19@somainline.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--skCicSOVDML5Sf8Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 11, 2023 at 01:02:34PM +0200, Martin Botka wrote:
> Add binding for the SID controller found in H616 SoC
>=20
> Signed-off-by: Martin Botka <martin.botka@somainline.org>
> ---
>  Documentation/devicetree/bindings/nvmem/allwinner,sun4i-a10-sid.yaml | 1=
 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/nvmem/allwinner,sun4i-a10-=
sid.yaml b/Documentation/devicetree/bindings/nvmem/allwinner,sun4i-a10-sid.=
yaml
> index 296001e7f498..2ec0a1b8f803 100644
> --- a/Documentation/devicetree/bindings/nvmem/allwinner,sun4i-a10-sid.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/allwinner,sun4i-a10-sid.yaml
> @@ -27,6 +27,7 @@ properties:
>            - const: allwinner,sun50i-a64-sid
>        - const: allwinner,sun50i-h5-sid
>        - const: allwinner,sun50i-h6-sid
> +      - const: allwinner,sun50i-h616-sid

As said by Andre, use a fallback compatible here please.

--skCicSOVDML5Sf8Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZNZSXwAKCRB4tDGHoIJi
0kBCAP9zXkJ4jN0+tQ7P1THKt+PtDQXtC47DGTP/gGOWjeNXjgD/b/NbHCPvvTJB
vCrrdNEoyjUoxosmfi7845LpJGT/ygI=
=BWTm
-----END PGP SIGNATURE-----

--skCicSOVDML5Sf8Z--
