Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB167CB97E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 06:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234302AbjJQEDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 00:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232411AbjJQEDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 00:03:32 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE568E;
        Mon, 16 Oct 2023 21:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1697515408;
        bh=vY6L67o1M+lk+1IXG4n2Wxcfhns8Gi2hUdwEHjhfXDE=;
        h=Date:From:To:Cc:Subject:From;
        b=HEUWmfAVVSaDVQNvzHebGuTZWJdTS+5muuxnsAcoLLO6sDFTZjO9kOvJqpw1+CghN
         M4ixMysNTiN62kalj6Rglf9xugCef3T+zUxmC0wJnZdACbFfQSFDYDVUrjKmkWZ5ku
         IQS9bBdvugFpqEbYg/p6iEpV+Ul3Jwt17k4/2WeaqD38xbqyiSovJ+ZLouI7BfYvUR
         me/EWZX1mB9EzSrMw486n/jA7WU37IwO2Ws8Ux4psVP5GultOaf9HUJ6f8iZFr/Hvd
         ItR9IeRehzPu+OCNla8dJrWT/hnJU61JyitLx7ZFR1SBf/1C3dTnWy87VfgXqNQcOf
         9NWY0TJeRY4sg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S8gM26gvgz4x1w;
        Tue, 17 Oct 2023 15:03:26 +1100 (AEDT)
Date:   Tue, 17 Oct 2023 15:03:25 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Binbin Wu <binbin.wu@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the kselftest tree
Message-ID: <20231017150325.4a89ab71@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/8z92Rr09d+q8PTb2e+IIzzo";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/8z92Rr09d+q8PTb2e+IIzzo
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in the tip tree as a different commit
(but the same patch):

  197964fc3274 ("selftests/x86/lam: Zero out buffer for readlink()")

This is commit

  29060633411a ("selftests/x86/lam: Zero out buffer for readlink()")

in the tip tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/8z92Rr09d+q8PTb2e+IIzzo
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUuB40ACgkQAVBC80lX
0GxNrgf9FC7rCi3I7v3vM0ohOEspPf+76xIlHanDQ5YBAUTSshzkwdogB54WRGi7
n4NcOP7Xko7lEbh06eZANKNjJrtTXeAokcSILYf2WcLOW+6epV/eNIhJStQI7SoI
m6RE5Y0LRfFfDeFm3DkeDUkVUSGSR1e6LLGmPCKSjlJycTNt2XltUM4pcj9JXlC1
0AFqbFQwqX/amU9Aah2h8361mBIkCNVYM+LBmvWcgM0bUnsor7Kyg2hMauBMV1GP
qHdAMLsTcvmEj+/cBssSuvdi26EXOvDR9uW36fkcvaqvkDTKSsEfu8Sn8tpEej/i
/n9EK5OczKfMBye7XBXZ2l8vwYXYww==
=Oelv
-----END PGP SIGNATURE-----

--Sig_/8z92Rr09d+q8PTb2e+IIzzo--
