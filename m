Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB42B776B0C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 23:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbjHIVh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 17:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbjHIVh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 17:37:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75201BCF;
        Wed,  9 Aug 2023 14:37:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4527664364;
        Wed,  9 Aug 2023 21:37:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8D91C433C8;
        Wed,  9 Aug 2023 21:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691617046;
        bh=9qPuQzBmdbGwMNrRlFUGd+Pi8pcueWOYHNimZFJXi2c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JV2nBNuOF3tp7mq2BscW1kFHEyvKNfFZVD6jBkHRuAwH7pRFtXEfNuFbBswtWfw+C
         +75lmYRrfdjwAGlDgNQ1GoKTAkKVsrx4lywAftjdiSCTj/mNe8q0Uy+ag4RxlrpGC3
         VItdTXJTSOv3Ad+HyX77jMP3mPYmOXBz4HQaUAfFH2E3NX91/it2SzETfgY6UMqHS5
         6Z2wZwkHd4UZkCPZWxJG7aK1FHvyHs1eCVCMxPn7nWx8Xacql9DAVb1KjUF9aMP7EL
         Dg+fU27o6pTM0jYFpeuenOy82Ffw8FEuL+U+J0TZsS0Per30bJSytFXBU0OL6eCIB/
         YDPSmfyezGEqQ==
Date:   Wed, 9 Aug 2023 22:37:20 +0100
From:   Conor Dooley <conor@kernel.org>
To:     MD Danish Anwar <danishanwar@ti.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Roger Quadros <rogerq@kernel.org>,
        Simon Horman <simon.horman@corigine.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Richard Cochran <richardcochran@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>, nm@ti.com, srk@ti.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        netdev@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/5] dt-bindings: net: Add ICSS IEP
Message-ID: <20230809-cardboard-falsify-6cc9c09d8577@spud>
References: <20230809114906.21866-1-danishanwar@ti.com>
 <20230809114906.21866-2-danishanwar@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="03Hx+6F635l/g8Vg"
Content-Disposition: inline
In-Reply-To: <20230809114906.21866-2-danishanwar@ti.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--03Hx+6F635l/g8Vg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Wed, Aug 09, 2023 at 05:19:02PM +0530, MD Danish Anwar wrote:
> Add DT binding documentation for ICSS IEP module.
>=20
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---
>  .../devicetree/bindings/net/ti,icss-iep.yaml  | 37 +++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/ti,icss-iep.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/net/ti,icss-iep.yaml b/Doc=
umentation/devicetree/bindings/net/ti,icss-iep.yaml
> new file mode 100644
> index 000000000000..adae240cfd53
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/ti,icss-iep.yaml
> @@ -0,0 +1,37 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/ti,icss-iep.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments ICSS Industrial Ethernet Peripheral (IEP) module

Does the module here refer to the hw component or to the linux kernel
module?

> +
> +maintainers:
> +  - Md Danish Anwar <danishanwar@ti.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,am654-icss-iep   # for all TI K3 SoCs

*sigh* Please at least give me a chance to reply to the conversation on
the previous versions of the series before sending more, that's the
second time with this series :/
Right now this looks worse to me than what we started with given the
comment is even broader. I have not changed my mind re: what I said on
the previous version.

Thanks,
Conor.

> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +    description: phandle to the IEP source clock
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    icssg0_iep0: iep@2e000 {
> +        compatible =3D "ti,am654-icss-iep";
> +        reg =3D <0x2e000 0x1000>;
> +        clocks =3D <&icssg0_iepclk_mux>;
> +    };
> --=20
> 2.34.1
>=20

--03Hx+6F635l/g8Vg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZNQHEAAKCRB4tDGHoIJi
0prnAP98Ul51Huk5I/s+3dku6NL7+ZhlDyE/ty6iIxYKwUJhrwD/UkHvU0wCVJ0b
qxRow4PAxLFJsy54Ob7bPKeaxaWo4gI=
=BxI+
-----END PGP SIGNATURE-----

--03Hx+6F635l/g8Vg--
