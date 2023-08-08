Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 728D87747B0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235888AbjHHTRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236004AbjHHTRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:17:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D5AFAEF0;
        Tue,  8 Aug 2023 09:40:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D8C92623E8;
        Tue,  8 Aug 2023 07:14:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C036C433C7;
        Tue,  8 Aug 2023 07:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691478844;
        bh=JbqXnIWrhvRK/1VedLU0rkf4ac3M8lve+ZdK83upX3s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=moDdluEutiSAWzxfn3EQ4PLVJ3yFae5/MaJPjCRjcvChu+Zzgi6gLb3emqsDZtt5+
         3rh4iFtv9GwYcBjym5ZiRUF7Kpc0/xEyy7AsdXWKxBhwW36mTXsvZ5RRNCrvl+0Agv
         t6ZDVlYY8vBpkRq4BqulZ5aoiqUvvCZ4wQhM12XlGyXgs5hFanhwUI5ZJRpNiF5zBB
         XBzrsOX437OFtMaukrBO98qPcjeA/Oxm9sz1WC/z0bVDgNjGD8nQpQUpOQOGH7C/Nw
         BMvszDYySSkk2CZJnCuTA75QZMsX7YK2a6RtGIA47/3OhHjirYGw5YWTfS0cLwNqIq
         jAaweAciLz4IQ==
Date:   Tue, 8 Aug 2023 08:13:59 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Jia Jie Ho <jiajie.ho@starfivetech.com>
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] riscv: dts: starfive - Add crypto and trng node
Message-ID: <20230808-despair-calm-40ca60de2afb@spud>
References: <20230808061150.81491-1-jiajie.ho@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PomhQBfiuNGfjeLQ"
Content-Disposition: inline
In-Reply-To: <20230808061150.81491-1-jiajie.ho@starfivetech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PomhQBfiuNGfjeLQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 08, 2023 at 02:11:48PM +0800, Jia Jie Ho wrote:
> The following patches add hardware cryptographic and trng module nodes
> to JH7110 dts. Patches have been tested on VisionFive2 board.
>=20
> Best regards,
> Jia Jie
>=20
> Jia Jie Ho (2):
>   riscv: dts: starfive - Add crypto and DMA node for JH7110

>   riscv: dts: starfive - Add hwrng node for JH7110 SoC

I only got one patch, where is the other?

--PomhQBfiuNGfjeLQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZNHrNAAKCRB4tDGHoIJi
0nfxAQDxMCy1nMLMOOxrNbqguwHV91F4BpZ9+JdAKtsnKC9RlgEAitOeXozvIkSa
3fvAp6UpdtjkfDJJdq5/41c70FXLmQ8=
=YX3x
-----END PGP SIGNATURE-----

--PomhQBfiuNGfjeLQ--
