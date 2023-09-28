Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A357B16CE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 11:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbjI1JD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 05:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbjI1JDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 05:03:55 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1CC9AC;
        Thu, 28 Sep 2023 02:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1695891832; x=1727427832;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OBb0qKSmHLcYJsOeped2EGIbj9N76LFCrWGOCNJOufU=;
  b=OffWTrKJmUmlOvTtClgC/hBzZh3zX5LPh14+8/Q3a58AU1Ewdw9D49yw
   eDlm/w+FlKRpk4t23ayQTaAJyDrjVGRGvyQT1wZ/kjgBkVQ74vwrGN4VT
   3u6mxnmHytZ3Fy7l7Nj41S83b46I9a8gt+C9L8f94SVykSDjmNNXMN0yU
   SyFKsmdZqgg9CZw4hKztnOLx/yQRFYdgcga+bObK1obiHCDJpiL8HXXtB
   kygDW/4V/VSzMvXUpwBql0zibI85I7ZC+gZeBYQJ1HZ9KCqHvg5fheoDN
   CeOzfHimcDXb3GQxJTLIkvAT2pkCexA6iTC9ibOknMbVALUHt3Cn6JlW+
   w==;
X-CSE-ConnectionGUID: G7oJAJERQB+qO+xfGDy6Ng==
X-CSE-MsgGUID: 2pAk1O+nRbeRA9AAhduaww==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,183,1694761200"; 
   d="asc'?scan'208";a="174047323"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Sep 2023 02:03:51 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 28 Sep 2023 02:03:51 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 28 Sep 2023 02:03:48 -0700
Date:   Thu, 28 Sep 2023 10:03:30 +0100
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
Message-ID: <20230928-winter-uranium-cc07496a49e3@wendy>
References: <20230928-bring-gnarly-05eeeb85f3c5@wendy>
 <IA1PR20MB49537BCE9EF342B55174B829BBC1A@IA1PR20MB4953.namprd20.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="b6mSgDjZ5Q8taV3j"
Content-Disposition: inline
In-Reply-To: <IA1PR20MB49537BCE9EF342B55174B829BBC1A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--b6mSgDjZ5Q8taV3j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 28, 2023 at 04:24:54PM +0800, Inochi Amaoto wrote:
> >
> >On Thu, Sep 28, 2023 at 08:34:42AM +0800, Inochi Amaoto wrote:
> >
> >>>> +properties:
> >>>> +  compatible:
> >>>> +    oneOf:
> >>>> +      - items:
> >>>> +          - const: sophgo,sg2042-clint-mtimer
> >>>
> >>> There's only one of these, so you don't need the oneOf.
> >>
> >> Thanks
> >>
> >>> Also, is the clint here not a thead IP? In which case, you need to ad=
d a
> >>
> >> Yes, The clint is a thead IP, like that of th1520 and allwinner D1.
> >>
> >>> second compatible IMO. That second compatible then would be the one t=
hat
> >>> appears in opensbi etc.
> >>>
> >>
> >> As this is a thead IP, maybe use thead,c900-clint-mtimer is fine?
> >
> >I would suggest calling it -aclint-mtimer instead of clint-mtimer.
> >
>=20
> It is OK for me. As I describe below, now use sophgo as vendor is better.
> Anyway, I will add a new second one in the next patch.
>=20
> >> If so, whether we should replace the "thead,c900-clint" with these sep=
arate
> >> DT to describe the thead clint?
> >
> >No, since that's a different device, right?
> >
>=20
> Yes. It seems sophgo defined these by themselves, but the T-HEAD. Sorry
> for my mistake.

I'm sorry, I don't quite understand this. Do you mean that the IP is not
T-Head, but rather designed by Sophgo? If the IP is made by T-Head, then
I would expect to see something like

compatible =3D "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";

in the dts.

>=20
> >> The DT binding said the thead clint is not
> >> compatible with the sifive clint, so maybe this is a chance to just mo=
ve
> >> them out.
> >
> >I don't think that it really makes sense to do that.

--b6mSgDjZ5Q8taV3j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZRVBYgAKCRB4tDGHoIJi
0vLWAQCaVGggIAebDnmEiJzjw1X/RgLe0+aKKdWYxJ0fcufvIgD/QjEGmlfqom8m
pARBLjaCCUh5j/+WVtng9mGnCts03wA=
=pEic
-----END PGP SIGNATURE-----

--b6mSgDjZ5Q8taV3j--
