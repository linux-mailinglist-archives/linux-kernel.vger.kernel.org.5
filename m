Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5C81785472
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 11:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233743AbjHWJm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 05:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236077AbjHWJlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 05:41:22 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE875172B;
        Wed, 23 Aug 2023 02:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1692783399; x=1724319399;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gFxUMckI2v7jFgYeql0OzzXtc/2Ei26vmidT8NcZ22o=;
  b=v2lCL9l3ddWiaib5NE10FVOGbJ+dJAcCIPnDKb7LoO9uYYjLeJ3KMrte
   A74Cdp/NEqqRPwrg1E9BOOQf9YzLb20Vbufm3iTwDNJvYVjozwZLzJhRh
   8wRgOuxuoGE+iQUl11CtyOV4cRj+oxMVGL64Wz2n0s/fknQPm7/BjiSEd
   ptS9t1oZRVzpH6zICuyqO2ziYbT50kN/u/4+Beto7kKpW9dTiQUeW0o5c
   vkeXrnBI9CBwhZUCalbzMk6SZvI3yvtd+WtX5hhSPKTdHUxw6tGrppw5Z
   576W/tP0ywuONGo3mcl0VI97Bj1rLIh2+UFBl0eJjR1XSwIoCYZGzzo4Z
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="asc'?scan'208";a="861930"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Aug 2023 02:36:38 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 23 Aug 2023 02:36:38 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 23 Aug 2023 02:36:35 -0700
Date:   Wed, 23 Aug 2023 10:35:54 +0100
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
Subject: Re: [PATCH 6.1 000/194] 6.1.47-rc1 review
Message-ID: <20230823-washer-reemerge-a412d55f8214@wendy>
References: <20230821194122.695845670@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pXya09AKMWXNOkqn"
Content-Disposition: inline
In-Reply-To: <20230821194122.695845670@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--pXya09AKMWXNOkqn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 21, 2023 at 09:39:39PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.47 release.
> There are 194 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Fails to build for me with gcc-11/binutils 2.37 on RISC-V. The problematic
patch is "riscv: Handle zicsr/zifencei issue between gcc and binutils".
Can you drop that please, probably from all of your branches. It
certainly affects 6.4 too & I don't personally test anything older than
6.1.

Thanks,
Conor.

--pXya09AKMWXNOkqn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZOXS+gAKCRB4tDGHoIJi
0lIjAQCAXxzyZlxsLvJ/co5B/fwvnQ2+nvGmfR5rAt25sZZm6AEA0NwOCebLuEm6
vpa/zZTlngSh1n+gKsdvZT5CZzgkNQ8=
=j3oV
-----END PGP SIGNATURE-----

--pXya09AKMWXNOkqn--
