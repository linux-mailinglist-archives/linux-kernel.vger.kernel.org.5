Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 915FD7BC6B1
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 12:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343791AbjJGKR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 06:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234148AbjJGKRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 06:17:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ACCCB6
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 03:17:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FEFCC433C7;
        Sat,  7 Oct 2023 10:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696673870;
        bh=5SvARg1tVUAbuCBSDivmH2UxOz0qfHxw6Fo68f/xKHw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FUzeeSgAsBBQiI9I8zffvJjRySGtVNaYobZANkHpk2IN+DoPtz4Rx9/kyo3hLvp2O
         yQgQ68Iuts5KhkezXy0NZKOPB5bpnkzIh3OdVg9VLqRkAW+dFsuv8tNp0p4YPnmJPy
         9TzIERm9vTWsuQUxtW61Zc+Fpu5wDJ1oDfU7PqJbvotPtUjODTovCapXF9lHffwJ+A
         9VZCWndAlxmS+PLOVa9DzZcPp5FMEdbG2j9V61GFd9DmINOXTojKpxceRCD4qtjpTl
         7PLwRElTlzyXeIfZLqe7A1W0xH41h5+mcL5XHGPG4wE/eppZpRwQFwVs/XBgFuiiAq
         bPGclCyXEye3w==
Date:   Sat, 7 Oct 2023 11:17:44 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Chen Wang <unicornxw@gmail.com>
Cc:     aou@eecs.berkeley.edu, chao.wei@sophgo.com,
        devicetree@vger.kernel.org, guoren@kernel.org, jszhang@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robh+dt@kernel.org,
        xiaoguang.xing@sophgo.com, apatel@ventanamicro.com,
        Chen Wang <unicorn_wang@outlook.com>
Subject: Re: [PATCH v5 00/10] Add Milk-V Pioneer RISC-V board support
Message-ID: <20231007-grasp-retake-0463858c13df@spud>
References: <cover.1696663037.git.unicorn_wang@outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="iKyvg3rJU1jsPJ54"
Content-Disposition: inline
In-Reply-To: <cover.1696663037.git.unicorn_wang@outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--iKyvg3rJU1jsPJ54
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 07, 2023 at 03:52:04PM +0800, Chen Wang wrote:
> From: Chen Wang <unicorn_wang@outlook.com>
>=20
> Milk-V Pioneer [1] is a developer motherboard based on SOPHON SG2042 [2]
> in a standard mATX form factor. Add minimal device
> tree files for the SG2042 SOC and the Milk-V Pioneer board.
>=20
> Now only support basic uart drivers to boot up into a basic console.
>=20
> Thanks,
> Chen
>=20
> ---
>=20
> Changes in v5:
>   The patch series is based on v6.6-rc1. You can simply review or test
>   the patches at the link [7].
>   - dts: changed plic to support external interrupt
>   - pickup improvements from Conor, details refer to [8].

Did you? I only see them partially picked up. I'll just replace patch 8
with the patch 8 from this series I think.

--iKyvg3rJU1jsPJ54
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZSEwSAAKCRB4tDGHoIJi
0l2tAQDJTgaBOCPvFiUINFvZMw8wD2MOLJqkt3HmEO9xOGScTAD+ORVuErM4SNOR
n3mMxcJKA/v1jqqvOzsexEgno/chAgc=
=b+S6
-----END PGP SIGNATURE-----

--iKyvg3rJU1jsPJ54--
