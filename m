Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17C937A7604
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 10:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233036AbjITIh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 04:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232338AbjITIhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 04:37:54 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA218F;
        Wed, 20 Sep 2023 01:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1695199068; x=1726735068;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+ubhK+ohsrm/rVYz4hePic08sMvDAPezKqgxUkBOSE4=;
  b=ktnI+oe/YGQdztK5m+MQWjL265YVWnR+euYFPDx4BubqG40I3qqQV6bT
   BNN0n0Rw1C/BTA4hjrCT+NcntaXcTEVAurR9q4VZ0WvNo1vjvQhoD+b5Q
   EhT/pgQ/AYNWHQhooeVSE1ggQL7wgGA/G1XaiYC6N+COkLAUn1Buc6QnV
   F6YPVg/0FRw7dzDovGOX2D6U7YN/mR9c6lxi4YdQdaeNqXMW4hchi1Y9c
   o7siIspYiI5/n7pp7Mr0lV/iGCxjLP65CzIAhIlCiL8IYbH3yqPudgpTU
   s2269ztN4UBdCmyIYLeBpKP0ZKcFQjbCZA8xg0s0yQOPjKvW0rboNbIgX
   Q==;
X-CSE-ConnectionGUID: WjP0000pQd28t1EnxNpDvg==
X-CSE-MsgGUID: ZLmgIhqLQDq6kpTwpBgavw==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="asc'?scan'208";a="5615763"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Sep 2023 01:37:47 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 20 Sep 2023 01:37:46 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex03.mchp-main.com (10.10.85.151)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 20 Sep 2023 01:37:43 -0700
Date:   Wed, 20 Sep 2023 09:37:26 +0100
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
Subject: Re: [PATCH v2 04/11] dt-bindings: riscv: Add T-HEAD C920 compatibles
Message-ID: <20230920-borax-swipe-dbf4aa8ed4e2@wendy>
References: <cover.1695189879.git.wangchen20@iscas.ac.cn>
 <c5061fbe8ef9c4971cd45de7b5d8408dc1b848b4.1695189879.git.wangchen20@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="BiR7UZp5nLCqNrq7"
Content-Disposition: inline
In-Reply-To: <c5061fbe8ef9c4971cd45de7b5d8408dc1b848b4.1695189879.git.wangchen20@iscas.ac.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--BiR7UZp5nLCqNrq7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 20, 2023 at 02:38:08PM +0800, Chen Wang wrote:
> The C920 is RISC-V CPU cores from T-HEAD Semiconductor.
> Notably, the C920 core is used in the SOPHGO SG2042 SoC.
>=20
> Acked-by: Xiaoguang Xing <xiaoguang.xing@sophgo.com>
> Signed-off-by: Chen Wang <wangchen20@iscas.ac.cn>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

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

--BiR7UZp5nLCqNrq7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQqvRgAKCRB4tDGHoIJi
0s4+AQC6Ty5DsHJBz4+NX28nmY1bLvz9GbBkvEyXpaBaCnRxLwEAjZQNYITGCtsr
MOaERg3cYcLTGM30m/i2J4lYLmSsiwA=
=wDzS
-----END PGP SIGNATURE-----

--BiR7UZp5nLCqNrq7--
