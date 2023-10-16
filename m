Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA7DD7CB5BB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 23:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234087AbjJPVx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 17:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234169AbjJPVxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 17:53:54 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC7AAB;
        Mon, 16 Oct 2023 14:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1697493230;
        bh=tsPyNkr3PX7gFzExIW8NeGHfht4aXAxgEbgtciMhuto=;
        h=Date:From:To:Cc:Subject:From;
        b=DFbwoZYigp9x9IZ79hbaSkmNmVxCLeNaHS2Xgwn3JYLSGcF0im6vBMqmMlPb077/T
         NyNwHz+WntfmYJKd+xV0iiGk2rKMnFh5vCrwrtUOGoBm3A2M4+lxqe/skTm3qr6D6x
         vctXeBASHyiwxMKUdownYHIXMjy3nvHfDWbiUtFEAY9SB25T13qx9afyipAdCSWbO3
         3JaHG5GIi1L8rbkd2VbTUq4dPhVfi3UbgRara6Jn+wn+K4u4xsjDzwP2K1+02/VVts
         QHO05ANV6Ha9uaqUMd8lmGYjv9ZcBy7DqKWY/5AuYYMJl9+mmBlUxCplktnn3EdMnk
         PnOhhdnSouFmA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S8W8Y3VmGz4wcj;
        Tue, 17 Oct 2023 08:53:49 +1100 (AEDT)
Date:   Tue, 17 Oct 2023 08:53:46 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the arm-soc tree
Message-ID: <20231017085346.22917afd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/TxQQwm0Diamqtz79knfG2Bn";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/TxQQwm0Diamqtz79knfG2Bn
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  976868a021ee ("arm64: dts: mediatek: cherry: Configure eDP and internal d=
isplay")
  6b6d5f5665af ("arm64: dts: mediatek: mt6795-xperia-m5: Add DSI Display an=
d its vregs")
  db584927b355 ("arm64: dts: mediatek: mt6795-xperia-m5: Add display backli=
ght support")
  fbb02d40fba8 ("arm64: dts: mediatek: mt6795: Add support for display bloc=
ks and DPI/DSI")
  c09142368d5c ("arm64: dts: mediatek: Add spherion-rev4")
  875da90acd8b ("arm64: dts: mediatek: Add hayato-rev5-sku2")
  97e79c22494e ("arm64: dts: mediatek: Remove asurada-audio dtsi files")
  2e34092e3618 ("dt-bindings: arm64: dts: mediatek: Add rev4 of spherion")
  c4b58b15835a ("dt-bindings: arm64: dts: mediatek: Add rev5-sku2 of hayato=
")
  551dc51e0ca7 ("arm64: dts: mediatek: add iommu support for mt8365 SoC")
  7df428bc887b ("arm64: dts: mediatek: add larb support for mt8365 SoC")
  bcae0e82bbb0 ("arm64: dts: mediatek: add smi support for mt8365 SoC")
  39da9a394be0 ("arm64: dts: mediatek: add power domain support for mt8365 =
SoC")
  56570215f1dc ("arm64: dts: mediatek: add apu support for mt8365 SoC")
  c34fedb34b95 ("arm64: dts: mediatek: add camsys support for mt8365 SoC")
  eb1476c654ba ("arm64: dts: mediatek: add mmsys support for mt8365 SoC")
  142a80a9b568 ("arm64: dts: mediatek: mt8183-kukui: Add PMIC regulator sup=
plies")

are missing a Signed-off-by from their committers.

--=20
Cheers,
Stephen Rothwell

--Sig_/TxQQwm0Diamqtz79knfG2Bn
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUtsOoACgkQAVBC80lX
0GzmrAgAjBVjUOtaG9CpD4eLQzllCQISrUauC0Pxz7vQNDRKkV42xe2/5LQN+FWQ
wL0XhDXGBS6ms1c7SNgKUI8b+1cpLTdC5+GHpaCBbjFaxnYkaPLs4XZ4Egg/3yfm
N94SV75p5WxqrNE3AT+JBymJ39BOphlgedmFAgeB7UJa/OOi1NI9+L0wCJSeyFay
EknyioANNtFU7sWiVDAjDWaf2cBXYJEzae9f2oeF7pxe56076FDnbyCPNd/agdy5
ErHJqHaQrpjkLk4XpwU4y3UT2TFNlw1SsO22/HjcuSdwfG7LSbetA7Nq0Tv8XB6T
LbWM6NmYXxIi8Yd1LjcOyG3GA/hDoQ==
=RhTm
-----END PGP SIGNATURE-----

--Sig_/TxQQwm0Diamqtz79knfG2Bn--
