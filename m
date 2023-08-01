Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9006A76B931
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 17:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbjHAP4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 11:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbjHAP4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 11:56:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B77DC;
        Tue,  1 Aug 2023 08:56:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 75F3D6160D;
        Tue,  1 Aug 2023 15:56:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1403C433C8;
        Tue,  1 Aug 2023 15:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690905406;
        bh=iGV+6Aj7YdAAbxDxMz9XXvaxnnB4NKb9aoSMOJfeyy8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HkPEuJiP5IlZdyMlP/tOap6keT7iD2mj63Q6cUfrjmwbHGNc+2S8LXSIJ676j+/fS
         cipsVmvY2ThVEP+KHhNbL1JMuagiz7w/y9cciX0gewqPDnq1D4Y/CvyjLdqYbzRRKr
         NoC1Ch6skSHEpy7oWck+17qTSj4+bTslWdDtBEj2P+0v1+aggWrVmY6ufRnUXOi6L5
         ZBvASCGlcFP0TXqJDxZbtVqBXGVvH0RCXCFMSGq+byioLdMMvF+5lrTLhq0/pDdext
         ko7txeGI928zRnBn/FTz8yVUJO+rtX9q6NNfR/Jj/9dx5PLiY9oqdiXjezW9FRGjkJ
         2OLnmfHQ64d4Q==
Date:   Tue, 1 Aug 2023 16:56:41 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 6.4 000/239] 6.4.8-rc1 review
Message-ID: <20230801-hardened-paralyze-da39ecdd12b3@spud>
References: <20230801091925.659598007@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xnYYIjW9LqcL8ceM"
Content-Disposition: inline
In-Reply-To: <20230801091925.659598007@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xnYYIjW9LqcL8ceM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 01, 2023 at 11:17:44AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.4.8 release.
> There are 239 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--xnYYIjW9LqcL8ceM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMkrOQAKCRB4tDGHoIJi
0s+9AQDNHZ7ZWADkUfXIy2NHz1RmNvbqcKVeyuTVsVk/0SYNgwD+IaYZ7PpgnyP6
wPF16i8dSMyhx03vgcxaUqcWNB1JTQ4=
=oevv
-----END PGP SIGNATURE-----

--xnYYIjW9LqcL8ceM--
