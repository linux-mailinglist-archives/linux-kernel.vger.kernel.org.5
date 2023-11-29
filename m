Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B65EF7FDA3B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 15:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234661AbjK2Oq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 09:46:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234810AbjK2Oqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 09:46:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 295CAD65
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 06:46:33 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3C45C433C8;
        Wed, 29 Nov 2023 14:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701269192;
        bh=9GQN7/hdcUEnNmQ493lxzKNysjRFZYQgbQLVbB0NNY4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AxJ4H6GH8+xeJG2+XoamWN0mDamr/sM05A315NvSSf1ymw1jRa8ZCdNR9pqMwNgkq
         qIM4tFsZF9JRaPEM+i4HCzRjYICUDhNtU2/13si1TwKGqwIM0pG0OIWcMoMSxMulJe
         cpnCo5WCPx0+4gq4/akUPV9jjcBGsN1UC+MQqA9n1btENC2kuGPdbA/9uGLBlnmeKc
         PpoE0AknaGzWPdQePVe3GRsvGYvODK+QuY/AEN1JSPaw4+9/Lq/Iibjtz54xgaPvXa
         ZCXionHWL5eofhyBe2zRsnCkLj6mR3YKbYYu2fEBf+Kfre56CbwO4FvsGyp7Apb3Kr
         6gONbu+1c5xRw==
Date:   Wed, 29 Nov 2023 14:46:26 +0000
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
Subject: Re: [PATCH v2 2/6] dt-bindings: riscv: Add StarFive JH8100 SoC
Message-ID: <20231129-thrower-umbilical-f11ee0749800@spud>
References: <20231129060043.368874-1-jeeheng.sia@starfivetech.com>
 <20231129060043.368874-3-jeeheng.sia@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="iOelv6T+mj3cWbE0"
Content-Disposition: inline
In-Reply-To: <20231129060043.368874-3-jeeheng.sia@starfivetech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--iOelv6T+mj3cWbE0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 02:00:39PM +0800, Sia Jee Heng wrote:
> Add device tree bindings for the StarFive JH8100 RISC-V SoC.
>=20
> Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
> Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--iOelv6T+mj3cWbE0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZWdOwgAKCRB4tDGHoIJi
0kUIAPwM427aA3mlP+6PzIu9owQq54/yLBLKInM1yuRBzap2PwEA5w++iYrLinPx
NltepIkT2aOJNelqv2QZ9nPf/t8MpAw=
=jdE6
-----END PGP SIGNATURE-----

--iOelv6T+mj3cWbE0--
