Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DEE57A7607
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 10:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232742AbjITIiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 04:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232772AbjITIiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 04:38:20 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A6193;
        Wed, 20 Sep 2023 01:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1695199095; x=1726735095;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ib3NY21SFhiuriCmUuptRiwj4Fxat7usIIH8aA6pySA=;
  b=i5JQa8U9+Ni4QvCIZucj/ijumeQFdR7WvYL9F5X/gjxvc658jxe+BfaL
   FQQbDwPKi1zLgsL9YYLtqrjhcu+Fbd0TsQxkpcajdcciM7AwKzBKimyxm
   F/29qKkns4+0g/jX2/xodLdh/KSDuJes1/rAiVyKju2VtsGZs+UfE04DF
   +j9SM0uFrBrIHd1OZHZ3uahFCcO0hsIaWjgnfcOxgl+7PE47Qptm3emHA
   ee1/GtpzyPaqrMt6p60EXb9CMgT2sabDyQ01IYXKM9Pf8jTqD8OKKvoS1
   6m6xSUpPVEuAhZpx+UglTHq9JcklfiOOADqqdxLrZ9f60jXSZLXhZb7dR
   A==;
X-CSE-ConnectionGUID: TDHxoFc6SfigoLslkDh3sw==
X-CSE-MsgGUID: E4nCx99yTOCLcMPHLH1OGQ==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="asc'?scan'208";a="236152345"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Sep 2023 01:38:14 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 20 Sep 2023 01:38:13 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 20 Sep 2023 01:38:10 -0700
Date:   Wed, 20 Sep 2023 09:37:53 +0100
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
Subject: Re: [PATCH v2 07/11] dt-bindings: serial: snps-dw-apb-uart: Add
 Sophgo SG2042 uarts
Message-ID: <20230920-pursuable-liquid-ed0b6d0b60b0@wendy>
References: <cover.1695189879.git.wangchen20@iscas.ac.cn>
 <05fcf91d60468323a6c7cdb8ac57c356ab4a3050.1695189879.git.wangchen20@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fN0bv+HktN9C4V9U"
Content-Disposition: inline
In-Reply-To: <05fcf91d60468323a6c7cdb8ac57c356ab4a3050.1695189879.git.wangchen20@iscas.ac.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--fN0bv+HktN9C4V9U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 20, 2023 at 02:39:58PM +0800, Chen Wang wrote:
> From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
>=20
> Add compatible for the uarts on the Sophgo SG2042 RISC-V SoC.
>=20
> Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> Signed-off-by: Chen Wang <wangchen20@iscas.ac.cn>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.ya=
ml b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
> index 17c553123f96..011d89e6df0f 100644
> --- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
> +++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
> @@ -45,6 +45,7 @@ properties:
>            - const: snps,dw-apb-uart
>        - items:
>            - enum:
> +              - sophgo,sg2042-uart
>                - starfive,jh7100-hsuart
>                - starfive,jh7100-uart
>            - const: snps,dw-apb-uart
> --=20
> 2.25.1
>=20

--fN0bv+HktN9C4V9U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQqvYQAKCRB4tDGHoIJi
0iuWAP92pOVGoRVDilmFwSOHZ0wTYrKYCSnQBPWoG7A4nrtTygD/VuZ5gfsopuP/
esA/RiT+UAEgupeg3FWJ/qygDCSDqQg=
=+ir7
-----END PGP SIGNATURE-----

--fN0bv+HktN9C4V9U--
