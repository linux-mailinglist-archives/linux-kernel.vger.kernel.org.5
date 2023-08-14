Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A614777BAFC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 16:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231683AbjHNOHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 10:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbjHNOHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 10:07:16 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29E3E3;
        Mon, 14 Aug 2023 07:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1692022035; x=1723558035;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/MFNWkqsq1K7XfpryTJ0ac/m6VwICjGCbIya+sayRsE=;
  b=ooFbrjEgj05JlMdRlY97NXIC3T7BrfLxhZDT9wPU3LcYR3grGjTDvS3s
   Rwuz7c+HPYRH5DEK7eMjfm79KYCe3MdxktPFDJ7yHiWk1qDMvRNi9PSd1
   hxMVrogBXWw28HYaowgwn7/As0+OmClFEpRPM9/UsuRsjZYjKBw+t/TUQ
   viYtSlhxZTGXEjuVFdyWTGTdgVT7WSBDNvfAs0+4bAbPvnF+amGEccQxM
   fUSb6zu8yHbbz6oJ8urlFAq7rRPqrWzrBntoJID9n1cqH+heParKs/dox
   VhuUoetRypKJ0V3rzx/YCeDC/NaG+/KT2K/61/h5w6dN85GX6S1tqdC+L
   w==;
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="asc'?scan'208";a="166343655"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Aug 2023 07:07:15 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 14 Aug 2023 07:07:14 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 14 Aug 2023 07:07:11 -0700
Date:   Mon, 14 Aug 2023 15:06:33 +0100
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
Subject: Re: [PATCH 6.1 000/149] 6.1.46-rc1 review
Message-ID: <20230814-immature-roamer-398c43abc0a0@wendy>
References: <20230813211718.757428827@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="BKYbhG+6ARxAenx9"
Content-Disposition: inline
In-Reply-To: <20230813211718.757428827@linuxfoundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--BKYbhG+6ARxAenx9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Aug 13, 2023 at 11:17:25PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.46 release.
> There are 149 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

I think I replied to the wrong thing earlier for 6.1 testing..
Tested-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--BKYbhG+6ARxAenx9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZNo06QAKCRB4tDGHoIJi
0hgKAQDMLP2kATJw24PtA4Bi5XuVhgh7wUADE15xJQMAW8bDEwD/QD+7tMnE+gm4
Rax2OYQ0kcjL2JfyT0taCMKtm/XJpgs=
=zblf
-----END PGP SIGNATURE-----

--BKYbhG+6ARxAenx9--
