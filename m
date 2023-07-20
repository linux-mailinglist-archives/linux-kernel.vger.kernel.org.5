Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6E175B552
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 19:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbjGTRPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 13:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbjGTRPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 13:15:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7685CC;
        Thu, 20 Jul 2023 10:15:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 76B6261B96;
        Thu, 20 Jul 2023 17:15:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 352C9C433C8;
        Thu, 20 Jul 2023 17:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689873313;
        bh=ET31mwyz8ENBzo1vwjozUVlTwzWSAqtf8fiKYTqRh7Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RsI6fXf7C/scCLMmoJzywfGyILzDHm5wWi1n1efuqOsXKJMcd+9inmo3OgJGymOQ4
         ON3ZTUXTWIZKhHtwx1+WqR87PNzu/kBA1xSq41EsGZPjIXqDxmCWvKlQF62WIUeyo+
         /IKDWyjnc1blGA96q0pFRxFPb+KPqG1nrAw+tCKb015vOwghv4DM/2pDAvZo3Gjd/K
         Eynaj7BasQuliCVBn4hLwJhP4+rnlT12XzpFWNwp6c3LVu/hTwRslkZjjUGLgvrbSS
         WinquvM67o0cfJtBHnc8lrxH+wSwglWhRfO/4o6E4pxXqSC+UfSvl3ja1JJMRgGO4W
         ZmFplUYkj8YAA==
Date:   Thu, 20 Jul 2023 18:15:07 +0100
From:   Conor Dooley <conor@kernel.org>
To:     James Hilliard <james.hilliard1@gmail.com>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marek Vasut <marex@denx.de>,
        Stefan Wahren <stefan.wahren@chargebyte.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Li Yang <leoyang.li@nxp.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 3/4] dt-bindings: arm: fsl: Add VAR-SOM-MX6 Custom
 Board
Message-ID: <20230720-tall-deflation-80e27d380080@spud>
References: <20230720131028.3730704-1-james.hilliard1@gmail.com>
 <20230720131028.3730704-3-james.hilliard1@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="L26M8otvcO/6c8t9"
Content-Disposition: inline
In-Reply-To: <20230720131028.3730704-3-james.hilliard1@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--L26M8otvcO/6c8t9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 20, 2023 at 07:10:24AM -0600, James Hilliard wrote:
> Add support for Variscite i.MX6Q VAR-SOM-MX6 Custom Board.
>=20
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentati=
on/devicetree/bindings/arm/fsl.yaml
> index a3ab78429799..010601da6c5b 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -298,6 +298,7 @@ properties:
>                - udoo,imx6q-udoo           # Udoo i.MX6 Quad Board
>                - uniwest,imx6q-evi         # Uniwest Evi
>                - variscite,dt6customboard
> +              - variscite,mx6customboard
>                - variscite,var-som-imx6q   # i.MX6 Quad Variscite VAR-SOM=
-MX6 module
>                - wand,imx6q-wandboard      # Wandboard i.MX6 Quad Board
>                - ysoft,imx6q-yapp4-crux    # i.MX6 Quad Y Soft IOTA Crux =
board
> --=20
> 2.34.1
>=20

--L26M8otvcO/6c8t9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZLlrmwAKCRB4tDGHoIJi
0gSmAP46aCfZpj/wBjZ4R/STljCwTXXqC8mIW76hhCfGFnnGdgEAiX6b9dvbvCVQ
/04QA6LD3OVLTSVwIy2GJEjnbKl9hgU=
=gpM1
-----END PGP SIGNATURE-----

--L26M8otvcO/6c8t9--
