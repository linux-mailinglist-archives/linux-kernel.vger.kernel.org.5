Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC747B17F2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 11:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbjI1J41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 05:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjI1J40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 05:56:26 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DABD818F;
        Thu, 28 Sep 2023 02:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1695894983; x=1727430983;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gu41GdqWZpyGZbFQhinh3hZ49LqQBY/54l12OPAul68=;
  b=mKWGgMvvwzF5tdBjLdxx3ukF2XebQJQhtzE0xH2/1frCD8/aukerNWKJ
   Zwr2w+Id1ENEXOEShIONcqqMZW/DW2/tdJeu+T8hYXnHZG8OhCUQZiIwu
   BeYJgycBfylcG4oUXaoZsxoP8mE0C96pavYiF/FT3z6eoBd0ykZAdoWkk
   57+7cAV/WMN0D+yMeLUT2U6GMLGSp64XTizxL0OqohAjgTb/ymdJQrIzz
   rds8C0dmvGEMrEV/g6PImcTfiibmtpag3qshQgka/E3gVdJuzk8FJRGa5
   aPoOLmmBtMoi72dG2R0hES4wBmRHw455SIqxbP+B+khiNmrXWvPEv7Ws0
   A==;
X-CSE-ConnectionGUID: e6oGy2ElS9ywph8O/5SXfg==
X-CSE-MsgGUID: Kkjy0IllSBuMt+urRxxNyQ==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,183,1694761200"; 
   d="asc'?scan'208";a="6909572"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Sep 2023 02:56:22 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 28 Sep 2023 02:56:21 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 28 Sep 2023 02:56:18 -0700
Date:   Thu, 28 Sep 2023 10:55:59 +0100
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
Message-ID: <20230928-scorer-study-0de8672fca01@wendy>
References: <20230928-winter-uranium-cc07496a49e3@wendy>
 <IA1PR20MB495373BAA77A74C5EEB7BE49BBC1A@IA1PR20MB4953.namprd20.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SpJlgRxPBtmlA4kN"
Content-Disposition: inline
In-Reply-To: <IA1PR20MB495373BAA77A74C5EEB7BE49BBC1A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--SpJlgRxPBtmlA4kN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 28, 2023 at 05:39:17PM +0800, Inochi Amaoto wrote:
> >>>> If so, whether we should replace the "thead,c900-clint" with these s=
eparate
> >>>> DT to describe the thead clint?
> >>>
> >>> No, since that's a different device, right?
> >>>
> >>
> >> Yes. It seems sophgo defined these by themselves, but the T-HEAD. Sorry
> >> for my mistake.
> >
> >I'm sorry, I don't quite understand this. Do you mean that the IP is not
> >T-Head, but rather designed by Sophgo? If the IP is made by T-Head, then
> >I would expect to see something like
> >
> >compatible =3D "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
> >
> >in the dts.
> >
>=20
> AFAIK, the clint IP is designed by T-HEAD, not Sophgo. Sophgo change this
> IP layout to fit its weird cpu design. But in my test, the timer and mswi
> of clint is compatible with the T-HEAD one.

> So we should treat this as T-HEAD IP, not Sophgo?

Yes, in the way I demonstrated above probably.

--SpJlgRxPBtmlA4kN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZRVNrwAKCRB4tDGHoIJi
0iMwAQC+tShSe2jUxLEY0+NJy2ORpiI7U6yahbJtQgYC6InsgAEAwWsdMan7OX7r
7Cm33/K20+L8n6UV2uJ9Qgolx3/peA4=
=CNXQ
-----END PGP SIGNATURE-----

--SpJlgRxPBtmlA4kN--
