Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B69675615C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 13:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjGQLS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 07:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjGQLSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 07:18:50 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8910A1B9;
        Mon, 17 Jul 2023 04:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1689592729; x=1721128729;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Agv739FsKb/t4lRY/iTsFiStP+D83yl/GQ08JzH9gl8=;
  b=a7UfQPGnpO9LtDQUg/6v38MfISTZb4+JxI3pBVKNhqtXs3JcjEi/ZYw1
   wBYTD7XLrlIWIDzSaoO2/A1pVBtF3L9e4BfSzOQRNYjTKRSXnePapNqoT
   xcQs8lF+58uNaHsdtC7Lwp/VFukAoosQoL0jEcTOayhHmbMFmJA8iqRuX
   XgDPkJXEG7TCecjP86byPhdqSxK/EclPfgIxl4HQFNTWyxW//mx+z/Cdl
   T9IpkD97lgpOnm65IxJrKYDi0DGxN2rY+aZPJnYmhnh5wjnds3JDPd+kR
   WTzqkPtfyuhq+0nzPwmbcp8d1AU+NF800LBHGohMchHtk6LWMKoI5ihRy
   w==;
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="asc'?scan'208";a="235937339"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Jul 2023 04:18:47 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 17 Jul 2023 04:18:47 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 17 Jul 2023 04:18:44 -0700
Date:   Mon, 17 Jul 2023 12:18:11 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <stable@vger.kernel.org>, <patches@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <torvalds@linux-foundation.org>,
        <akpm@linux-foundation.org>, <linux@roeck-us.net>,
        <shuah@kernel.org>, <patches@kernelci.org>,
        <lkft-triage@lists.linaro.org>, <pavel@denx.de>,
        <jonathanh@nvidia.com>, <f.fainelli@gmail.com>,
        <sudipm.mukherjee@gmail.com>, <srw@sladewatkins.net>,
        <rwarsow@gmx.de>, <conor@kernel.org>
Subject: Re: [PATCH 6.1 000/591] 6.1.39-rc1 review
Message-ID: <20230717-irritant-daily-7eb1e398ae8b@wendy>
References: <20230716194923.861634455@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="GmTatSP0oHOhqa/V"
Content-Disposition: inline
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--GmTatSP0oHOhqa/V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hey,

On Sun, Jul 16, 2023 at 09:42:19PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.39 release.
> There are 591 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Fails to build w/ clang on RISC-V:
block/blk-cgroup.c:1238:6: error: variable 'ret' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]

Guenter already pointed out the culprit.

Other than that,
Tested-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--GmTatSP0oHOhqa/V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZLUjcwAKCRB4tDGHoIJi
0joBAP4mOChOU9drzaBU3WQ6oLYYDe/AZHnrBdiPXkn403OAawEAhURGaXFiU+6M
MYJzOb6fedutcQ7upIa8+Gv7KCOg2gY=
=C8TV
-----END PGP SIGNATURE-----

--GmTatSP0oHOhqa/V--
