Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCB2A80BD77
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 23:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232122AbjLJV75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 16:59:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjLJV7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 16:59:55 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 333ABCF;
        Sun, 10 Dec 2023 14:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1702245597;
        bh=AUNfz/WUo0mpeLmt0K3ZA76hXqurTm3No7As+VGKfwk=;
        h=Date:From:To:Cc:Subject:From;
        b=YWzrUP3LGSjne2bEXdXp3tizEc+xLNQEVN2NDGmudA/+YyGX89M9lpdN+2x2Byo8v
         G1lj+sfp+XyV2GOFZyCEUPNsGzJFUnBJk40rNq1riPGuFjUpOLtCC9R6CmbKl6Pp8j
         lG6J/ZGDRWbRRoPVgfPpycq2JIfPi+RuKzckRG0Ii3Plw+/NNuMOmTWzQiyYL6fAU1
         yacequgirX0M3mxjKYJuYMDMQDVk7wy6P8/torYWidP3+o6sL/TZnSRFUk+nECMLvH
         1skbaIEKwNjrMo8m//fdZ1FpU9omtrgrMNs0eUmb7wHvp2QnQHp2+wlY1fIslKNw4U
         09aDFn7bLRxgQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SpJhF3JZLz4wd4;
        Mon, 11 Dec 2023 08:59:57 +1100 (AEDT)
Date:   Mon, 11 Dec 2023 08:59:56 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Paolo Bonzini <pbonzini@redhat.com>, KVM <kvm@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the kvm tree
Message-ID: <20231211085956.25bedfe4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/d.2RVOQPXloefmNqMqrVkhd";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/d.2RVOQPXloefmNqMqrVkhd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in Linus Torvalds' tree as different
commits (but the same patches):

  3b99d46a1170 ("KVM: selftests: Actually print out magic token in NX hugep=
ages skip message")
  fc6543bb55d4 ("KVM: selftests: add -MP to CFLAGS")

These are commits

  4a073e813477 ("KVM: selftests: Actually print out magic token in NX hugep=
ages skip message")
  96f124015f82 ("KVM: selftests: add -MP to CFLAGS")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/d.2RVOQPXloefmNqMqrVkhd
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmV2NNwACgkQAVBC80lX
0Gx8qwf/bSEAD8b+ubhA+JFxP5GiDCPawNR13jLf7YtPvXqYsS2Dw2fl+sl1a8Sl
d6WwYoyOhIElm6oNfxX0LoymDXTHx9W6HURip1qCD3vAVMNgAX9QInr/gtGmqSuS
vDbKXGQH0sAAPsQ+nmiN51buWYOKJ+yut7yaLnO6IpGHTrVCTxAjiqwD9dKapLmV
qMkAHjeRl1N5tjOkzm/vNMhOcPJ2EEc+UYRpk9zIFw4TzcvMBOmZVJFf7SBuazbz
fz+hhO0/35YPz0sH1pdpsvF/1SJ9iqQjGWfVi4mVfdBSNmqOzcaBdUqVq6ajHHsk
VhvpkROCC8twJHWtVtH65xCc7um/0g==
=qKtq
-----END PGP SIGNATURE-----

--Sig_/d.2RVOQPXloefmNqMqrVkhd--
