Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E00D7FDA5D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 15:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234391AbjK2OvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 09:51:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234737AbjK2Ouv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 09:50:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24AEBB0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 06:50:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7BF1C433C8;
        Wed, 29 Nov 2023 14:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701269457;
        bh=0VHSKBP1ReMABzZQC3fHKYxtIh+5pDAB20b4lDIyvBc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fsrd95RHo63I/KiYnCu1p22EqZ5zkOBJx61wvudfvnKHia6k5apCzxVgjiCBJPMu0
         kuFuH5a10xSmoBkHyjI6xkj+z1ayMfn/RWKD0WtZtf2ldM+K22jqDgB9ZcVRARkDiI
         MskWm0JkzUmiR3P/gYdlsJIdi5WOkrUAOB5EWOu/6j3mXPlemOnBIP881yNBJ1x8Mw
         IDGr4M0wjgi4DOOhpde2T9if5Jr9CP7hjjJXxB6PLuHL6SbIdeu0aJO4vlYUGnMPLW
         CzT0jp6FR/6zQP9zDjTqjOJQiyACSt+Af2oObc6GmRmnjam86soE4y5uAXZeKZkeG0
         MKnGO2f8ZZVbg==
Date:   Wed, 29 Nov 2023 14:50:51 +0000
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
Subject: Re: [PATCH v2 3/6] dt-bindings: timer: Add StarFive JH8100 clint
Message-ID: <20231129-junkyard-implosive-5b1d28976e63@spud>
References: <20231129060043.368874-1-jeeheng.sia@starfivetech.com>
 <20231129060043.368874-4-jeeheng.sia@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qKdfr+4VHS8JTnF5"
Content-Disposition: inline
In-Reply-To: <20231129060043.368874-4-jeeheng.sia@starfivetech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qKdfr+4VHS8JTnF5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 02:00:40PM +0800, Sia Jee Heng wrote:
> Add compatible string for the StarFive JH8100 clint.
>=20
> Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
> Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--qKdfr+4VHS8JTnF5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZWdPywAKCRB4tDGHoIJi
0hu3AQDko2ie3vpTPXfjxfnvgF6fp8Rl7pzo9cnDc63+d0kVjgD9FRImCWNbkv94
acKyBV66aqco9mGG9l/CojneYNWFswM=
=MwTW
-----END PGP SIGNATURE-----

--qKdfr+4VHS8JTnF5--
