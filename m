Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE4EF756AAA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 19:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjGQRdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 13:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231603AbjGQRc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 13:32:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3FE171E;
        Mon, 17 Jul 2023 10:32:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5A2761156;
        Mon, 17 Jul 2023 17:32:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B0FBC433C8;
        Mon, 17 Jul 2023 17:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689615147;
        bh=AbtYHtS2JtNYwEO8ZoUf0G+9zyh2/yosgJT+eNjvDoo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=miHOkMGwmKSDTQgagUIwAtEb0IDWiK2rraaSxWZZBpTstxg7/BodAHcctUcJJR7sR
         Kfazakw0S/onzX3sVnykx7I4OoWsagmmdL+OR961UpwhpR6uGT59hI4M5pEjSS2HVy
         ceMXA4eXRpz1hqb0JN20GPCPTufEqGktRUJMPbPpF9nJ3JW0yIsnvGhcNyDOBgfQsX
         vqN5635Fdh31rnFH4LELyjJtzOm+KV1HqLtbwpmYgCcnCCpEPqLZg+WIe7FPrVJD+0
         xnSFECStcq2zfG2WUIc65g6PJJbjHhwZD4z7CPlRfcKk0G9pQADuScqao6fqxUDW/F
         +B0TTU6Hi5L/g==
Date:   Mon, 17 Jul 2023 18:32:21 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 6.4 000/800] 6.4.4-rc1 review
Message-ID: <20230717-sweat-posture-c8b425f71df3@spud>
References: <20230716194949.099592437@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="owMIyiso7i8Ijzkb"
Content-Disposition: inline
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--owMIyiso7i8Ijzkb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jul 16, 2023 at 09:37:33PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.4.4 release.
> There are 800 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

My CI has no complaints about 6.4,
Tested-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--owMIyiso7i8Ijzkb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZLV7JQAKCRB4tDGHoIJi
0jToAQDwT3iu9zV8h7hv7pNC+x1IsYeBjXovzwWxZOvDAJWs1AEA/2Bo96A/C7aD
rq4TkiM2t7GFEU3tmwzrY6HolaV2lAI=
=su4r
-----END PGP SIGNATURE-----

--owMIyiso7i8Ijzkb--
