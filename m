Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 335D880F419
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 18:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232911AbjLLRKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 12:10:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232572AbjLLRJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 12:09:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B0CED0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 09:10:05 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D7CFC433C8;
        Tue, 12 Dec 2023 17:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702401004;
        bh=yjoopt9NEDUJBXYr+uh0GurA19bZL/znMFFec8DNFHU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HKjopVXeO6JVxx8562Q1lAsjA3jLS9Lrq37LUVv/9vpA/h4L49qsljC4USp3nIwKv
         wmp89DWIDumgmnSah7+tF4tfl/a9iZ7zkwZK5mcLWXS+lrQTEZ5X2aXuv9bwqT6fzH
         y2/5Lybl5TsflSGLcFCIfaRXroO9XKBtVpZA+5x91ophu6Q13pvLRM4VfBE5+TW2Fn
         bhlQstwmM50jkVhnlqPxT24RWqgS/ZlS33sPgFiFCJo+u50ZvA9SWyr9EYcu83sm/j
         0jt35PpifPlW5KwJp7yaxVF4Wa4gu+oJuW4b4gzlmobPImpcV4Rzv0cE8TqtIQrj9y
         yhBvAVAnrZzZw==
Date:   Tue, 12 Dec 2023 17:09:57 +0000
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
Subject: Re: [PATCH v1 1/8] dt-bindings: arm: aspeed: add IBM system1-bmc
Message-ID: <20231212-thrower-ebook-d29a85a6ed96@spud>
References: <20231212164004.1683589-1-ninad@linux.ibm.com>
 <20231212164004.1683589-2-ninad@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="55umEabtpNwX1lRu"
Content-Disposition: inline
In-Reply-To: <20231212164004.1683589-2-ninad@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--55umEabtpNwX1lRu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 10:39:57AM -0600, Ninad Palsule wrote:
> Document the new compatibles used on IBM system1-bmc
>=20
> Tested:
>     This board is tested using the simics simulator.

I don't see how this is relevant to dt-bindings patches.

>=20
> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> ---
>  Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
>  Documentation/devicetree/bindings/trivial-devices.yaml   | 2 ++

IMO these should be split into two patches.

Cheers,
Conor.

>  2 files changed, 3 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/D=
ocumentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> index 6f7543463d89..ebebe14c42aa 100644
> --- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> +++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> @@ -85,6 +85,7 @@ properties:
>                - facebook,yosemite4-bmc
>                - ibm,everest-bmc
>                - ibm,rainier-bmc
> +              - ibm,system1-bmc
>                - ibm,tacoma-bmc
>                - inventec,starscream-bmc
>                - inventec,transformer-bmc
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Doc=
umentation/devicetree/bindings/trivial-devices.yaml
> index 441b55723675..b12a60d2eb0f 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -135,6 +135,8 @@ properties:
>            - ibm,cffps1
>              # IBM Common Form Factor Power Supply Versions 2
>            - ibm,cffps2
> +            # Infineon barometric pressure and temperature sensor
> +          - infineon,dps310
>              # Infineon IR36021 digital POL buck controller
>            - infineon,ir36021
>              # Infineon IR38060 Voltage Regulator
> --=20
> 2.39.2
>=20

--55umEabtpNwX1lRu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXiT5AAKCRB4tDGHoIJi
0pd1AQCSwXdC8RYV745T9gVdIrlReCQJoSuD6J0vvr2NN2/3iAD+Mfx6pgKRXZWu
G9C1EwvFHJ7rMpBCulVDOhFTvdQLUAA=
=0EQF
-----END PGP SIGNATURE-----

--55umEabtpNwX1lRu--
