Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0E377CE46E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 19:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjJRR2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 13:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjJRR2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 13:28:19 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E625E4495
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 10:28:15 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39IHS5H8029782;
        Wed, 18 Oct 2023 12:28:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1697650085;
        bh=behoVI6ahWHU3TqWjsSGM8oZJ95ZNz9rkWsKbXO5RWs=;
        h=Date:From:Subject:To:CC;
        b=AfI8ULhMchemHdd9nK7k7pZer1GodH6euHHx8xPjCXw2/GaqcjJnNrchuhqhcPAi0
         BG8E3kJTc0Chl89+EazXA6EV9BIkXW5RH16iFq3HxYPY+NLdELTvDERls1dU4Y+huN
         kLF9hHKDqeJuw0uk5W1+rhcCqiXYYq3b6BVKAJjY=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39IHS5r0038166
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 18 Oct 2023 12:28:05 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 18
 Oct 2023 12:28:05 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 18 Oct 2023 12:28:05 -0500
Received: from [172.24.227.94] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39IHRr3v021940;
        Wed, 18 Oct 2023 12:28:00 -0500
Message-ID: <9c820e96-21e4-451e-b0ab-a6400d68bdf7@ti.com>
Date:   Wed, 18 Oct 2023 22:58:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From:   Vignesh Raghavendra <vigneshr@ti.com>
Subject: [GIT PULL 2/2] arm64: defconfig: TI K3 updates for v6.7
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm-soc <arm@kernel.org>, SoC <soc@kernel.org>
CC:     Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature";
        boundary="------------AeVk06D7Z64Px7zGqmo1IsqZ"
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------------AeVk06D7Z64Px7zGqmo1IsqZ
Content-Type: multipart/mixed; boundary="------------zVfXdN2sVthLRcqNGDgj9BVs";
 protected-headers="v1"
From: Vignesh Raghavendra <vigneshr@ti.com>
To: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
 arm-soc <arm@kernel.org>, SoC <soc@kernel.org>
Cc: Tero Kristo <kristo@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Nishanth Menon <nm@ti.com>
Message-ID: <9c820e96-21e4-451e-b0ab-a6400d68bdf7@ti.com>
Subject: [GIT PULL 2/2] arm64: defconfig: TI K3 updates for v6.7

--------------zVfXdN2sVthLRcqNGDgj9BVs
Content-Type: multipart/mixed; boundary="------------0ikweu55jeDM3GRjx2XN6lZD"

--------------0ikweu55jeDM3GRjx2XN6lZD
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi ARM SoC maintainers,


The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d=
1d:

  Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git tags/ti-k3=
-config-for-v6.7

for you to fetch changes up to f9010eb938beb9a58c640b50d2fe65e4187c1fde:

  arm64: defconfig: Enable TPS6593 PMIC for SK-AM62A (2023-10-12 12:20:30=
 +0530)

----------------------------------------------------------------
TI K3 defconfig updates

Enable TPS6593 PMIC driver as module to support PMIC on AM62A SK board

----------------------------------------------------------------
Jai Luthra (1):
      arm64: defconfig: Enable TPS6593 PMIC for SK-AM62A

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)


--=20
Regards
Vignesh
--------------0ikweu55jeDM3GRjx2XN6lZD
Content-Type: application/pgp-keys; name="OpenPGP_0xF903332F551A78E9.asc"
Content-Disposition: attachment; filename="OpenPGP_0xF903332F551A78E9.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
K5paG+wIzgINF3s89w=3D=3D
=3D6Uiz
-----END PGP PUBLIC KEY BLOCK-----

--------------0ikweu55jeDM3GRjx2XN6lZD--

--------------zVfXdN2sVthLRcqNGDgj9BVs--

--------------AeVk06D7Z64Px7zGqmo1IsqZ
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEyRC2zAhGcGjrhiNExEYeRXyRFuMFAmUwFaAFAwAAAAAACgkQxEYeRXyRFuN/
CggAoh+HinQ/Ypvh8nUnztKJEN6Vhv4/bOGM3xX+120NhXXiCEtC9yFHhbfYJgEormfSP0UcKmPd
wBpCX51hn2suGbUcJyRfWDUKTR8mS7SdMe4KF2pCk63Bui4XXaZbkYblVj5C/BzxY2QLGw9q/wR8
AO18J6Wm0Y4H+Mz5vqW8a5ov4AP0On2Q1MIchHOUD9YzYP6VRPZ3R3oIOP07VcVk1X7LQEXNRbWq
3eb9xgWKvTEMBc14SgqHBMlnJiY5hmXNgce59Ry/RGcs5psNMqR7UwwHI/GbF/H+MDZZaCF8t7kg
swt5OValy5a5CxpMw/SVyyXbAS4SAbSJbOfkZf4eNg==
=Gf1e
-----END PGP SIGNATURE-----

--------------AeVk06D7Z64Px7zGqmo1IsqZ--
