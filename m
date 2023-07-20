Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2D475B524
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 19:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbjGTRBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 13:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjGTRBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 13:01:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D57B92;
        Thu, 20 Jul 2023 10:01:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6E8E61B84;
        Thu, 20 Jul 2023 17:01:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41662C433C7;
        Thu, 20 Jul 2023 17:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689872490;
        bh=cZQR2myM7YTdFJpkoJ87DSXcNMNJafyrVAbvtYAp0ig=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ogAvEi2rEnReACizdmeZZkWhy2M0O6fmvzJ+tBgDtjUD3Pe3M8PzV/l5pFBjA37BR
         dHUofSQEVjG0ZrxCAZzVNc1wp7WQbCLduh64mHD729Rwpvam0Cu8uLoU3mIqOKqcre
         3y8XsvLbAP3FV5PzwC79hwCiBx616HXsYuMLi3W6ISpM13O/32cIvPh71MH5JHQmOH
         /BOCaThvjntxFMShIvADSR2kgM+tvMYP1YMtJMRplWoDf9YQgt5gD3xXXrUodDGMmq
         W5TSpF5sdqNNUIuCLbbp2USHATXhQ1cys10KBkXMj4Q9NY+XwePOaZgpSm2BtjKLkV
         tE18uoD509l4g==
Date:   Thu, 20 Jul 2023 18:01:25 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Andrea Collamati <andrea.collamati@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: dac: add mcp4728.yaml
Message-ID: <20230720-nastily-professor-3a5cae27893d@spud>
References: <cover.1689857295.git.andrea.collamati@gmail.com>
 <9816cd272d19802ec6eeff0c7c29e85d4a0ade88.1689857295.git.andrea.collamati@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SnjEIDgVQ/JrEUk8"
Content-Disposition: inline
In-Reply-To: <9816cd272d19802ec6eeff0c7c29e85d4a0ade88.1689857295.git.andrea.collamati@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SnjEIDgVQ/JrEUk8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Andrea,

On Thu, Jul 20, 2023 at 05:40:02PM +0200, Andrea Collamati wrote:
> Add documentation for MCP4728
>=20
> Signed-off-by: Andrea Collamati <andrea.collamati@gmail.com>
> ---
>  .../bindings/iio/dac/microchip,mcp4728.yaml   | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/microchip,m=
cp4728.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/dac/microchip,mcp4728.=
yaml b/Documentation/devicetree/bindings/iio/dac/microchip,mcp4728.yaml
> new file mode 100644
> index 000000000000..6fd9be076245
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dac/microchip,mcp4728.yaml
> @@ -0,0 +1,48 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/dac/microchip,mcp4728.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip MCP4728 DAC
> +
> +description:
> +  MCP4728 is a quad channel, 12-bit voltage output
> +  Digital-to-Analog Converter with non-volatile
> +  memory and I2C compatible Serial Interface.
> +  https://www.microchip.com/en-us/product/mcp4728
> +
> +maintainers:
> +  - Andrea Collamati <andrea.collamati@gmail.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - microchip,mcp4728

This can just be
compatible:
  const: microchip,mcp47288
since you only have a single item in your enum.

Otherwise, this looks good to me.
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Despite the email address, I have no knowledge of the hardware in
question, I'm just reviewing the binding.

Thanks,
Conor.

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
> +        mcp4728@60 {
> +            compatible =3D "microchip,mcp4728";
> +            reg =3D <0x60>;
> +            vdd-supply =3D <&vdac_vdd>;
> +        };
> +    };
> --=20
> 2.34.1
>=20

--SnjEIDgVQ/JrEUk8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZLloZQAKCRB4tDGHoIJi
0lxZAQD+bDnHwUCxG5//NQNbaoEW5V5MPun8lyz+5x99bvMxwgEA4LnpU9iZD/28
7V/LMJhpxX2UgUsA3cIzIIo97WPbaAA=
=XRkd
-----END PGP SIGNATURE-----

--SnjEIDgVQ/JrEUk8--
