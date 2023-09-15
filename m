Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC517A2089
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 16:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235581AbjIOOL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 10:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234055AbjIOOLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 10:11:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5051FCE
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 07:11:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34C4AC433C7;
        Fri, 15 Sep 2023 14:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694787109;
        bh=7eWWvHfw6GRqHLXpTAHNgpwMQoiTfPM79bZDUURySQ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Aot5xG/6zIolsjLGE5BJmtgsqhht4rr+me+2ndd8awnkztVbNhAiLAvvsME7T59k+
         ouRa5EjpKsSiMqOfu4anPN+YLXYZS8GiuNVwRqGMMD1OFinsUUn/vO99YLghxFT/GX
         J5LRTFmw+yyemnwpFV9q4rzR4yA8b1KoDXUiLhO///f7jPZaiCjfx9vPJf+sdmwBCN
         ZunHALiK4sZKZmvJfO2pCw9BqLXTKETuaXYX3s+giP4i8tgy11zPmrNH/1JkvgiES4
         d+TNqqCfrrtawHn759zJpSAfW5zmH98hjcV96BpnV3A9TOxik/0n7uJGaAd3Dbskve
         H+BQwEJghQsBw==
Date:   Fri, 15 Sep 2023 15:11:43 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Wang Chen <unicornxw@gmail.com>
Cc:     linux-riscv@lists.infradead.org, aou@eecs.berkeley.edu,
        krzysztof.kozlowski+dt@linaro.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jszhang@kernel.org, guoren@kernel.org, chao.wei@sophgo.com,
        xiaoguang.xing@sophgo.com, Wang Chen <wangchen20@iscas.ac.cn>
Subject: Re: [PATCH 04/12] dt-bindings: riscv: Add T-HEAD C920 compatibles
Message-ID: <20230915-muster-viability-93d7d4ec2b49@spud>
References: <20230915072333.117991-1-wangchen20@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="53Jv7XerkC9sk4oP"
Content-Disposition: inline
In-Reply-To: <20230915072333.117991-1-wangchen20@iscas.ac.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--53Jv7XerkC9sk4oP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 15, 2023 at 03:23:33PM +0800, Wang Chen wrote:
> The C920 is RISC-V CPU cores from T-HEAD Semiconductor.
> Notably, the C920 core is used in the SOPHGO SG2042 SoC.
>=20
> Signed-off-by: Wang Chen <wangchen20@iscas.ac.cn>
> Signed-off-by: Xiaoguang Xing <xiaoguang.xing@sophgo.com>

I figure this is missing a From: or Co-developed-by line.

> ---
>  Documentation/devicetree/bindings/riscv/cpus.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Document=
ation/devicetree/bindings/riscv/cpus.yaml
> index 38c0b5213736..185a0191bad6 100644
> --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> @@ -47,6 +47,7 @@ properties:
>                - sifive,u74-mc
>                - thead,c906
>                - thead,c910
> +              - thead,c920
>            - const: riscv
>        - items:
>            - enum:
> --=20
> 2.25.1
>=20

--53Jv7XerkC9sk4oP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQRmHwAKCRB4tDGHoIJi
0u3xAP9AR6sV69ClVxJ4lGrLIj47Y3q7kzaeM9RHU7cVbQz/ywD/Z/QLPAHkU4kN
CB9Z/+WTN9m9fMZFb3S9e2+975eH2gY=
=4q42
-----END PGP SIGNATURE-----

--53Jv7XerkC9sk4oP--
