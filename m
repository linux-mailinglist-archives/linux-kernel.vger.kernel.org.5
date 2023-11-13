Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA7E97E9D50
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 14:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbjKMNhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 08:37:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjKMNhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 08:37:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F50019E
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 05:36:57 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF26CC433C7;
        Mon, 13 Nov 2023 13:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699882617;
        bh=7XqO95u4Ap+QRuJXd6EyepWelg/diNFZubTgB9saIII=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g4oELlsfbrOfRr8QoFxjUm+ZUpvO+8U5+2BG2aEqR+Rr9e23eHttQf4CDk4bnu7Mz
         5qlBFjJ0/ydlei6F3M5HRadYBylYF9Wb+34XvpK8Uj58PXNpwSgeMpRPwV/NxHeCQF
         M0f2Tu6kcyeAbDjNlF/LhXScNuTCpmicsQBYM256Geueedha3ljdliigBgSPYHap3V
         MYdBNnM+FpjoxZTUwNX59otGiToVn47/5GWpHH958NsfVsdKs5bWQDoQkgIBy7zWo7
         v+vF4ZYzswFt0/gwo5Pe/lasbWwVvHbYe5l90ra7NRRNYamZW2fYn00BmZzox3cte/
         UgtrytPKKqXkA==
Date:   Mon, 13 Nov 2023 13:36:54 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Chao Wei <chao.wei@sophgo.com>,
        Chen Wang <unicorn_wang@outlook.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH 1/4] dt-bindings: reset: Add binding for Sophgo CV1800B
 reset controller
Message-ID: <20231113-washable-elbow-629bf42b9be1@squawk>
References: <20231113005503.2423-1-jszhang@kernel.org>
 <20231113005503.2423-2-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tzFxyJuc7xawNjzv"
Content-Disposition: inline
In-Reply-To: <20231113005503.2423-2-jszhang@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tzFxyJuc7xawNjzv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 13, 2023 at 08:55:00AM +0800, Jisheng Zhang wrote:
> Add devicetree binding for Sophgo CV1800B SoC reset controller.
>=20
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>

With the unterminated ifndef that was pointed out by the robots fixed,
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

> +/*				0-1	*/
> +/*				10	*/
> +/*				13	*/
> +/*				15	*/
> +/*				17	*/
> +/*				36-39	*/
> +/*				53-57	*/
> +/*				59-60	*/
> +/*				63-73	*/
> +/*				90	*/
> +/*				94	*/
> +/*				102-292	*/

There are quite a lot of gaps here, do you know why that is?

Thanks,
Conor.

--tzFxyJuc7xawNjzv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZVImcgAKCRB4tDGHoIJi
0u9kAP46DfhtAfiGORBa22Q/gUV3tOz4iPG66mKpSXiWP887uQEA91//1i0UddnN
GAWSlENHPm1tZPfnKSq4WqLpkJVhTw8=
=THoT
-----END PGP SIGNATURE-----

--tzFxyJuc7xawNjzv--
