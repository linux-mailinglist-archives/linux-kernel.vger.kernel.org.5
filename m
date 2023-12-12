Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 891C580F42D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 18:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233120AbjLLROc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 12:14:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232546AbjLLRO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 12:14:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF2F58F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 09:14:34 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCE9EC433C7;
        Tue, 12 Dec 2023 17:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702401274;
        bh=Zcj0fXIYj05PfXAXJRRaba5K0+vOckPktiL630dMYgs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YaQxsfHFiB42qftcR6JIjgF6HOa9mFE3f99F0/2J8URfdFND6pZ217M2SLq7InFZN
         oEFXu+Lf/wQ7YSvLx1w5Q9jzNBY/Qc1WVKretbOmlcoLt/Swv1ld9vz/dalKNU5pLm
         9wIhqZnctSuPaMCfLkR+9uHaZDlOXJG9EvVhYP2OSGpSfmb47zwx4z2ebcCcSucmB9
         48ntdXs609bTUl4lCqHP3vA13xXAsU2dALDh2vvOolorLHqJNKS+P1hcp9UVsSeuO9
         K+8KE1iKh3+/3phhUlltwDyg+gKlHq8nTyD7OdMOGm2gHZ8Wiviu8N6UG2cwp1JY9S
         EwD7Iz17sNZyw==
Date:   Tue, 12 Dec 2023 17:14:26 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Ninad Palsule <ninad@linux.ibm.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au,
        peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        johannes.holland@infineon.com, linux@roeck-us.net,
        broonie@kernel.org, patrick.rudolph@9elements.com,
        vincent@vtremblay.dev, peteryin.openbmc@gmail.com,
        lakshmiy@us.ibm.com, bhelgaas@google.com,
        naresh.solanki@9elements.com, alexander.stein@ew.tq-group.com,
        festevam@denx.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-hardening@vger.kernel.org,
        geissonator@yahoo.com
Subject: Re: [PATCH v1 2/8] dt-bindings: tpm: Add schema for TIS I2C devices
Message-ID: <20231212-amusement-elevation-28e42bcccc35@spud>
References: <20231212164004.1683589-1-ninad@linux.ibm.com>
 <20231212164004.1683589-3-ninad@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2PG9iIB6csIKhjsS"
Content-Disposition: inline
In-Reply-To: <20231212164004.1683589-3-ninad@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2PG9iIB6csIKhjsS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Tue, Dec 12, 2023 at 10:39:58AM -0600, Ninad Palsule wrote:
> From: Johannes Holland <johannes.holland@infineon.com>
>=20
> Add a dt schema to support device tree bindings

"Add bindings for..."

> for the generic I2C
> physical layer. Refer to the TCG PC Client Platform TPM Profile (PTP)
> Specification for TPM 2.0 v1.04 Revision 14.
>=20
> This includes descriptions for the Nuvoton and Infineon devices.
>=20

> OpenBMC-Staging-Count: 3

I have no idea what this is, but it needs to be removed from the patch.

> Signed-off-by: Johannes Holland <johannes.holland@infineon.com>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> ---
>  .../bindings/security/tpm/tpm-tis-i2c.yaml    | 50 +++++++++++++++++++
>  1 file changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/security/tpm/tpm-ti=
s-i2c.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.y=
aml b/Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml
> new file mode 100644
> index 000000000000..de1e34065748
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml
> @@ -0,0 +1,50 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/security/tpm/tpm-tis-i2c.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: I2C PTP based TPM Devices
> +
> +maintainers:
> +  - Johannes Holland <johannes.holland@infineon.com>
> +
> +description:
> +  Device Tree Bindings for I2C based Trusted Platform Module (TPM).

s/Device Tree Bindings for //. Doesn't dt_binding_check now complain if
you have this in a title or description?

> +properties:
> +  $nodename:
> +    pattern: "^tpm(@[0-9a-f]+)?$"
> +
> +  compatible:
> +    oneOf:
> +      - description: Infineon's Trusted Platform Module (TPM) (SLB9673).
> +        items:
> +          - const: infineon,slb9673
> +          - const: tcg,tpm-tis-i2c
> +      - description: Nuvoton's Trusted Platform Module (TPM) (NPCT75x).
> +        items:
> +          - const: nuvoton,npct75x
> +          - const: tcg,tpm-tis-i2c

> +      - const: tcg,tpm-tis-i2c

IMO this should be removed and this fallback should only be used in
combination with device specific compatibles, like you have here for the
infineon and nuvoton devices.

Cheers,
Conor.

> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +      #address-cells =3D <1>;
> +      #size-cells =3D <0>;
> +
> +      tpm@2e {
> +        compatible =3D "nuvoton,npct75x", "tcg,tpm-tis-i2c";
> +        reg =3D <0x2e>;
> +      };
> +    };
> +...
> --=20
> 2.39.2
>=20

--2PG9iIB6csIKhjsS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXiU8gAKCRB4tDGHoIJi
0rfJAP4nZ5EnLrc7JoF/x1QncshpSRifSSj5EXGcysTDO4Sr+wEAwPGS175s6OHs
QOXCdCmeYeUbjJsKyPpDYvec+54oKgg=
=kpn3
-----END PGP SIGNATURE-----

--2PG9iIB6csIKhjsS--
