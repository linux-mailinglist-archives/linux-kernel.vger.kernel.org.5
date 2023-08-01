Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB6576BED3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 22:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbjHAUxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 16:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjHAUxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 16:53:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B85C1FF0;
        Tue,  1 Aug 2023 13:53:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 121A561707;
        Tue,  1 Aug 2023 20:53:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A708C433C7;
        Tue,  1 Aug 2023 20:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690923216;
        bh=obhqLQxptseI0LHMuZyhYQYBOS6OSCE3jVqB3HSrzgw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HOEc0TLIPtm4ZvN3lzLjFSbZQU62W4m1Im2JRaopeOR2nHBPcEGqM3rfUqVxG8ivp
         1jY8d/Cypozuwzb+9bVwkfWZju8q2OnU2FtRM9NDmWtLazQ/9iJKm9LdQKK/LNlU4m
         E9nvf9CLwIc3PaTvAUr2LcK2TH6AZw+t+RZhNfzIw8un7/SZmhrWypL4KR4oc/m7xY
         yUIge0NBxC72hLMNZ4G7p8e0TnbZ7bceG/9lCcTglIG8K2AxXAMclIHJaNN8mCcWGv
         euVUzvyKTava5ISdpq5TBDaf5zWN2lYlPvd5W8GJqrMwJvk3r0L7TNSUTNm5F6Hvwp
         NQflERAPP9iZw==
Date:   Tue, 1 Aug 2023 21:53:31 +0100
From:   Conor Dooley <conor@kernel.org>
To:     niravkumar.l.rabara@intel.com
Cc:     adrian.ho.yin.ng@intel.com, andrew@lunn.ch, conor+dt@kernel.org,
        devicetree@vger.kernel.org, dinguyen@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        netdev@vger.kernel.org, p.zabel@pengutronix.de,
        richardcochran@gmail.com, robh+dt@kernel.org, sboyd@kernel.org,
        wen.ping.teh@intel.com
Subject: Re: [PATCH v2 1/5] dt-bindings: intel: Add Intel Agilex5 compatible
Message-ID: <20230801-blatancy-chill-efee6e93f2e0@spud>
References: <20230618132235.728641-1-niravkumar.l.rabara@intel.com>
 <20230801010234.792557-1-niravkumar.l.rabara@intel.com>
 <20230801010234.792557-2-niravkumar.l.rabara@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yUkJXzVAcuN13gRW"
Content-Disposition: inline
In-Reply-To: <20230801010234.792557-2-niravkumar.l.rabara@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yUkJXzVAcuN13gRW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 01, 2023 at 09:02:30AM +0800, niravkumar.l.rabara@intel.com wro=
te:
> From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
>=20
> Agilex5 is a new SoCFPGA in Intel Agilex SoCFPGA Family,
> include compatible string for Agilex5 SoCFPGA board.
>=20
> Reviewed-by: Dinh Nguyen <dinguyen@kernel.org>
> Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  Documentation/devicetree/bindings/arm/intel,socfpga.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/intel,socfpga.yaml b/D=
ocumentation/devicetree/bindings/arm/intel,socfpga.yaml
> index 4b4dcf551eb6..2ee0c740eb56 100644
> --- a/Documentation/devicetree/bindings/arm/intel,socfpga.yaml
> +++ b/Documentation/devicetree/bindings/arm/intel,socfpga.yaml
> @@ -21,6 +21,11 @@ properties:
>                - intel,socfpga-agilex-n6000
>                - intel,socfpga-agilex-socdk
>            - const: intel,socfpga-agilex
> +      - description: Agilex5 boards
> +        items:
> +          - enum:
> +              - intel,socfpga-agilex5-socdk
> +          - const: intel,socfpga-agilex5
> =20
>  additionalProperties: true
> =20
> --=20
> 2.25.1
>=20

--yUkJXzVAcuN13gRW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMlwygAKCRB4tDGHoIJi
0vuEAP4uO+JAx0MD0FfkTsZr5gB6MYd9JQhZhpnnnCBxyuFFBwD8DyO4Tugog9dy
Fi7aNet1WmUff9KNVUbPD2zxc564OQ8=
=B376
-----END PGP SIGNATURE-----

--yUkJXzVAcuN13gRW--
