Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7875677765F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 12:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234686AbjHJK6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 06:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233017AbjHJK6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 06:58:01 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0730E26AE;
        Thu, 10 Aug 2023 03:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1691664561; x=1723200561;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FDXq+aX/afVuVzyBcXeGCcLoxEtW/3tSfHqYvuf2Kfw=;
  b=fQWXvcKIFu6i+7u9Cb0OKTfD1EmsOr+qtPo12jJm4qzqo/34r0tzyY5g
   qNycnYyn+/XfYKpPxKPFp1LM7FP4sh46aTftgmXXJCGU3PRzRMBIGLtbN
   958xkLtFXWI3EzjtHWxmBRP4feBH74RB6HQroStIavUzbf8W0yxaCrHNt
   nSdAuyQgT5eq4VQLzKy2u/XdeftmFWyj9Ue1GXEoYJ2QV6uZzh2XoHhNx
   h9Gcb58hX46bigqzeomj3UlXe0CypeCtOA/iqWMoab+qfawfPj5iDGfzG
   g4lFtK/b3//QR2URqla4vMtAKq7RnaOSqq9lxXTcY2OfoBf8vCH9nk2hY
   A==;
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="asc'?scan'208";a="228216734"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Aug 2023 03:49:20 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 10 Aug 2023 03:49:18 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 10 Aug 2023 03:49:16 -0700
Date:   Thu, 10 Aug 2023 11:48:38 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Samin Guo <samin.guo@starfivetech.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>
Subject: Re: [-next v1 1/1] riscv: dts: starfive: jh7110: Fix GMAC
 configuration
Message-ID: <20230810-suitable-truffle-eac5d7f93377@wendy>
References: <20230810074646.19076-1-samin.guo@starfivetech.com>
 <20230810074646.19076-2-samin.guo@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cBYCaHNShJUTrmWz"
Content-Disposition: inline
In-Reply-To: <20230810074646.19076-2-samin.guo@starfivetech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--cBYCaHNShJUTrmWz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 10, 2023 at 03:46:46PM +0800, Samin Guo wrote:
> Fixed configuration to improve the speed of TCP RX.
>=20
> Before:
>   # iperf3 -s
>   -----------------------------------------------------------
>   Server listening on 5201 (test #1)
>   -----------------------------------------------------------
>   Accepted connection from 192.168.1.4, port 47604
>   [  5] local 192.168.1.3 port 5201 connected to 192.168.1.4 port 47612
>   [ ID] Interval           Transfer     Bitrate
>   [  5]   0.00-1.00   sec  36.3 MBytes   305 Mbits/sec
>   [  5]   1.00-2.00   sec  35.6 MBytes   299 Mbits/sec
>   [  5]   2.00-3.00   sec  36.5 MBytes   306 Mbits/sec
>   [  5]   3.00-4.00   sec  36.5 MBytes   306 Mbits/sec
>   [  5]   4.00-5.00   sec  35.7 MBytes   300 Mbits/sec
>   [  5]   5.00-6.00   sec  35.4 MBytes   297 Mbits/sec
>   [  5]   6.00-7.00   sec  37.1 MBytes   311 Mbits/sec
>   [  5]   7.00-8.00   sec  35.6 MBytes   298 Mbits/sec
>   [  5]   8.00-9.00   sec  36.4 MBytes   305 Mbits/sec
>   [  5]   9.00-10.00  sec  36.3 MBytes   304 Mbits/sec
>   - - - - - - - - - - - - - - - - - - - - - - - - -
>   [ ID] Interval           Transfer     Bitrate
>   [  5]   0.00-10.00  sec   361 MBytes   303 Mbits/sec        receiver
>=20
> After:
>   # iperf3 -s
>   -----------------------------------------------------------
>   Server listening on 5201 (test #1)
>   -----------------------------------------------------------
>   Accepted connection from 192.168.1.4, port 47710
>   [  5] local 192.168.1.3 port 5201 connected to 192.168.1.4 port 47720
>   [ ID] Interval           Transfer     Bitrate
>   [  5]   0.00-1.00   sec   111 MBytes   932 Mbits/sec
>   [  5]   1.00-2.00   sec   111 MBytes   934 Mbits/sec
>   [  5]   2.00-3.00   sec   111 MBytes   934 Mbits/sec
>   [  5]   3.00-4.00   sec   111 MBytes   934 Mbits/sec
>   [  5]   4.00-5.00   sec   111 MBytes   934 Mbits/sec
>   [  5]   5.00-6.00   sec   111 MBytes   935 Mbits/sec
>   [  5]   6.00-7.00   sec   111 MBytes   934 Mbits/sec
>   [  5]   7.00-8.00   sec   111 MBytes   935 Mbits/sec
>   [  5]   8.00-9.00   sec   111 MBytes   934 Mbits/sec
>   [  5]   9.00-10.00  sec   111 MBytes   934 Mbits/sec
>   [  5]  10.00-10.00  sec   167 KBytes   933 Mbits/sec
>   - - - - - - - - - - - - - - - - - - - - - - - - -
>   [ ID] Interval           Transfer     Bitrate
>   [  5]   0.00-10.00  sec  1.09 GBytes   934 Mbits/sec        receiver
>=20
> Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
> Signed-off-by: Samin Guo <samin.guo@starfivetech.com>

This is
Fixes: 1ff166c97972 ("riscv: dts: starfive: jh7110: Add ethernet device nod=
es")
right?

--cBYCaHNShJUTrmWz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZNTAhgAKCRB4tDGHoIJi
0oyRAQCGxq1Ij9YjDmvVTz5NImFOCOe35i94DWSGC+fLqZ8T+AD+PU0pBDtyiAVB
izIiCjD2XZAeqAG13zoGlo9xravjiwY=
=0jis
-----END PGP SIGNATURE-----

--cBYCaHNShJUTrmWz--
