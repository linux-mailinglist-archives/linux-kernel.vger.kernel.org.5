Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE127B472D
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 13:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234866AbjJALZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 07:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234821AbjJALZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 07:25:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB38CCA
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 04:25:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 101B6C433C7;
        Sun,  1 Oct 2023 11:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696159544;
        bh=evB5bY7/C6FdyGJIUHIWeQ7AH4xS5MwJRsf7lHXWW88=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GMS91LYZGS3vcia9UVje1csH1rVyQDefPYcESD0sQUN9sIWhZZUODTqYZIA1+uOmT
         HrXpOCGdtZDx8iA/Oh4LWi8KBzNQaz37y+zzBI/uO1wrMEanfynWet0FEvsiDNSG+J
         xsvTH977/vw6wlXEEbJtV7S8Z798H2IkEmF6xgnWkRPqi59w9YbbTOha+wMeM2RfJl
         LgprszVuIKzH0b8HrJHHF8ls+4Bgw9mYQ7TcPo4x3c59xDDBQQzV2ZGrBApwGUIO70
         oOK5ACc4A6l9ql0QaPk6Dug6MS2Wbv6312te2YGIJTUt9uF47vXJrXV0EhFB9Bf1Y2
         BL4jkQBZX40zg==
Date:   Sun, 1 Oct 2023 12:25:38 +0100
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
Subject: Re: [PATCH 2/5] dt-bindings: timer: Add SOPHGO CV1800B clint
Message-ID: <20231001-election-overdue-c8e016b7c61f@spud>
References: <20230930123937.1551-1-jszhang@kernel.org>
 <20230930123937.1551-3-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dSBleoVdBpsFBCLv"
Content-Disposition: inline
In-Reply-To: <20230930123937.1551-3-jszhang@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dSBleoVdBpsFBCLv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 30, 2023 at 08:39:34PM +0800, Jisheng Zhang wrote:
> Add compatible string for the SOPHGO CV1800B clint.
>=20
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>


> ---
>  Documentation/devicetree/bindings/timer/sifive,clint.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/timer/sifive,clint.yaml b/=
Documentation/devicetree/bindings/timer/sifive,clint.yaml
> index a0185e15a42f..98c76d5893ac 100644
> --- a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> +++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> @@ -37,6 +37,7 @@ properties:
>        - items:
>            - enum:
>                - allwinner,sun20i-d1-clint
> +              - sophgo,cv1800-clint
>                - thead,th1520-clint
>            - const: thead,c900-clint
>        - items:
> --=20
> 2.40.1
>=20

--dSBleoVdBpsFBCLv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZRlXMgAKCRB4tDGHoIJi
0giqAP43PdDm3+hme45s4Rubpl2HyCQBpSrzT5M242Alx1ONnAEA+8fbHhfHJT8V
1MyIzX28EkoOdUMsCNsRXBP2ZbztwwU=
=6qEm
-----END PGP SIGNATURE-----

--dSBleoVdBpsFBCLv--
