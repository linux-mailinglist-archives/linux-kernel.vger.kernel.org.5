Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD6080A8D3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 17:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573812AbjLHQ0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 11:26:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233485AbjLHQ0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 11:26:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D93CC123
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 08:26:39 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8482FC433C7;
        Fri,  8 Dec 2023 16:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702052799;
        bh=G8h5liRHQQqCxuXBWadFReEljM9UB62vGfdTtJ5lYjk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B0oVgX50j5K/ss45F9MCZpW/LcE/NZOB8Gpm0AkD4aHeUyTM2QFO4NfFjx1tDxb08
         Xg0En8GH0at2otoby9PBikB1ZsV0jvZ/taKOOVT8Y5Mj1JNInVF0aJFkb/qFz92izx
         LpmmnYBdHMmljM0rj5AO1DXoTmQfWkE00vE04jmNLbghq+IkI5Z2saFONcBkRUqnBm
         vWU5FeWzFmAicaNFi5UCMy/pmh4U0Zhmrre6uTixHhM9ZnIhakUeEfZgYQ+UQQMOup
         RQtURAwjVodTF0h6QHkDP4YHGAVWR41314ff/HkVPmjkyBhk8YZBbJxHhDMyGsd4z4
         WBXbyShprkK5g==
Date:   Fri, 8 Dec 2023 16:26:33 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Chen Wang <unicornxw@gmail.com>
Cc:     aou@eecs.berkeley.edu, chao.wei@sophgo.com,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        richardcochran@gmail.com, robh+dt@kernel.org, sboyd@kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com,
        guoren@kernel.org, jszhang@kernel.org, inochiama@outlook.com,
        samuel.holland@sifive.com, Chen Wang <unicorn_wang@outlook.com>
Subject: Re: [PATCH v6 2/4] dt-bindings: clock: sophgo: support SG2042
Message-ID: <20231208-italics-deceiver-e3673e693ae1@spud>
References: <cover.1701997033.git.unicorn_wang@outlook.com>
 <6f456da5355f451309de0b1b420433ed65dab3c3.1701997033.git.unicorn_wang@outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Jlu8l0PhkNXRV65X"
Content-Disposition: inline
In-Reply-To: <6f456da5355f451309de0b1b420433ed65dab3c3.1701997033.git.unicorn_wang@outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Jlu8l0PhkNXRV65X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 08, 2023 at 09:14:02AM +0800, Chen Wang wrote:
> From: Chen Wang <unicorn_wang@outlook.com>
>=20
> Add bindings for the clock generator on the SG2042 RISC-V SoC.
>=20
> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--Jlu8l0PhkNXRV65X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXNDuQAKCRB4tDGHoIJi
0prvAP0S9gqVqTbYieWB4Kd4oyhZ0s0ohe8f5cP9iuF4DZcpkgD6AgNQjxtNAZhO
P111VONeHPdlK/o+LaSyQO/Ymf3ZaQU=
=5XXN
-----END PGP SIGNATURE-----

--Jlu8l0PhkNXRV65X--
