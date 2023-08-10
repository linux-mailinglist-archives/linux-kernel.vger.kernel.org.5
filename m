Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18328777DD0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 18:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236430AbjHJQM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 12:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233284AbjHJQM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 12:12:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E17741994;
        Thu, 10 Aug 2023 09:12:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 77B26661B9;
        Thu, 10 Aug 2023 16:12:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7E2FC433C8;
        Thu, 10 Aug 2023 16:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691683944;
        bh=OcqNCzObC1EKNtRyWAawRvnOnyFp+jPeVcOHVtyLdMw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vEo1uoMv6Je3nMeV7pnuPSOi0e1OXzWRNRWkvPlyow/fdcmg8gRAOP7G7HjXWA29a
         bv2TunAq0eHA7i/nX5/c8Lr3eqJxGOFyojctbtX88Xn2WOZF6W1aKmAKv+9kD/cZRy
         q4u0QFM8Y9TRu3sc8TI48543QfAtnPYQro/kWvU5ROFhCVj5Crl6LWDP9BHORlwAYd
         CgNt6oU4afQgMZaikM8EWBfjNPaBiJMaP1t9gC4S96mfJYinPZK+T6NOReYJvMpQNN
         mrUtttZloojwATvGTQBcPpDRuAat/MoNtR0bGfrfvYhrt6mt2ZgKbPAOAhIAyvdmTU
         OAm4nvN75CS3w==
Date:   Thu, 10 Aug 2023 17:12:18 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Aleksandr Shubin <privatesub2@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 1/3] dt-bindings: pwm: Add binding for Allwinner
 D1/T113-S3/R329 PWM controller
Message-ID: <20230810-unmasking-sprinkler-d75e728cc0ee@spud>
References: <20230810145443.1053387-1-privatesub2@gmail.com>
 <20230810145443.1053387-2-privatesub2@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hPg5kcy3KfBtOZY7"
Content-Disposition: inline
In-Reply-To: <20230810145443.1053387-2-privatesub2@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hPg5kcy3KfBtOZY7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 10, 2023 at 05:54:26PM +0300, Aleksandr Shubin wrote:

> +allOf:
> +  - $ref: pwm.yaml#
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: allwinner,sun20i-r329-pwm
> +
> +    then:
> +      required:
> +        - allwinner,pwm-channels
> +
> +    else:
> +      not:
> +        required:
> +          - allwinner,pwm-channels

Hmm, I realise I lead you astray a little. This can be reduced to
    else:
      properties:
        allwinner,pwm-channels: false

If you respin, please update to that. Otherwise,
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--hPg5kcy3KfBtOZY7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZNUMYgAKCRB4tDGHoIJi
0k5XAPwK6ZnDy6YMcS7YyTbkZhp9bNvTudr9mvnqvkaKJWAqdQEAj6Ky6dhw1dD2
9IZEmfA6h0yN/+zGi1B3HLfafbpNzg4=
=Pcfq
-----END PGP SIGNATURE-----

--hPg5kcy3KfBtOZY7--
