Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A58D37FDA46
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 15:48:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234609AbjK2Or6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 09:47:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234061AbjK2Or4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 09:47:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E679C19A
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 06:48:02 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88F44C433C8;
        Wed, 29 Nov 2023 14:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701269282;
        bh=PI1weq/pnE/jDDTHXdI0Ix4uqb+JeIDqc0bU61UT7wY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ca6EXan6a9dO9rm3hsPemNIdm96eOx2BlqY79kMTc+6YsKK55tn40Opi7Ogmbysa3
         8Lt5ztvKuynShJKZ6xi2yiDJ6bdF70RdNPV0cnXOhqhRgUYOI3yayy5ar7PrcJnTfR
         v6Fd58NES9svvhbylPRDfiNIhPsCUWp4FuLZQpQOW3uSJ6AbEknkKW2MXGj9tPBwM9
         3u5t2bN9IKHJo5X+C/qUBY2QcyO42ke2I3SyXwYDmKNFT1BNTOsjO2qPsr/WHfCdQl
         FXQkEjn8a6uZlRIfTD9VPY53ouEwYaL9sy5kRbppjNy+/mVhGsn30CvMvVOm7G8UtO
         Uo1S1JTLLT/EQ==
Date:   Wed, 29 Nov 2023 14:47:56 +0000
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
Message-ID: <20231129-staple-filter-4a1e9494c00c@spud>
References: <20231129060043.368874-1-jeeheng.sia@starfivetech.com>
 <20231129060043.368874-3-jeeheng.sia@starfivetech.com>
 <20231129-thrower-umbilical-f11ee0749800@spud>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mHpRZgRE9TQM1U6p"
Content-Disposition: inline
In-Reply-To: <20231129-thrower-umbilical-f11ee0749800@spud>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mHpRZgRE9TQM1U6p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 02:46:26PM +0000, Conor Dooley wrote:
> On Wed, Nov 29, 2023 at 02:00:39PM +0800, Sia Jee Heng wrote:
> > Add device tree bindings for the StarFive JH8100 RISC-V SoC.
> >=20
> > Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
> > Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
>=20
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

(with the whitespace thing that Krzk pointed out fixed, just noticed
that)

--mHpRZgRE9TQM1U6p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZWdPHAAKCRB4tDGHoIJi
0tOJAP9enRl8M+ZWxXhgOFJE/TEI8bZPpSIv5hOkVolw8Y/X3AEA2OShFNPWpbKo
LpDiLZXdIPt9gnT2lHE3G6wCHR//awU=
=xkmZ
-----END PGP SIGNATURE-----

--mHpRZgRE9TQM1U6p--
