Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36B1680DC7C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 22:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344974AbjLKVBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 16:01:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344942AbjLKVBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 16:01:31 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772CFB6;
        Mon, 11 Dec 2023 13:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1702328492;
        bh=hb0HJnb7XD64MfXJbiP0E9xbjutUuP/m+xdyI42u0Cg=;
        h=Date:From:To:Cc:Subject:From;
        b=UNtNO0CR9RyCkxXQSsJYz9DkegToLIamuGTe9zD0GyWRf0zfIC+nFGr9RvdK5+o1s
         50xj8IuAHybtVbH+uuqH79xn2Xvmxq91L8H37OQPPaXYwXY88C2v2SpiGaAZeBE8q4
         91p2y/A0ExxF1XU8tHrfWnI0H15Doeqkz0OqdlkXJvV+NKf+TVWuZO5LLF00fqNArj
         gA83GSwE4Ghno/NYydATbPx9w2eW/vKgdftDfMYNtDwmVvw28Oopot4WyfBOa0xLmE
         avldj8cgVjaxRumQjyW4sIJfMSDmxCx7criSwx5LErL2FSokmFUKnyWZRghec0UAye
         WGrI7MF2OU7Sg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SpvLN3BP8z4wc1;
        Tue, 12 Dec 2023 08:01:32 +1100 (AEDT)
Date:   Tue, 12 Dec 2023 08:01:30 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the kunit-next tree
Message-ID: <20231212080130.7607dbc9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/7Sk0TJj3/7sDirx8XIwzMeB";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/7Sk0TJj3/7sDirx8XIwzMeB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in Linus Torvalds' tree as a different
commit (but the same patch):

  b285ba6f8cc1 ("kunit: test: Use an action wrapper instead of a cast")

This is commit

  1bddcf77ce66 ("kunit: test: Avoid cast warning when adding kfree() as an =
action")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/7Sk0TJj3/7sDirx8XIwzMeB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmV3eKoACgkQAVBC80lX
0Gx1yggAmB5JHCPkLijl6vBdUZn/NyTAGHc179BbdUSp55lgRheSmOiG1LncnZaj
vdukdvCzN6MxtemJ2+aMvJF5QGR/QgL5p9wh19BZw54WoH60u7gB6T3tGg0J36tm
eoAZ9sRtMDCEmsHcS1tic4R+Ni3+mvWFaXXV1qvrrj8Qd7mghjsgqwGNTRI0FMK2
XbLt4WwWJjbG4VsYz/aoMLAKjYMhno8pXI91TFD73qlGfObZBbWpnO8ZF2Tvxqi6
iWnDDR7WNgGKUsdLlZTrZ7vwxPEP5au0HC0x89j2L7kdo3KAlQ9vPAP/RezKPHxb
iSO5XulG/DFttupJjd9QXJ/9zwc3VA==
=zOIM
-----END PGP SIGNATURE-----

--Sig_/7Sk0TJj3/7sDirx8XIwzMeB--
