Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B370A7E2E56
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 21:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233036AbjKFUld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 15:41:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232954AbjKFUlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 15:41:32 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC7A0D51;
        Mon,  6 Nov 2023 12:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1699303285;
        bh=o6I7cBezedI2ImzDegw3KPgDFyTigUe1Gh/16aSYH+8=;
        h=Date:From:To:Cc:Subject:From;
        b=izjWkkG2ePadPFWguzTz1u4u6Uawvwyyj+vw4igfz6WeN9aMGtsdxY7vPJ81uz2Rt
         6hj8+4NvhC199AwRJrIN1WcNu82V8suCcbPu2sQsXf0WJROUc7EeGZhKXnDHLy7VFF
         oLoEmNvl7Nzb2eWM/sdeVEMAEGn+Sdoil4tr0x74tRMhKPxs+nsBJwsQ5nxrbFtii9
         dL601X2hjBuJxGgf0M6TgMPHAjajob/EluKIUJCJqwdLVxIF6OL6orupO1SnBh5UWs
         zfSrLQIzW3RyEk4G/DOYoWzU84TY/aYiZOHFfse8qFvFpRK16BJVNqL+2f6UwBNiS1
         AxCvIIViHOzUg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SPNYK5NBHz4xPh;
        Tue,  7 Nov 2023 07:41:25 +1100 (AEDT)
Date:   Tue, 7 Nov 2023 07:41:20 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jassi Brar <jaswinder.singh@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the mailbox tree
Message-ID: <20231107074120.42fe608b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/honPSc608yLh7ZVF+V+QeED";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/honPSc608yLh7ZVF+V+QeED
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in Linus Torvalds' tree as a different commit
(but the same patch):

  d09f466f71b6 ("dt-bindings: mailbox: qcom-ipcc: document the SM8650 Inter=
-Processor Communication Controller")

This is commit

  96cb7a4e296d ("dt-bindings: mailbox: qcom-ipcc: document the SM8650 Inter=
-Processor Communication Controller")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/honPSc608yLh7ZVF+V+QeED
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVJT3AACgkQAVBC80lX
0Gytywf/R7j6WSOMi2fW5ekyOxMdClm/NPXrT3c/+07GCo306Ad3ukuK13nk8xK9
i8XGNX3WSTx+4fAQqSopBf5N8tFx/7p806c43f0dxRQ/pMrKHOa5ByhJuD/Cjjr9
Wq9iquXe0kWiqmLtqXKnSMx4bjEujUFkicojnbe6dOR+1xgIPKwDJNxWBs6QKT7b
aqluMRxC/tLZKJvpL5qGzbiPtI5QYtFUiTE+vxYCsxty1HxrCPE2SwYrOG7BkWfb
bz2w0kucaVYCwNeNBWe/mV1/KlUFEInwnfur2SZXiS9TtNRAPH5X6+12zXxOJpf2
4A2QN7zleavVzssLGx8IIczZbG3faA==
=oyDX
-----END PGP SIGNATURE-----

--Sig_/honPSc608yLh7ZVF+V+QeED--
