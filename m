Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D92F777F282
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 10:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349140AbjHQIyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 04:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349184AbjHQIyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 04:54:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744442D5F;
        Thu, 17 Aug 2023 01:54:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 125AF64FCD;
        Thu, 17 Aug 2023 08:54:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8574C433C7;
        Thu, 17 Aug 2023 08:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692262461;
        bh=GUqgAMRPiOb7bdxg5p++Fu/53Hyk/pUWyJB+asnngYM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lQ+ubKNjbU9kXbRCqm+5GOYkQgqy0nyu39C0P++cvDtIjLmMjYsvosZ0Gf1mRVfkC
         qx/ntLLZVVjnwUbYUpncmv9CsTXVtXqRbIjXVxf1sqWpSf3k76JfL9Qv8+DezhGpk3
         Rj7rbhI555jefptorI+gv0VMNCiVqPJwhzqIhWcPBgfimNoKDP6yJSaplHZNVsIRGr
         UykwhL3Q7BUzytX/IHwuqtufAtujjZ6GWhjYWG0fIIebLNUtcK9ef1tW7R9i1a8cG2
         YsxMS2i9s1OQ3oZSoSPWNpYIbcjtoXNdCnn8JERl7VGdRIGiwtO3D0YsxHvLuB6aTm
         INLkvrBfj2GZQ==
Date:   Thu, 17 Aug 2023 09:54:17 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-renesas-soc@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: gnss: u-blox: add "reset-gpios"
 binding
Message-ID: <20230817-sequence-aftermost-e662486bc2e9@spud>
References: <20230816173116.1176-1-wsa+renesas@sang-engineering.com>
 <20230816173116.1176-3-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yqL3wsbo7nCP/hbJ"
Content-Disposition: inline
In-Reply-To: <20230816173116.1176-3-wsa+renesas@sang-engineering.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yqL3wsbo7nCP/hbJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 16, 2023 at 07:31:14PM +0200, Wolfram Sang wrote:
> Needed to enable this chip on a Renesas KingFisher board. Description
> copied over from the Mediatek driver which already supports it.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>=20
> Changes since v1:
> * dropped obvious description (Thanks, Geert!)
> * added missing include (Thanks, Krzysztof and Rob!)
>=20
> I build tested the change this time.
>=20
>  Documentation/devicetree/bindings/gnss/u-blox,neo-6m.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/gnss/u-blox,neo-6m.yaml b/=
Documentation/devicetree/bindings/gnss/u-blox,neo-6m.yaml
> index 4835a280b3bf..8e97e475613f 100644
> --- a/Documentation/devicetree/bindings/gnss/u-blox,neo-6m.yaml
> +++ b/Documentation/devicetree/bindings/gnss/u-blox,neo-6m.yaml
> @@ -41,6 +41,9 @@ properties:
>      description: >
>        Backup voltage regulator
> =20
> +  reset-gpios:
> +    maxItems: 1
> +
>  required:
>    - compatible
>    - vcc-supply
> @@ -49,10 +52,12 @@ unevaluatedProperties: false
> =20
>  examples:
>    - |
> +    #include <dt-bindings/gpio/gpio.h>
>      serial {
>          gnss {
>              compatible =3D "u-blox,neo-8";
>              v-bckp-supply =3D <&gnss_v_bckp_reg>;
>              vcc-supply =3D <&gnss_vcc_reg>;
> +            reset-gpios =3D <&gpio 1 GPIO_ACTIVE_LOW>;
>          };
>      };
> --=20
> 2.35.1
>=20

--yqL3wsbo7nCP/hbJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZN3gOQAKCRB4tDGHoIJi
0kJZAQCXOYcC9k2SSdWNIkC4KKcnA5NcoN2YZymR3/oEq6x8TQD/eAY6JhSm8tD3
caRH2tqzlePoKL3WNfBZSf06F1Q4WQk=
=23qR
-----END PGP SIGNATURE-----

--yqL3wsbo7nCP/hbJ--
