Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35A1576BEE0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 22:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbjHAU6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 16:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjHAU5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 16:57:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4B0B4;
        Tue,  1 Aug 2023 13:57:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C713D61704;
        Tue,  1 Aug 2023 20:57:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E32C1C433C7;
        Tue,  1 Aug 2023 20:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690923472;
        bh=MZpsgZkrTs9N2DXeSvVULBbBTbC/2zrygwHEmp8YujM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k5zvTHcaV4FqvE9jjvKUtp/xndGtvumroKOColDoaHHgiuq4X1+XKbmp++w7LWLQ8
         cVR2WGZ3SHE7NWqWskw88lRJ8hO3IK6X4//+uqggtlZpbIgWBfl3cY43X4Lzee8cgm
         pEGPmTmWwovy18PICv9IEzeR9ywuTsxY5zOfhwg9R8UlHzgxExjVhO463h3Gdn+NMD
         nF+lycPEvbrtmpei2B3YOb06JSwAU7VwCx/lG6DIoFk70sACLCJtS0YwJ+ndkcd21x
         2p3JctnekTWlWkhLSYWsnmXkgc9sWJtmAfXpKjj2rbk9ikS37d0tdq8WmxayEsNAkc
         doM2vHgGHLIrQ==
Date:   Tue, 1 Aug 2023 21:57:43 +0100
From:   Conor Dooley <conor@kernel.org>
To:     niravkumar.l.rabara@intel.com
Cc:     adrian.ho.yin.ng@intel.com, andrew@lunn.ch, conor+dt@kernel.org,
        devicetree@vger.kernel.org, dinguyen@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        netdev@vger.kernel.org, p.zabel@pengutronix.de,
        richardcochran@gmail.com, robh+dt@kernel.org, sboyd@kernel.org,
        wen.ping.teh@intel.com
Subject: Re: [PATCH v2 3/5] dt-bindings: clock: add Intel Agilex5 clock
 manager
Message-ID: <20230801-handball-glorifier-e55d44a2b638@spud>
References: <20230618132235.728641-1-niravkumar.l.rabara@intel.com>
 <20230801010234.792557-1-niravkumar.l.rabara@intel.com>
 <20230801010234.792557-4-niravkumar.l.rabara@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UYgz3o3mOFvMlDjf"
Content-Disposition: inline
In-Reply-To: <20230801010234.792557-4-niravkumar.l.rabara@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UYgz3o3mOFvMlDjf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 01, 2023 at 09:02:32AM +0800, niravkumar.l.rabara@intel.com wro=
te:
> From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
>=20
> Add clock ID definitions for Intel Agilex5 SoCFPGA.
> The registers in Agilex5 handling the clock is named as clock manager.
>=20
> Signed-off-by: Teh Wen Ping <wen.ping.teh@intel.com>
> Reviewed-by: Dinh Nguyen <dinguyen@kernel.org>
> Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
> ---
>  .../bindings/clock/intel,agilex5-clkmgr.yaml  |  41 +++++++
>  .../dt-bindings/clock/intel,agilex5-clkmgr.h  | 100 ++++++++++++++++++
>  2 files changed, 141 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/intel,agilex5=
-clkmgr.yaml
>  create mode 100644 include/dt-bindings/clock/intel,agilex5-clkmgr.h
>=20
> diff --git a/Documentation/devicetree/bindings/clock/intel,agilex5-clkmgr=
=2Eyaml b/Documentation/devicetree/bindings/clock/intel,agilex5-clkmgr.yaml
> new file mode 100644
> index 000000000000..60e57a9fb939
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/intel,agilex5-clkmgr.yaml
> @@ -0,0 +1,41 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/intel,agilex5-clkmgr.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Intel SoCFPGA Agilex5 clock manager
> +
> +maintainers:
> +  - Dinh Nguyen <dinguyen@kernel.org>
> +
> +description:
> +  The Intel Agilex5 Clock Manager is an integrated clock controller, whi=
ch
> +  generates and supplies clock to all the modules.
> +
> +properties:
> +  compatible:
> +    const: intel,agilex5-clkmgr
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#clock-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - '#clock-cells'
> +
> +additionalProperties: false
> +
> +examples:

> +  # Clock controller node:

This comment seems utterly pointless.
Otherwise this looks okay to me.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> +  - |
> +    clkmgr: clock-controller@10d10000 {
> +      compatible =3D "intel,agilex5-clkmgr";
> +      reg =3D <0x10d10000 0x1000>;
> +      #clock-cells =3D <1>;
> +    };
> +...

--UYgz3o3mOFvMlDjf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMlxxwAKCRB4tDGHoIJi
0po0AQDZnIwfegUcCT3iU12bMW+7Rzx574ajligwACkn70tY7QD7BqfnIx/HSMTi
r+m16KOx6UHod5DfGI/YVENWzFoUfwo=
=GoDZ
-----END PGP SIGNATURE-----

--UYgz3o3mOFvMlDjf--
