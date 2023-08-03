Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFFF676EDF5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 17:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237059AbjHCPV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 11:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237053AbjHCPVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 11:21:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5703010EA;
        Thu,  3 Aug 2023 08:21:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B72F261DF4;
        Thu,  3 Aug 2023 15:21:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A98EC433C7;
        Thu,  3 Aug 2023 15:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691076110;
        bh=gGAiitPQSrlb9gSGzmFfSecNyXcwS+MEUkY4CjOGpBY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O6d4GfSVQIxPehDNOe3a+aR+0QU0zpXlVeXlIAvKo1SRpYZ8dz7YSL0xRWxmpoQJB
         cFt4/4/3XhbVkf2eK2NYXqtgUF/mg51PLIzclkp6Q90UKULBOrdNHzH3YWOTvc/IC7
         MXFO2hQgi9MdybP5SoJAG8K4aWXNscluvdFDBfjufLxUa5Z9z+GJIEjgNNqFXg/4II
         DnRQYivV5p0ErNijc3l2aZYx4sIo3aD6rRdCJNrlEXvbD5DvGC5LJI6sDUBbkF/JjS
         E77A2TOl/aEI7tt0PeMgefU90GiHQRTitfqFv53c9bNaKQNN0kRY5pask9KDWJGfHa
         6GII6TGHRtNkw==
Date:   Thu, 3 Aug 2023 16:21:45 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Andrea Collamati <andrea.collamati@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: iio: dac: add mcp4728.yaml
Message-ID: <20230803-art-marbles-c57091465420@spud>
References: <cover.1691066050.git.andrea.collamati@gmail.com>
 <d93dd116cfa7f958c038c0c62993071ea48451d2.1691066050.git.andrea.collamati@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="EwqwCvl+QJ8f9W7n"
Content-Disposition: inline
In-Reply-To: <d93dd116cfa7f958c038c0c62993071ea48451d2.1691066050.git.andrea.collamati@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EwqwCvl+QJ8f9W7n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 03, 2023 at 02:56:34PM +0200, Andrea Collamati wrote:
> Add documentation for MCP4728
>=20
> Signed-off-by: Andrea Collamati <andrea.collamati@gmail.com>

I gave you a reviewed-by on v3, is there a reason that you dropped it?

Thanks,
Conor.

> ---
>  .../bindings/iio/dac/microchip,mcp4728.yaml   | 49 +++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/microchip,m=
cp4728.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/dac/microchip,mcp4728.=
yaml b/Documentation/devicetree/bindings/iio/dac/microchip,mcp4728.yaml
> new file mode 100644
> index 000000000000..99831d7f1c16
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dac/microchip,mcp4728.yaml
> @@ -0,0 +1,49 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +
> +$id: http://devicetree.org/schemas/iio/dac/microchip,mcp4728.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip MCP4728 DAC
> +
> +maintainers:
> +  - Andrea Collamati <andrea.collamati@gmail.com>
> +
> +description: |
> +  MCP4728 is a quad channel, 12-bit voltage output
> +  Digital-to-Analog Converter with non-volatile
> +  memory and I2C compatible Serial Interface.
> +  https://www.microchip.com/en-us/product/mcp4728
> +
> +properties:
> +  compatible:
> +    const: microchip,mcp4728
> +
> +  reg:
> +    maxItems: 1
> +
> +  vdd-supply:
> +    description: |
> +      Provides both power and acts as the reference supply on the MCP4728
> +      when Internal Vref is not selected.
> +
> +required:
> +  - compatible
> +  - reg
> +  - vdd-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        dac@60 {
> +            compatible =3D "microchip,mcp4728";
> +            reg =3D <0x60>;
> +            vdd-supply =3D <&vdac_vdd>;
> +        };
> +    };
> --=20
> 2.34.1
>=20

--EwqwCvl+QJ8f9W7n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMvGCQAKCRB4tDGHoIJi
0rN4AQCOhnmDfmsVYA1hdD3MGTFjz5hcR37JoZKdT7VwZSS0SgD/R5m9BcZE6vS3
GXL7uB10LZxC/5z/76qfWLEhdCsoWww=
=BV8Z
-----END PGP SIGNATURE-----

--EwqwCvl+QJ8f9W7n--
