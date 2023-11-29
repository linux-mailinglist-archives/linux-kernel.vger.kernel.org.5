Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88CDC7FDA50
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 15:48:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234666AbjK2Osn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 09:48:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234644AbjK2Osl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 09:48:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31CF19A
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 06:48:47 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B196DC433C7;
        Wed, 29 Nov 2023 14:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701269327;
        bh=0+QaGA6PBlnGaUf5ZoWEYbce089KPfDbZK0tj/I7cFY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kT2G2Hm8rBBK2fdq61Bkc6ea8uM+C0n3FaCDZbnKVd4J80BT27l4NEw1EfMJLPU7D
         PD3im0d1vothsZI+2iCr5mMP2NMABsMnuQjqwlXdmQ0hndCVi+AkXn2H2aog3i5aNO
         qYZYxYf2xEWwzIX6z2zkunD47iP4iWw9RGjQ7L7Bpf7YBz+ssH/SKVyAFc/3C6jrDK
         Kz7/FtB2kiIAIbfLSKEGeB3pdk0Tm/QfrnoXPYz+kG++6nYvzncdiBxzpQ7n2BdYxd
         fNVwPcssWP2wiIK1qdaa0cyMOGpik1Pvj5U/2yu+HqIbMBvAEMknd1N0eOMnEXcgqL
         t/myAVP+nNXfQ==
Date:   Wed, 29 Nov 2023 14:48:41 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Sia Jee Heng <jeeheng.sia@starfivetech.com>
Cc:     kernel@esmil.dk, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, krzk@kernel.org,
        conor+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, daniel.lezcano@linaro.org,
        tglx@linutronix.de, anup@brainfault.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        michal.simek@amd.com, michael.zhu@starfivetech.com,
        drew@beagleboard.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        leyfoon.tan@starfivetech.com
Subject: Re: [PATCH v2 4/6] dt-bindings: interrupt-controller: Add StarFive
 JH8100 plic
Message-ID: <20231129-clatter-quarterly-4401934d2b50@spud>
References: <20231129060043.368874-1-jeeheng.sia@starfivetech.com>
 <20231129060043.368874-5-jeeheng.sia@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fypqDAEC7EAThQr9"
Content-Disposition: inline
In-Reply-To: <20231129060043.368874-5-jeeheng.sia@starfivetech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fypqDAEC7EAThQr9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 02:00:41PM +0800, Sia Jee Heng wrote:
> Add compatible string for StarFive JH8100 plic.
>=20
> Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
> Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>


--fypqDAEC7EAThQr9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZWdPSQAKCRB4tDGHoIJi
0hQDAP961Iv1cU5dwPISI0S3yN45u/dL+hNqlw3EW/MWezvgXwEA6cTCBtuJGKCH
ePXq3ljQb5QkwFLuMvT6evagEHPv4wM=
=e5L3
-----END PGP SIGNATURE-----

--fypqDAEC7EAThQr9--
