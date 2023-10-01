Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A622A7B4725
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 13:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234890AbjJALZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 07:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234821AbjJALZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 07:25:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4750DBD
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 04:25:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4866C433C8;
        Sun,  1 Oct 2023 11:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696159522;
        bh=PUipNyho5r4Psjk0eUfxhKXe9d7G3c2FY5IEw3imF0o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YcfwTZmoo6jGSte0O0n8afk14KpMPshBNFzDQX6NRwpFBGbnP1gvpfmkAIZaCln2k
         gLuBUMm+ZBVoH+1vYr4fNyfHR4U3FpEnucNVBEe8bxiMfNkoctILHc88MdpFW+h6qW
         VBJhuFmOdx6hLO7zT5ZRgVAXvCF8QSHN88xyIhVN+oXnZIOJJqCX5LEn79/fBvQIbG
         KoiLGHSCbJh9C3lBcaclrRW/b4jpWmhB0ZLyo0eJ9EV22o6wRqJ1gdPvXBPunHJVrR
         QUnudpzl90lfUE4R7Dd8DBZaWW0wd4oCSwuuSVQk8v/gTyPNVn+iCecUXGS6HkLQjs
         ahHz3+8V9strQ==
Date:   Sun, 1 Oct 2023 12:25:17 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Anup Patel <anup@brainfault.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        Inochi Amaoto <inochiama@outlook.com>, chao.wei@sophgo.com,
        xiaoguang.xing@sophgo.com
Subject: Re: [PATCH 1/5] dt-bindings: interrupt-controller: Add SOPHGO
 CV1800B plic
Message-ID: <20231001-manila-unsent-6163d2a08145@spud>
References: <20230930123937.1551-1-jszhang@kernel.org>
 <20230930123937.1551-2-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="MA1P9/d49We4ZiCr"
Content-Disposition: inline
In-Reply-To: <20230930123937.1551-2-jszhang@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MA1P9/d49We4ZiCr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 30, 2023 at 08:39:33PM +0800, Jisheng Zhang wrote:
> Add compatible string for SOPHGO CV1800B plic.
>=20
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  .../bindings/interrupt-controller/sifive,plic-1.0.0.yaml         | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifiv=
e,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/=
sifive,plic-1.0.0.yaml
> index 16f9c4760c0f..5c4539881a22 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-=
1.0.0.yaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-=
1.0.0.yaml
> @@ -65,6 +65,7 @@ properties:
>        - items:
>            - enum:
>                - allwinner,sun20i-d1-plic
> +              - sophgo,cv1800-plic
>                - sophgo,sg2042-plic
>                - thead,th1520-plic
>            - const: thead,c900-plic
> --=20
> 2.40.1
>=20

--MA1P9/d49We4ZiCr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZRlW/QAKCRB4tDGHoIJi
0hSKAP92lZxT2iiinmDL1BKX4qpZYu3g7KH/TCU9/uIef7ll4AD/Yf7u4wHaHvLx
av8JWEjoAfAlfpRq4nlnWoElnzANRQA=
=Vebj
-----END PGP SIGNATURE-----

--MA1P9/d49We4ZiCr--
