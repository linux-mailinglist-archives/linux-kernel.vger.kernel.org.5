Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 006077B12D1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 08:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjI1G1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 02:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjI1G1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 02:27:53 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30EAB99;
        Wed, 27 Sep 2023 23:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1695882471; x=1727418471;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mBkNygKzMaSU02DnlJ0mWUgp02ttdarWgUm5ztFYDpE=;
  b=WRCPLx3PMOHscVTlGotCkNea4Cz/vdwJ4uh91Cdnp5M2yEeLGnYB5VAV
   kplWwg509pAMR0sD8ygjHAd62wbcYsr1pWYfpYTqZaWZq8uq2NKIatsKQ
   2KdK0n9y3ZVYJ9Q8WbAzBqFOgvo/v3irhynIeRABJt4iuxgkBu1axTmEE
   dmkMB7CJiHKVK9bGhiug6c7x+4qjL4OCAHvUXFwDis+TwXafhJOWr66xn
   sJUOS/DRwG5eUzq3X63d3U0KDJ9Zktz4UeqhLkAZVlUSW8Hhs4PPzWb/V
   52Er1Cb5ZyAInXRsJeq6BZD4L7M09U8hqdba+9vlYC4zgMUhvBB2ATNTL
   g==;
X-CSE-ConnectionGUID: ESpAaoDnSL2M9L5hctp+oQ==
X-CSE-MsgGUID: SxFkAdzQTq2FWm/6/W8BNg==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,183,1694761200"; 
   d="asc'?scan'208";a="7286625"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Sep 2023 23:27:50 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 27 Sep 2023 23:27:30 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 27 Sep 2023 23:27:27 -0700
Date:   Thu, 28 Sep 2023 07:27:09 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Inochi Amaoto <inochiama@outlook.com>
CC:     Conor Dooley <conor@kernel.org>, <aou@eecs.berkeley.edu>,
        <chao.wei@sophgo.com>, <devicetree@vger.kernel.org>,
        <emil.renner.berthing@canonical.com>, <guoren@kernel.org>,
        <jszhang@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <palmer@dabbelt.com>, <paul.walmsley@sifive.com>,
        <robh+dt@kernel.org>, <xiaoguang.xing@sophgo.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Chen Wang <wangchen20@iscas.ac.cn>
Subject: Re: [PATCH v3 06/11] dt-bindings: timer: Add Sophgo sg2042 CLINT
 timer
Message-ID: <20230928-bring-gnarly-05eeeb85f3c5@wendy>
References: <20230927-uncorrupt-bronco-72e35232b1cc@spud>
 <IA1PR20MB49534EDF586FCC784C81C5ABBBC1A@IA1PR20MB4953.namprd20.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UHaWB33MwrDFW0WP"
Content-Disposition: inline
In-Reply-To: <IA1PR20MB49534EDF586FCC784C81C5ABBBC1A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--UHaWB33MwrDFW0WP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 28, 2023 at 08:34:42AM +0800, Inochi Amaoto wrote:

> >> +properties:
> >> +  compatible:
> >> +    oneOf:
> >> +      - items:
> >> +          - const: sophgo,sg2042-clint-mtimer
> >
> >There's only one of these, so you don't need the oneOf.
>=20
> Thanks
>=20
> >Also, is the clint here not a thead IP? In which case, you need to add a
>=20
> Yes, The clint is a thead IP, like that of th1520 and allwinner D1.
>=20
> >second compatible IMO. That second compatible then would be the one that
> >appears in opensbi etc.
> >
>=20
> As this is a thead IP, maybe use thead,c900-clint-mtimer is fine?

I would suggest calling it -aclint-mtimer instead of clint-mtimer.

> If so, whether we should replace the "thead,c900-clint" with these separa=
te
> DT to describe the thead clint?

No, since that's a different device, right?

> The DT binding said the thead clint is not
> compatible with the sifive clint, so maybe this is a chance to just move
> them out.

I don't think that it really makes sense to do that.

Thanks,
Conor.


--UHaWB33MwrDFW0WP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZRUcuQAKCRB4tDGHoIJi
0vArAP9fAULrrTApZmFmDl2++GE7+UOVwdl43Vjc4kOusjA+0AEA5UD0/+yLvol9
iUxnGTrAiIOBHo3ManpsssXg5sNniQ0=
=VnCU
-----END PGP SIGNATURE-----

--UHaWB33MwrDFW0WP--
