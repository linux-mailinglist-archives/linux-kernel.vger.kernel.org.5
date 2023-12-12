Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B55280F38E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 17:51:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376310AbjLLQvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 11:51:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjLLQvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 11:51:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 059DEB7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 08:51:13 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B600CC433C8;
        Tue, 12 Dec 2023 16:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702399872;
        bh=pxoxG3L7DCf9PxhMDZX23WIDnwrk05Pc2sbWEHLjkNQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=blDeZJNjTGcsepBC0e9cnsV21kV4vavWGKn7kBDtx5LFlCX50m0ODmn1lOnkUnsnY
         +iUm5MB3K30bxLX2XmAnHsRXgAyYMKDWD8LVWYA+ydkVvFQo4o8Ml0MMP9xg6Go0uT
         /4gkSZh8F80TGibEU6dIILcy0ME4SpV0a8RFLhfeSCxD5kyAXYFInUj74nwColB4GF
         XlAJZIdkH3OMnvB3egXPcF3LO63DbaPMoxV5l/3cIoHXzSSveFbunExJsyLITllSGB
         LuBfIKV6EHuS9XWfS16UBDl+O3YOeA7fS//0xAYcx7Zl3Up88u9bTOwR4d0MKC16mK
         OoZslS2ePbgJA==
Date:   Tue, 12 Dec 2023 16:51:06 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     bhelgaas@google.com, conor+dt@kernel.org,
        devicetree@vger.kernel.org, festevam@gmail.com, helgaas@kernel.org,
        hongxing.zhu@nxp.com, imx@lists.linux.dev, kernel@pengutronix.de,
        krzysztof.kozlowski+dt@linaro.org, kw@linux.com,
        l.stach@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, lpieralisi@kernel.org,
        manivannan.sadhasivam@linaro.org, robh@kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org
Subject: Re: [PATCH v3 12/13] dt-bindings: imx6q-pcie: Add iMX95 pcie
 endpoint compatible string
Message-ID: <20231212-snowiness-verbalize-d1fbb8c80a99@spud>
References: <20231211215842.134823-1-Frank.Li@nxp.com>
 <20231211215842.134823-13-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ehk5DdTkek4HJjlY"
Content-Disposition: inline
In-Reply-To: <20231211215842.134823-13-Frank.Li@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ehk5DdTkek4HJjlY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 04:58:41PM -0500, Frank Li wrote:
> Add i.MX95 PCIe "fsl,imx95-pcie-ep" compatible string.
> Add reg-name: "atu", "dbi2", "dma" and "serdes".
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>=20
> Notes:
>     Change from v1 to v3
>     - new patches at v3
>=20
>  .../bindings/pci/fsl,imx6q-pcie-ep.yaml       | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml=
 b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
> index ee155ed5f1811..36d8f117fdfb3 100644
> --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
> +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
> @@ -22,6 +22,7 @@ properties:
>        - fsl,imx8mm-pcie-ep
>        - fsl,imx8mq-pcie-ep
>        - fsl,imx8mp-pcie-ep
> +      - fsl,imx95-pcie-ep
> =20
>    reg:
>      minItems: 2
> @@ -62,11 +63,30 @@ required:
>  allOf:
>    - $ref: /schemas/pci/snps,dw-pcie-ep.yaml#
>    - $ref: /schemas/pci/fsl,imx6q-pcie-common.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - fsl,imx95-pcie-ep
> +    then:
> +      properties:
> +        reg:
> +          minItems: 6
> +        reg-names:
> +          items:
> +            - const: dbi
> +            - const: atu
> +            - const: dbi2
> +            - const: serdes
> +            - const: dma
> +            - const: addr_space
> +
>    - if:
>        properties:
>          compatible:
>            enum:
>              - fsl,imx8mq-pcie-ep
> +            - fsl,imx95-pcie-ep
>      then:
>        properties:
>          clocks:
> --=20
> 2.34.1
>=20

--ehk5DdTkek4HJjlY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXiPegAKCRB4tDGHoIJi
0ilmAQDQ1GfJs7PkFWStKchAvAk/4FgCatGA4wPKZ8PH27gQ4QEAmAksUAUSPt0S
tNrfj2EzCLZd4RIPyNmTSRq1WY6OLgc=
=KvBM
-----END PGP SIGNATURE-----

--ehk5DdTkek4HJjlY--
