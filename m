Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E11C280511D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 11:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346669AbjLEKrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 05:47:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235072AbjLEKrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 05:47:53 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A608CE;
        Tue,  5 Dec 2023 02:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1701773279; x=1733309279;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6EKUKmr83ChMD0Oh4BcIpqtIiujZ994PDO1wujmu8yA=;
  b=HQEm+H6V8wJqBIlv+CItzQjCzUUY7Zjd2BLCpBCZcJP2coT01+MfaBdZ
   2zyRL2UfifLbWUHOL69s1aKYQV3zN4mG8MHk/VFamCejeOcY/RUuKRh/p
   NHCX5/eHpOnv4Qv6nn93Z4d77kWwU7pLbDkK/TYDvUUKX4xie14ROscRb
   /QzDQafjlgvXdh0GLFjBi9avUv/b/B9vkKViQQNBl4SLXonNGjtt8cdKZ
   PVLpEEW4gR21uf6NYG4LYXXpMEXh+OnceFlt3qDj29e3N2i1r5CCQ70lc
   cGgwTSus4jbcLiOeD5rFThbbfzkzLvh4GTSUbcZ5LMZBmhAWj666QcbW/
   w==;
X-CSE-ConnectionGUID: hxs/bVEHRTK3IpCKYIjljQ==
X-CSE-MsgGUID: +OeQPf4aSmCL+lYaCxhuyQ==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="asc'?scan'208";a="12720840"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Dec 2023 03:47:58 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Dec 2023 03:47:58 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Tue, 5 Dec 2023 03:47:54 -0700
Date:   Tue, 5 Dec 2023 10:47:25 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <stable@vger.kernel.org>, <patches@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <torvalds@linux-foundation.org>,
        <akpm@linux-foundation.org>, <linux@roeck-us.net>,
        <shuah@kernel.org>, <patches@kernelci.org>,
        <lkft-triage@lists.linaro.org>, <pavel@denx.de>,
        <jonathanh@nvidia.com>, <f.fainelli@gmail.com>,
        <sudipm.mukherjee@gmail.com>, <srw@sladewatkins.net>,
        <rwarsow@gmx.de>, <conor@kernel.org>, <allen.lkml@gmail.com>
Subject: Re: [PATCH 6.1 000/107] 6.1.66-rc1 review
Message-ID: <20231205-parting-molecule-8ea45639321d@wendy>
References: <20231205031531.426872356@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SZCJSgyL//So0XBB"
Content-Disposition: inline
In-Reply-To: <20231205031531.426872356@linuxfoundation.org>
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

--SZCJSgyL//So0XBB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 05, 2023 at 12:15:35PM +0900, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.66 release.
> There are 107 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

The perf patch I pointed out breaks the build in all my configs on
riscv.

--SZCJSgyL//So0XBB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZW7/vQAKCRB4tDGHoIJi
0jafAQDzGHXfjwwZGGKQcFr6zIaPDvQPF4IfDQarNJSh35vqUQEA1v7jKDvrH5Jf
tntF7B9KKvwSKxSKjZWKQMi7p++fIw0=
=X0MD
-----END PGP SIGNATURE-----

--SZCJSgyL//So0XBB--
