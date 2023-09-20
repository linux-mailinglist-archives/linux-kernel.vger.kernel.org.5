Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3C3F7A75C2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 10:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbjITIXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 04:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbjITIXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 04:23:46 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A9BB99;
        Wed, 20 Sep 2023 01:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1695198219; x=1726734219;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=h8v+kPqS+HjJo2h9d2NO6MN5S7urQThJPL5oA0y2o4A=;
  b=QpLHrG2IuObaFFzi4IJld2IH3EzVoGsEQGEOIKFQutleXaZSiH6zLq/X
   5QtF65BMCCU98jH+mAPSHmFQvUNRyR3v5bhXkTwBvrMYTtZeGxIHH7ZJi
   dQUXctD1EygwVjMDfqOzahe3vRhKavWuVM0w7537vSL4TDXJg2mDHOMzF
   N7lVt23UJHFhdmO4xvmtt2i1wISwoZSlrME6cIZCYnBh1l18+ppxFBiP+
   V6we0TWRO7E+zS6nQW1sA/3KYHqGSEUepNJDtz59oIJ6fOJIqkbN4v4YM
   CoAkzHnzMMZXPEKRTGKil5cxjCbzEvqMwq/7Qbp5eSrbq0Eyfm0iuHt6T
   Q==;
X-CSE-ConnectionGUID: 447RiIfjRayIHUjMe4w4Kg==
X-CSE-MsgGUID: AttvSdqhTIu+lS3BC2Ba3A==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="asc'?scan'208";a="5613544"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Sep 2023 01:23:38 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 20 Sep 2023 01:23:01 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 20 Sep 2023 01:22:58 -0700
Date:   Wed, 20 Sep 2023 09:22:41 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Chen Wang <unicornxw@gmail.com>
CC:     <aou@eecs.berkeley.edu>, <chao.wei@sophgo.com>, <conor@kernel.org>,
        <devicetree@vger.kernel.org>, <emil.renner.berthing@canonical.com>,
        <guoren@kernel.org>, <jszhang@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <palmer@dabbelt.com>, <paul.walmsley@sifive.com>,
        <robh+dt@kernel.org>, <xiaoguang.xing@sophgo.com>,
        Chen Wang <wangchen20@iscas.ac.cn>
Subject: Re: [PATCH v2 02/11] dt-bindings: vendor-prefixes: add milkv/sophgo
Message-ID: <20230920-unable-impish-373fd26b7d16@wendy>
References: <cover.1695189879.git.wangchen20@iscas.ac.cn>
 <dbd7d823a73d8a9484efcd55f6616f5392daf608.1695189879.git.wangchen20@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SwIF3I7rfx1hXsx3"
Content-Disposition: inline
In-Reply-To: <dbd7d823a73d8a9484efcd55f6616f5392daf608.1695189879.git.wangchen20@iscas.ac.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--SwIF3I7rfx1hXsx3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Yo,

On Wed, Sep 20, 2023 at 02:37:28PM +0800, Chen Wang wrote:
> Add new vendor strings to dt bindings.
> These new vendor strings are used by
> - Sophgo SG2042 SoC [1]
> - Milk-V Pioneer board [2], which uses SG2042 chip.
>=20
> [1]: https://en.sophgo.com/product/introduce/sg2042.html
> [2]: https://milkv.io/pioneer

If you resend, make these link tags please. Otherwise,
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> Acked-by: Xiaoguang Xing <xiaoguang.xing@sophgo.com>
> Signed-off-by: Chen Wang <wangchen20@iscas.ac.cn>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Doc=
umentation/devicetree/bindings/vendor-prefixes.yaml
> index 573578db9509..fcca9e070a9a 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -863,6 +863,8 @@ patternProperties:
>      description: MikroElektronika d.o.o.
>    "^mikrotik,.*":
>      description: MikroTik
> +  "^milkv,.*":
> +    description: MilkV Technology Co., Ltd
>    "^miniand,.*":
>      description: Miniand Tech
>    "^minix,.*":
> @@ -1273,6 +1275,8 @@ patternProperties:
>      description: Solomon Systech Limited
>    "^sony,.*":
>      description: Sony Corporation
> +  "^sophgo,.*":
> +    description: Sophgo Technology Inc.
>    "^sourceparts,.*":
>      description: Source Parts Inc.
>    "^spansion,.*":
> --=20
> 2.25.1
>=20

--SwIF3I7rfx1hXsx3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQqr0QAKCRB4tDGHoIJi
0uyKAPsHIRY81qzmFLxN6FMUw75lAg98PudIOjgADw5xJjpEIAD/cyrHv5LAaY6t
yPmwkTQt4gexHGLZEQIyIf/v7yfSnwc=
=W+PQ
-----END PGP SIGNATURE-----

--SwIF3I7rfx1hXsx3--
