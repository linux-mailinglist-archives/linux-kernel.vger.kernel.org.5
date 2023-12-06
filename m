Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F15B2807591
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 17:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378450AbjLFQpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 11:45:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbjLFQpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 11:45:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C10FA
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 08:45:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6345FC433C7;
        Wed,  6 Dec 2023 16:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701881124;
        bh=P064BleAcaaGYhhLYVjCCsTlgPSnJdkpYELnbMw15OQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HuR24vb/Pb1Pbt9Itc3plkdQp03Y6Tb4sEZVG1gMg+gQtRCd1T75ZKfVN5qvVAEAd
         wNEwEBl/EIKXg0auBxpidjXNEN7qHuzHfAFrvSh8lzbJnNOmLcrvmH39HHncVJ0HNJ
         X+vjTBpvYbe631vKNhFBsNtEcW3cRsijHQPB8EvSJ9W6s6r2Twnf7UA46q5ek+HNbK
         6Bd9o2P9svh3VLEtqbX7Rbos43lggpFKy7a2FCRWR1YOPwLUZ9Aa+2cSn8K4eQrPjH
         Jyo5sSj9fpCF19kvQzYLiFhicP7ImdLYCNGVB5M3a+vmcMvePrxDE930n17fyT4r80
         l4kaWOls3Jx+g==
Date:   Wed, 6 Dec 2023 16:45:18 +0000
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
Subject: Re: [PATCH v3 0/6] Initial device tree support for StarFive JH8100
 SoC
Message-ID: <20231206-sizzling-whoopee-9e2a6755cd05@spud>
References: <20231201121410.95298-1-jeeheng.sia@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mvCQXmL2zJOZIJ4J"
Content-Disposition: inline
In-Reply-To: <20231201121410.95298-1-jeeheng.sia@starfivetech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mvCQXmL2zJOZIJ4J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 01, 2023 at 08:14:04PM +0800, Sia Jee Heng wrote:
> StarFive JH8100 SoC consists of 4 RISC-V performance Cores (Dubhe-90) and
> 2 RISC-V energy efficient cores (Dubhe-80). It also features various
> interfaces such as DDR4, Gbit-Ether, CAN, USB 3.2, SD/MMC, etc., making it
> ideal for high-performance computing scenarios.
>=20
> This patch series introduces initial SoC DTSI support for the StarFive
> JH8100 SoC. The relevant dt-binding documentation has been updated
> accordingly. Below is the list of IP blocks added in the initial SoC DTSI,
> which can be used for booting via initramfs on FPGA:

This all seems okay to me. I'll need an ack from Emil though before I
can pick it up.

Thanks,
Conor.


--mvCQXmL2zJOZIJ4J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXClHQAKCRB4tDGHoIJi
0nNvAP4yMSbYutcx19sUnchUK4oprRmm58ZSWOHLFlwc38O6IgD6A+QJdSBMlToS
DL2kVUQR6O7/8oliZG8v92JpZ4zIGAM=
=Sstp
-----END PGP SIGNATURE-----

--mvCQXmL2zJOZIJ4J--
