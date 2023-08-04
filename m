Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28FB37705F2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 18:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjHDQ1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 12:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjHDQ1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 12:27:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D18049EF;
        Fri,  4 Aug 2023 09:27:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E8D262098;
        Fri,  4 Aug 2023 16:27:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C50C6C433C7;
        Fri,  4 Aug 2023 16:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691166427;
        bh=TiaSPP9i5pQA759MOZyCgvaxTxREdBvntCsz0dMqook=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OH5Z7Z3U1Fdr9Gfe0xFYvp9zuG9o7jXzwU1wYnefYvqf7HQEGJWHyaHdPaR5beXSW
         vqPdZEHTeO/9lYCsJrmzhXRowk+b3Hd3Q5cqxKvuQoRXrwrTAhGy982birYotOePI/
         yMNqL/9A8RRlxa/EBerF1t7+XygQYlVUojP/jm4F63t8rnlQUfpqY3Qjw4MjJ4KYpa
         nu0Y5Nc02C/1kxEXVocBqf5XPM1Ml20kOhv6GpsgTmRWjDx9phDIEEjVZiCVfN9YoA
         fwmhq5d0Aa/gTWhhc7mHJChoPGIobB2EXZcqeQzHMvZTOtd8uXkqESztS0VsRi2wBF
         023VdUsxljBxQ==
Date:   Fri, 4 Aug 2023 17:27:02 +0100
From:   Conor Dooley <conor@kernel.org>
To:     like@awinic.com
Cc:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        liweilei@awinic.com, liangdong@awinic.com, wangweidong.a@awinic.com
Subject: Re: [PATCH v2 2/2] regulator: dt-bindings: Correct yamllint
 warnings/errors
Message-ID: <20230804-gossip-clever-a21866c7c829@spud>
References: <20230804102703.931418-1-like@awinic.com>
 <20230804102703.931418-3-like@awinic.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2dPm4VUO9CDoyJXA"
Content-Disposition: inline
In-Reply-To: <20230804102703.931418-3-like@awinic.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2dPm4VUO9CDoyJXA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 04, 2023 at 10:27:03AM +0000, like@awinic.com wrote:
> From: Alec Li <like@awinic.com>
>=20
> These yamllint warnings/errors have been corrected.

This commit message makes no sense. Was this meant to be the changelog
between version 1 & version 2?

Thanks,
Conor.

>=20
> Signed-off-by: Alec Li <like@awinic.com>
> ---
>  .../bindings/regulator/awinic,aw37503.yaml    | 65 +++++++++++++++++++
>  1 file changed, 65 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/awinic,aw=
37503.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/regulator/awinic,aw37503.y=
aml b/Documentation/devicetree/bindings/regulator/awinic,aw37503.yaml
> index 000000000000..bb551f6cbccd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/awinic,aw37503.yaml
> @@ -0,0 +1,65 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/awinic,aw37503.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Awinic AW37503 Voltage Regulator
> +
> +maintainers:
> +  - Alec Li <like@awinic.com>
> +
> +description:
> +  The AW37503 are dual voltage regulator, designed to support positive/n=
egative
> +  supply for driving TFT-LCD panels. It support software-configurable ou=
tput
> +  switching and monitoring. The output voltages can be programmed via an=
 I2C
> +  compatible interface.
> +
> +properties:
> +  compatible:
> +    const: awinic,aw37503
> +
> +  reg:
> +    maxItems: 1
> +
> +patternProperties:
> +  "^out[pn]$":
> +    type: object
> +    $ref: regulator.yaml#
> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - outp
> +  - outn
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    i2c {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        regulator@3e {
> +            compatible =3D "awinic,aw37503";
> +            reg =3D <0x3e>;
> +
> +            outp {
> +                regulator-name =3D "outp";
> +                regulator-boot-on;
> +                regulator-always-on;
> +                enable-gpios =3D <&gpio 17 0>;
> +            };
> +
> +            outn {
> +                regulator-name =3D "outn";
> +                regulator-boot-on;
> +                regulator-always-on;
> +                enable-gpios =3D <&gpio 27 0>;
> +            };
> +        };
> +    };
> +...
> --=20
> 2.41.0
>=20

--2dPm4VUO9CDoyJXA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZM0m1gAKCRB4tDGHoIJi
0riKAP0d15qpZK4GW+wu+tXAwn0dW/F8ql0FajBo0qxJ21Fi+AEA5T8BDQPAD63b
9JeqKXpOB4lhqWODRJDU1PtgZ8zIMgU=
=J7nL
-----END PGP SIGNATURE-----

--2dPm4VUO9CDoyJXA--
