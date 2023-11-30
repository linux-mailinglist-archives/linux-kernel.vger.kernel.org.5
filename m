Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6D657FF12A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 15:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345797AbjK3OFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 09:05:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345699AbjK3OFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 09:05:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E701A3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 06:05:49 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A523BC433C7;
        Thu, 30 Nov 2023 14:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701353148;
        bh=0bBErjRDq1tShxa+ZQUxMiiFY8Sr+lLm/nr9F9U95/k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IQmWMW3nBQO9dm1t/E18YFK0AnC/mglah74K64IGkrwM+j4yLwR6VQVurr1fw3ijq
         k4D9jrismUB8XR0M1yk1ExdoDewlZr3JnimtmuoqgdkxLAHJKb9kuVZ3PmQ6e3BXGr
         sNK9Xhhbt83YR8B+qjw3DEbwsJ6Ft4wodKo0abZ4K4CpJ4qz0d3PtuYB67jf0MY/ND
         ca1X5w4rtUvOmJ5QudqujjGyT6e2I/0rnqsqoaj94ylZWqPUFsfbr4wFmUeUoNjfcx
         N7QA8QdrliZQqaNsZD/m2Aya2rHJtwhYPDFFofPs9G0rQwPgMjFrB6+fK6LpfxIT5x
         8szHutp8RX+rA==
Date:   Thu, 30 Nov 2023 14:05:44 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Subject: Re: [PATCH v1 2/8] riscv: dts: starfive: Group tuples in interrupt
 properties
Message-ID: <20231130-droop-reggae-3f1ec3809a77@spud>
References: <20231126232746.264302-1-emil.renner.berthing@canonical.com>
 <20231126232746.264302-3-emil.renner.berthing@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="GDqc2Ost9zQQcBe6"
Content-Disposition: inline
In-Reply-To: <20231126232746.264302-3-emil.renner.berthing@canonical.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GDqc2Ost9zQQcBe6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 27, 2023 at 12:27:40AM +0100, Emil Renner Berthing wrote:
> From: Geert Uytterhoeven <geert@linux-m68k.org>
>=20
> To improve human readability and enable automatic validation, the tuples
> in the various properties containing interrupt specifiers should be
> grouped.
>=20
> Fix this by grouping the tuples of "interrupts-extended" properties
> using angle brackets.
>=20
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

This one is missing your signoff Emil.


--GDqc2Ost9zQQcBe6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZWiWuAAKCRB4tDGHoIJi
0kjFAP98CAuQRyqCQFxRXAWKKidu4wFen/Zt8TMkwHgIbaZloQEA5D/IV6QDjol+
X0TG+1sqJS12THdiw2HGwLlcbBYKngk=
=mWd2
-----END PGP SIGNATURE-----

--GDqc2Ost9zQQcBe6--
