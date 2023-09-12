Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8C179D12E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 14:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235189AbjILMhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 08:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235141AbjILMhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 08:37:06 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6CE7C4;
        Tue, 12 Sep 2023 05:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1694522222; x=1726058222;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=P01cDTSVf7ckurQxFxyjwgb5uJRiP/96u6vP0AxPKWE=;
  b=Kj2bW/PqFmxRkfe2OWLJvr8dJcThJsOCgAx5/nHIvVmag5WCKs08C7aB
   gIdzpwzWGZPvQyMeWPAPuUYnRvRvA8s/WaDxztyZXKmtc8Kqyuppv/DtX
   8FhlhuET7Ymh33LYuNJl/0W/NzPDi+iXeMujOuOV8qAKQqh4dotJdliZ8
   yqsiBbAo06TwHefJ7EpMtdK6Jt/xQ6ZBJjldwxMYJbZ+Ac0B12WZ8IQ9Z
   LrzJsVaQg2IOH+WsYVNAsFy31NDEcqh+y7fO73uROYNLmyUyLFE44+BnS
   E9NV6k31R4XSqDgRLoEzzrgToryIMkhp67rHLs1+sxtjBxhmKVCiNZ1Ty
   Q==;
X-CSE-ConnectionGUID: 0sNE4ZAsR22nJG2L44lBOA==
X-CSE-MsgGUID: 5nIlT3dOTH2q3yTVJBRicw==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="asc'?scan'208";a="171179025"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Sep 2023 05:36:49 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 12 Sep 2023 05:36:41 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 12 Sep 2023 05:36:38 -0700
Date:   Tue, 12 Sep 2023 13:36:22 +0100
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
Subject: Re: [PATCH 6.4 000/737] 6.4.16-rc1 review
Message-ID: <20230912-patchy-banknote-0982b6f505c2@wendy>
References: <20230911134650.286315610@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lqmFod006FlLWkrC"
Content-Disposition: inline
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--lqmFod006FlLWkrC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 11, 2023 at 03:37:39PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.4.16 release.
> There are 737 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Conor Dooley <conor.dooley@microchip.com>

Thanks.,
Conor.

--lqmFod006FlLWkrC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQBbRgAKCRB4tDGHoIJi
0k7qAP9LyrhUha+vdg2Rj87nVD/4UPAd7+dYX8wHBH+qPyhUNwEAtkFzqq3VQr8y
2pdlezoiRm3eVNsCXG/ViFe78qr92QU=
=altQ
-----END PGP SIGNATURE-----

--lqmFod006FlLWkrC--
