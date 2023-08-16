Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82E6C77E3BF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 16:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343668AbjHPOhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 10:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343666AbjHPOgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 10:36:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA95268F;
        Wed, 16 Aug 2023 07:36:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 00CFF63FD9;
        Wed, 16 Aug 2023 14:36:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4977FC433C7;
        Wed, 16 Aug 2023 14:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692196601;
        bh=cFVwQssEU/ZevKnmWRgUCGMqiImxukRz9RN58w9gLno=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q+uF5LfDMoeCssTLmgD1YOXDcW+ln3Eqy6DxdUaAJ4qXaC/APivlp665JHiQLro80
         PsQNir0XheiO7h0yur2uZX/a3/VpXNx48CUTvbPVf5sBVdVlohtuoWrpNjyLOLFr+L
         eXw1GCivxOoNq2VLr8qqcEP4g+iLLRPu9Vg47rCYAfpZPrpNPH9qDV3C307JTTjqwQ
         JpIqAlzTk2Na/V0qE8eRYqQVqHl8ZwaInmwU9tB535/cJLbavdh0CR3WU4ovvTKpCW
         Uf6vaIItwHiVYmoGaOl8Q/iZztDvifA+qX3RmItG3lnxmOHtlypD/e3QB+G/T+zt08
         wkt+iyAT7sStQ==
Date:   Wed, 16 Aug 2023 15:36:36 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Ana-Maria Cusco <ana-maria.cusco@analog.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2]  dt-bindings: iio: hmc425a: add entry for HMC540S
Message-ID: <20230816-stoop-exonerate-148c7bdc01c2@spud>
References: <20230816110906.144540-1-ana-maria.cusco@analog.com>
 <20230816110906.144540-2-ana-maria.cusco@analog.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2WIzG9zYjEoARyEQ"
Content-Disposition: inline
In-Reply-To: <20230816110906.144540-2-ana-maria.cusco@analog.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2WIzG9zYjEoARyEQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 16, 2023 at 02:09:06PM +0300, Ana-Maria Cusco wrote:
> Added support for HMC540SLP3E broadband 4-bit Silicon IC digital
> attenuator with a 15 dB control range and wide frequency coverage
> (0.1 to 8 GHz).
>=20
> Signed-off-by: Ana-Maria Cusco <ana-maria.cusco@analog.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  .../bindings/iio/amplifiers/adi,hmc425a.yaml         | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/amplifiers/adi,hmc425a=
=2Eyaml b/Documentation/devicetree/bindings/iio/amplifiers/adi,hmc425a.yaml
> index 9fda56fa49c3..2ee6080deac7 100644
> --- a/Documentation/devicetree/bindings/iio/amplifiers/adi,hmc425a.yaml
> +++ b/Documentation/devicetree/bindings/iio/amplifiers/adi,hmc425a.yaml
> @@ -4,20 +4,26 @@
>  $id: http://devicetree.org/schemas/iio/amplifiers/adi,hmc425a.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
> =20
> -title: HMC425A 6-bit Digital Step Attenuator
> +title: Analog Devices HMC425A and similar Digital Step Attenuators
> =20
>  maintainers:
>    - Michael Hennerich <michael.hennerich@analog.com>
> =20
>  description: |
> -  Digital Step Attenuator IIO device with gpio interface.
> +  Digital Step Attenuator IIO devices with gpio interface.
> +  Offer various frequency and attenuation ranges.
>    HMC425A 0.5 dB LSB GaAs MMIC 6-BIT DIGITAL POSITIVE CONTROL ATTENUATOR=
, 2.2 - 8.0 GHz
> -  https://www.analog.com/media/en/technical-documentation/data-sheets/hm=
c425A.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
hmc425A.pdf
> +
> +  HMC540S 1 dB LSB Silicon MMIC 4-Bit Digital Positive Control Attenuato=
r, 0.1 - 8 GHz
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
hmc540s.pdf
> +
> =20
>  properties:
>    compatible:
>      enum:
>        - adi,hmc425a
> +      - adi,hmc540s
> =20
>    vcc-supply: true
> =20
> --=20
> 2.34.1
>=20

--2WIzG9zYjEoARyEQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZNze9AAKCRB4tDGHoIJi
0naxAQDiE4DX6iP98TWRMy7Nujg3/EnZCyrOXen8GXzz40NXiQD/Wp/puTVyrEyx
F3RfunWTgCpLtFAOzELI5xxCswUOFgo=
=P+78
-----END PGP SIGNATURE-----

--2WIzG9zYjEoARyEQ--
