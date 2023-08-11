Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85560779352
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 17:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235606AbjHKPhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 11:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbjHKPhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 11:37:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F1BB127;
        Fri, 11 Aug 2023 08:37:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E9F3E6119C;
        Fri, 11 Aug 2023 15:37:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D04ACC433C8;
        Fri, 11 Aug 2023 15:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691768220;
        bh=IwOupUYX4uwoK+O9WEdepYooynfek5GkO6Od3LDdjAc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BI6tLwYsm/mibN4q/5jKOlxwgQh6m0Wn8lC4eZwJZ4nvEIHRHLsvQieg8qZcfWMDe
         tSD7XyPgEtXeUsVZbxWOlJHpXStb5D4LK7/QFTsks9LyCXkaKWjxgntIKJO714QKg8
         XYqKupscCU+jdlz1FQh5pr9X+ke75OJl6FA27MguxGkQjxpXUWpAWC9hryXOsLN0ms
         96/Piq6UBnaO9hqIrE2ECj2l2jZXkSC0Pm855wpUQMovvdeSMInxFdubciIaGPY4Sh
         U5AhvmwaL2l32Z4bS3dXTdvBE99hv+qyAtHiyEwgIUO+yCLfzbqxHZoUjfSAYQQd6o
         ztQAQQ+zxVuyw==
Date:   Fri, 11 Aug 2023 16:36:54 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Kamlesh Gurudasani <kamlesh@ti.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v2 3/6] dt-bindings: crypto: Add Texas Instruments MCRC64
Message-ID: <20230811-imminent-fancied-89663c373ab5@spud>
References: <20230719-mcrc-upstream-v2-0-4152b987e4c2@ti.com>
 <20230719-mcrc-upstream-v2-3-4152b987e4c2@ti.com>
 <20230811-crestless-gratify-21c9bb422375@spud>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yk7Io+ad3L2jbO+M"
Content-Disposition: inline
In-Reply-To: <20230811-crestless-gratify-21c9bb422375@spud>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yk7Io+ad3L2jbO+M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 11, 2023 at 04:34:33PM +0100, Conor Dooley wrote:
> On Fri, Aug 11, 2023 at 12:58:50AM +0530, Kamlesh Gurudasani wrote:
> > Add binding for Texas Instruments MCRC64
> >=20
> > MCRC64 engine calculates 64-bit cyclic redundancy checks (CRC)
> > according to the ISO 3309 standard.
> >=20
> > The ISO 3309 64-bit CRC model parameters are as follows:
> >     Generator Polynomial: x^64 + x^4 + x^3 + x + 1
> >     Polynomial Value: 0x000000000000001B
> >     Initial value: 0x0000000000000000
> >     Reflected Input: False
> >     Reflected Output: False
> >     Xor Final: 0x0000000000000000
> >=20
> > Signed-off-by: Kamlesh Gurudasani <kamlesh@ti.com>
> > ---
> >  Documentation/devicetree/bindings/crypto/ti,mcrc64.yaml | 47 +++++++++=
++++++++++++++++++++++++++++++++++++++
> >  MAINTAINERS                                             |  5 +++++
> >  2 files changed, 52 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/crypto/ti,mcrc64.yaml b/=
Documentation/devicetree/bindings/crypto/ti,mcrc64.yaml
> > new file mode 100644
> > index 000000000000..38bc7efebd68
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/crypto/ti,mcrc64.yaml
> > @@ -0,0 +1,47 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/crypto/ti,mcrc64.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Texas Instruments MCRC64
> > +
> > +description: The MCRC64 engine calculates 64-bit cyclic redundancy che=
cks
>=20
> A newline after "description" please.
>=20
> > +  (CRC) according to the ISO 3309 standard.
> > +
> > +maintainers:
> > +  - Kamlesh Gurudasani <kamlesh@ti.com>
> > +
> > +properties:
> > +  compatible:
> > +    const: ti,am62-mcrc64
>=20
> Is the am62 an SoC or a family of SoCs? I googled a wee bit for am62 &
> there seems to be an am625 and an am623?

Or is it an am62p5, in which case the compatible should contain
ti,am62p5 I suppose. Sorry for my confusion here, its not really clear
me too since I've been seeing many different-but-similar product names
the last few days.

Thanks,
Conor.

>=20
> Otherwise, this looks good to me.
>=20
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    maxItems: 1
> > +
> > +  power-domains:
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - clocks
> > +  - power-domains
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/soc/ti,sci_pm_domain.h>
> > +
> > +    crc@30300000 {
> > +      compatible =3D "ti,am62-mcrc64";
> > +      reg =3D <0x30300000 0x1000>;
> > +      clocks =3D <&k3_clks 116 0>;
> > +      power-domains =3D <&k3_pds 116 TI_SCI_PD_EXCLUSIVE>;
> > +    };
> > +
> > +...
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 02a3192195af..66b51f43d196 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -21481,6 +21481,11 @@ S:	Maintained
> >  F:	Documentation/devicetree/bindings/iio/adc/ti,lmp92064.yaml
> >  F:	drivers/iio/adc/ti-lmp92064.c
> > =20
> > +TI MEMORY CYCLIC REDUNDANCY CHECK (MCRC64) DRIVER
> > +M:	Kamlesh Gurudasani <kamlesh@ti.com>
> > +S:	Maintained
> > +F:	Documentation/devicetree/bindings/crypto/ti,mcrc64.yaml
> > +
> >  TI PCM3060 ASoC CODEC DRIVER
> >  M:	Kirill Marinushkin <kmarinushkin@birdec.com>
> >  L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
> >=20
> > --=20
> > 2.34.1
> >=20



--yk7Io+ad3L2jbO+M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZNZVlgAKCRB4tDGHoIJi
0uHpAP4hfYrFNPj0CkA40P9EKD3r/FKiAc6X2K23ePY3vww/XAEA6WukF13gDiEn
uOcZZtE+v9yuqJykNIKHzEe9ishk3gI=
=Qk3W
-----END PGP SIGNATURE-----

--yk7Io+ad3L2jbO+M--
