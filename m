Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC7F7B8379
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 17:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243150AbjJDPYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 11:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233478AbjJDPYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 11:24:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC14093
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 08:24:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58834C433C8;
        Wed,  4 Oct 2023 15:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696433048;
        bh=XYBsuHW907+37LNlNvc8QulBglPUKmO3oxD+nsjr5xo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MVyNmValrtZe2Vc5YkvlCJf3e/WsBXJIjJNaiq3p39iwrpyDc8rnK/wZeQrYaH+4E
         cA7S/cWXbCwZxg1kjoTZabtM9V4Ul+VBXwhRj6WiMwi1DZCuHbxxdWTyWIvKQe/pQC
         toV/Dc1KJ9OEHrgKUO0wzXynQVH2NPW3qGasA7Qrz2cuhvN67+6U6rYoxzSXxq7OWX
         Qk0IA4yxY/n3Xj3+8R4KdjcQ/5Ra21OnrUINtnjmkn0wRqjlAfff1NS4303z6U87F3
         m2my0HxK3jO4n44l5pMcPJ/5SFaIdyUQ2BiPUBG8HOOraf8K0BH4dNCazNNeQmkAVM
         BoNla2fpPufDA==
Date:   Wed, 4 Oct 2023 16:24:03 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Chen Wang <unicornxw@gmail.com>
Cc:     aou@eecs.berkeley.edu, chao.wei@sophgo.com,
        devicetree@vger.kernel.org, guoren@kernel.org, jszhang@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robh+dt@kernel.org,
        xiaoguang.xing@sophgo.com, apatel@ventanamicro.com,
        Chen Wang <unicorn_wang@outlook.com>
Subject: Re: [PATCH v4 00/10] Add Milk-V Pioneer RISC-V board support
Message-ID: <20231004-rival-wow-1412dca8c490@spud>
References: <cover.1696426805.git.unicorn_wang@outlook.com>
 <CAHAQgRChywKWKX2=Cyn4VBrZKfy6pY2meHtVqRyBcfRUm7mHYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="TloKwboP8KmYAarL"
Content-Disposition: inline
In-Reply-To: <CAHAQgRChywKWKX2=Cyn4VBrZKfy6pY2meHtVqRyBcfRUm7mHYQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TloKwboP8KmYAarL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 04, 2023 at 11:14:54PM +0800, Chen Wang wrote:
> Sorry, please ignore this email, it was sent out by mistake.

What are you doing that this has happened twice today?
Don't you just do `git send-email /path/to/directory/containing/patches`?

--TloKwboP8KmYAarL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZR2DjwAKCRB4tDGHoIJi
0id8AP9VBtdP8SAWk9a9uS9dCCZf5WNu7DZEO6o2UQpneBc0kgEAyElB94W41QsD
/UAb3Z04CCd3me0nZbIjiWhgnLjDEgM=
=nahl
-----END PGP SIGNATURE-----

--TloKwboP8KmYAarL--
