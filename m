Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBE17E4592
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 17:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235406AbjKGQNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 11:13:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbjKGQMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 11:12:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45AE13C39;
        Tue,  7 Nov 2023 08:04:09 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE6B1C433C7;
        Tue,  7 Nov 2023 16:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699373048;
        bh=6Ltdah9mCFeI/88AKF+yviX8tIaHDZ2JZ6F9zZ8Bxjo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a9GcOPDjMz0EuSc/0ZcGwE7OO/7w0n0eRCh7F0WIRVZYgzqqpd1g7flxtct1Lk1s6
         LTIR+X0v1Oac1gGmIKz14dYmVoxnA9lKa8cKCvGYyhcVqZdqorx4SP8g7z23m9n6rz
         NM2kXkLSVgT9JD3VBo9mYCKUKHfrR9tgPNtbNOBRZnL/HNjkNwsMLymAjre6mXVLU0
         jjHpBFfU1NaIO1U8z/qR5KZMmH4XFA+cHr/uuuIz7zZi95YriSS4maDcRg5HN0Uq84
         NLaa/HWFHcef99UNQmL3diJaQ9FB7B/zfvGFSlmvHVTckaUOem7CH3ybVhxu3qevgm
         xMACCnZyBy5Mg==
Date:   Tue, 7 Nov 2023 16:04:03 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 6.5 00/88] 6.5.11-rc1 review
Message-ID: <20231107-figurine-deserve-b5677ca6017f@spud>
References: <20231106130305.772449722@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="JUBJBIyF0IcL+fyw"
Content-Disposition: inline
In-Reply-To: <20231106130305.772449722@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JUBJBIyF0IcL+fyw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 06, 2023 at 02:02:54PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.5.11 release.
> There are 88 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Tested-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--JUBJBIyF0IcL+fyw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZUpf8wAKCRB4tDGHoIJi
0pSGAP0QOqLRCXKDCzBHTJnfJFZa9Xb20pXhlYdnuds4NhYWhwEArCcXeM+WBatD
/fdMHf/oQVVPUsHClbF19kBDeWwUEAY=
=H2dY
-----END PGP SIGNATURE-----

--JUBJBIyF0IcL+fyw--
