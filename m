Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 987A47A2087
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 16:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235598AbjIOOLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 10:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235611AbjIOOLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 10:11:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1431F268A
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 07:11:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E978BC433C9;
        Fri, 15 Sep 2023 14:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694787069;
        bh=Io4WAeudrk6GrRUOfTXXAh8NLlPv6VHeQ/TAl6xHSRA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U7rJ+eYzqTMUXBOSTFHpxp1WJQ6MKXSbTfvNzDre5bFqK6ccE7GeDMFSFwYXs8Vbe
         4r3L9hm5BhzxmXngtgLNSdNaALsZWyFldO+7eENEcETHGxqI/cR46PSmsNaOi2jO/C
         0Nr7BkWEzmHmcvhOxLTkRGKeXNriT33DZBnT9n2Q0kVydqnJIQtDCSsiqqB6kQJS8i
         re6zDjDnwjmSnBPp68kY7qMVCR6dQjyRWrM2rEV7AynCzakeQRdNws61Mez0GT5Exg
         AX/8kF+tyk+YVp8EGaHFaqMFtfPNgIHa859dVFMEOVDmmL+zuD/Q/DH4F4jiZq3fUw
         f7iirUQz0muPA==
Date:   Fri, 15 Sep 2023 15:11:04 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Wang Chen <unicornxw@gmail.com>
Cc:     linux-riscv@lists.infradead.org, aou@eecs.berkeley.edu,
        krzysztof.kozlowski+dt@linaro.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jszhang@kernel.org, guoren@kernel.org, chao.wei@sophgo.com,
        xiaoguang.xing@sophgo.com, Wang Chen <wangchen20@iscas.ac.cn>
Subject: Re: [PATCH 03/12] dt-bindings: riscv: add sophgo sg2042 bindings
Message-ID: <20230915-boxing-emporium-669d2715a347@spud>
References: <20230915072242.117935-1-wangchen20@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7mnyoaMGIeydQZQF"
Content-Disposition: inline
In-Reply-To: <20230915072242.117935-1-wangchen20@iscas.ac.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7mnyoaMGIeydQZQF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 15, 2023 at 03:22:42PM +0800, Wang Chen wrote:
> Add DT binding documentation for the Sophgo SG2042 Soc [1] and the
> Milk-V Pioneer board [2].
>=20
> [1]: https://en.sophgo.com/product/introduce/sg2042.html
> [2]: https://milkv.io/pioneer
>=20
> Signed-off-by: Wang Chen <wangchen20@iscas.ac.cn>
> Signed-off-by: Xiaoguang Xing <xiaoguang.xing@sophgo.com>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 90f13281d297..0e0d477dab38 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20063,6 +20063,12 @@ F:	drivers/char/sonypi.c
>  F:	drivers/platform/x86/sony-laptop.c
>  F:	include/linux/sony-laptop.h
> =20
> +SOPHGO DEVICETREES
> +M:	Xiaoguang Xing <xiaoguang.xing@sophgo.com>
> +M:	Chao Wei <chao.wei@sophgo.com>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/riscv/sophgo.yaml

I would like to see an Ack from those you are volunteering here.

Thanks,
Conor.

--7mnyoaMGIeydQZQF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQRl+AAKCRB4tDGHoIJi
0ji5AQCqmobFFy4Yzr1rP3PjWE6fjopsBHPqt6RocnjXhOSzqQD9F1AsZRZN+teA
oT85ufv9f6HJpdZ8+sI+t+j9LbEQmgc=
=jVSa
-----END PGP SIGNATURE-----

--7mnyoaMGIeydQZQF--
