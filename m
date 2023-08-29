Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB5B78BE5B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 08:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbjH2GYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 02:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231790AbjH2GXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 02:23:52 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF4018F;
        Mon, 28 Aug 2023 23:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1693290231; x=1724826231;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NFR7BS/t+ayxaaaySg2zfmb0fya/Bj6mhurY0m/cULo=;
  b=UmquMHcHlEsPHChb2/Z6E1khnPXBsoHvE3EhkB3QgS0D5zqm4MA04uzE
   ijbq703shshBmMo5tuKBN3Z7Gwz/adTfWlSDKtP25TNR3gTW2hAbiiOuY
   kKdyr1dstL/+D6ldDWAyeOypuglz1LaZ8Yt1NT+CYJu3qelf2i3ZvYW8W
   3xfeBxu671p4iiytV6RWog/09IQ7CRE9tPimNpBVvAgT4iJu4s3X64Wz0
   n3oLs995dR/RaLq4F6X69wx6woXur4VV+1gzfdDRsfp31UBXvQ7ket9E5
   zXBDNAEvMeWUgNIiOjD7ymjCN0VNa6oW9pqnE54LTEZHb0FxbaeLSaU1V
   w==;
X-IronPort-AV: E=Sophos;i="6.02,208,1688454000"; 
   d="asc'?scan'208";a="232226652"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Aug 2023 23:23:50 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 28 Aug 2023 23:23:38 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 28 Aug 2023 23:23:35 -0700
Date:   Tue, 29 Aug 2023 07:22:53 +0100
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
Subject: Re: [PATCH 6.4 000/129] 6.4.13-rc1 review
Message-ID: <20230829-emu-talcum-cc87dd4e8fec@wendy>
References: <20230828101157.383363777@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="R+UaXppGDc0HEZYu"
Content-Disposition: inline
In-Reply-To: <20230828101157.383363777@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--R+UaXppGDc0HEZYu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 28, 2023 at 12:11:19PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.4.13 release.
> There are 129 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--R+UaXppGDc0HEZYu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZO2OuAAKCRB4tDGHoIJi
0sEfAQDhCOaZZUSbJYZaLYXqsSU8F0c738rgLZWZajhvvmuq/QEAzssQnudUBdzK
epBT+r4lGnCNXBvZbrL/nmqXMaiPmwI=
=ZOxv
-----END PGP SIGNATURE-----

--R+UaXppGDc0HEZYu--
