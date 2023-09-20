Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1C487A76BE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 11:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234024AbjITJBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 05:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233877AbjITI7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 04:59:53 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F4A610EB;
        Wed, 20 Sep 2023 01:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1695200348; x=1726736348;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=twi5zzTRqTKRTREdHFD+3H5EbT4iC9Y0KWjXkGJdNK0=;
  b=zJM8A0Vp/OxzauMuww7YP9l0t8/gLIdYniOKn2un5B5akARF+Tts1w8E
   VMpTMep08zSS8FbYgaFc5K+c5PpAvdpSxSGuj0zXfARtdA1bRlicd9CBK
   ld9p9uH3fAlaokFTFQ5d82IYV+0qwpAxG0ZuXm2NGQbcKcK65w8Vgd/oc
   7buSO5pizGIW3BkF2H3Q1SiDMmyguGOamHO1KkkOvE05ny+C98tHdw/7q
   QRrO8KgFgJ8MEmX/RCj8G1fVMT73bUKZDoGAkE0PyFl1tgu+vubbfFtEs
   IFBSUkEjtlKrxYUJCI+OXVtxM7avzFl/pD7gpUrg4dOmPUX4zlQNe8sbH
   g==;
X-CSE-ConnectionGUID: fFUBSqm4QZClaOyC4aCkiQ==
X-CSE-MsgGUID: e4NomMjsTjGUqQ7luszpIQ==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="asc'?scan'208";a="236155192"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Sep 2023 01:59:07 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 20 Sep 2023 01:58:12 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex03.mchp-main.com (10.10.85.151)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 20 Sep 2023 01:58:09 -0700
Date:   Wed, 20 Sep 2023 09:57:52 +0100
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
Subject: Re: [PATCH v2 05/11] dt-bindings: interrupt-controller: Add SOPHGO's
 SG2042 PLIC
Message-ID: <20230920-crisped-gumball-eddd475e8345@wendy>
References: <cover.1695189879.git.wangchen20@iscas.ac.cn>
 <11eca9395bf730f41f142be2f8d26f527e36517b.1695189879.git.wangchen20@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qqReSDsxlih5FLto"
Content-Disposition: inline
In-Reply-To: <11eca9395bf730f41f142be2f8d26f527e36517b.1695189879.git.wangchen20@iscas.ac.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--qqReSDsxlih5FLto
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 20, 2023 at 02:39:03PM +0800, Chen Wang wrote:
> Add compatible string for SOPHGO SG2042 plic.
>=20
> Acked-by: Xiaoguang Xing <xiaoguang.xing@sophgo.com>
> Signed-off-by: Chen Wang <wangchen20@iscas.ac.cn>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

> ---
>  .../bindings/interrupt-controller/sifive,plic-1.0.0.yaml         | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifiv=
e,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/=
sifive,plic-1.0.0.yaml
> index dc1f28e55266..16f9c4760c0f 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-=
1.0.0.yaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-=
1.0.0.yaml
> @@ -65,6 +65,7 @@ properties:
>        - items:
>            - enum:
>                - allwinner,sun20i-d1-plic
> +              - sophgo,sg2042-plic
>                - thead,th1520-plic
>            - const: thead,c900-plic
>        - items:
> --=20
> 2.25.1
>=20

--qqReSDsxlih5FLto
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQq0EAAKCRB4tDGHoIJi
0gUKAQDTMfZH/bBKr8ry7SDqs/ZWnIK4aoO3JGYe2TJppMC6xAEAp1tCQRon5/sM
fITPQIYNo2LcI73JJchrSPGWIywK2gw=
=ZZ8D
-----END PGP SIGNATURE-----

--qqReSDsxlih5FLto--
