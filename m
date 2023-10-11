Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0F17C5E10
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 22:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233369AbjJKUL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 16:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbjJKUL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 16:11:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B857A9;
        Wed, 11 Oct 2023 13:11:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE663C433C8;
        Wed, 11 Oct 2023 20:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697055084;
        bh=KHTyZA3X1hgICZ8NOSbKVMUAXQr6TswOUhQ/avm9adI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S2mXSrhkdeQ8KY2B2dPrz+xxlmj9cWvgArZpKDkcxyrl+Q+37w2rZLVdxo/EX3YkP
         Jm0+JXxyFkO/SYEwa5MzmaeePo3oYDF9Nveoih5xE5WrK0K4HXIFcIbPQKRQ3YZhz8
         UwBOn1qIWRHs/5A8khiLbVTCdwQiGuk5xUeWyfwZB5yjP+sGsGQc0iqdmaj0jbEcjU
         q+cpwooBfS/PXTmwjHhJhCYGL4ATkVNxQD9g4yOu/8nzDq2DnqYTpwy576WloKphEL
         T4KsYVDEx8CYLfJG84/uGTmOE9Mp/A/UA40J4W8bGAVsaG1Sp3Tzo7l0uwUqTbjSX3
         0r9pxN7w6jEXA==
Date:   Wed, 11 Oct 2023 22:11:09 +0200
From:   Alejandro Colomar <alx@kernel.org>
To:     Rik van Riel <riel@surriel.com>
Cc:     linux-man@vger.kernel.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org,
        Matthew House <mattlloydhouse@gmail.com>,
        Eric Biederman <ebiederm@xmission.com>
Subject: Using hg and git (Was: [PATCH v4] execve.2: execve also returns
 E2BIG if a string is too long)
Message-ID: <ZScBY7pn5x0xW2_h@debian>
References: <20231011124301.4d93ea72@imladris.surriel.com>
 <20231011125330.13dfe148@imladris.surriel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IitvAL6L1y6x2fRn"
Content-Disposition: inline
In-Reply-To: <20231011125330.13dfe148@imladris.surriel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IitvAL6L1y6x2fRn
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Oct 2023 22:11:09 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Rik van Riel <riel@surriel.com>
Cc: linux-man@vger.kernel.org, kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	Matthew House <mattlloydhouse@gmail.com>,
	Eric Biederman <ebiederm@xmission.com>
Subject: Using hg and git (Was: [PATCH v4] execve.2: execve also returns
 E2BIG if a string is too long)

Hi Rik,

On Wed, Oct 11, 2023 at 12:53:30PM -0400, Rik van Riel wrote:
> Sigh, once again I did a git commit --amend without the latest file chang=
e being
> included. The change below should be good. Working with both git and hg g=
ets me sometimes :/

Been there.  Hate that.  I hope I don't touch hg(1) anymore.  :D

Did you know about git-remote-hg(1)?  It lets you work with hg remotes
without running hg(1) at all.  It had some glitches from time to time
--TBH, I'm not sure if the glitches were from git-remote-hg(1), or just
that hg(1) is crap, or that the maintainers of the hg remote weren't so
good at it--, but nothing too irritating or destructive.

Cheers,
Alex

--=20
<https://www.alejandro-colomar.es/>

--IitvAL6L1y6x2fRn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmUnAV0ACgkQnowa+77/
2zKnVg/9GIFb8v6OOae8qhU0v5H00oSti2zk4HXBAV/Ky+z3m+c0wAp7ueQsjbVB
pLlHIXqX15B4dtSPgJ3uspXG2lFJkCzcZXAyckP9NYlwXL/gn3C+ReKmjOoVW8Q+
K5PLtcZ+mSWbdRj0f+URFC4KJULiRHq+2cl46nivb0tLyu17KDusUtKSOmFfHP54
x0EPFXMBXH+Wid2WqIeIFHF8FS/ELW/cxVVx58am4GO1I0tBFcu+AKWouQwf+Er2
sraBQ00Dbw2T6UBm2hZVa2oCR1CiRHiQzLpcCLbI+Cvvw+/UJL4kWAniR/qm5Vmq
CAwmyWdJW46JDubhVBtL0/14m0kvTRTrGdaFgGaitzOEIw4n+Bc4Uow+3t1a3eEt
4j6auUa+MR3BM9/8vpmixX3OXuHmD99Nh1L2G0x41WbmyuazplTHFT9UuCJz/bUF
8SgPMrBbtLg0VCIRN6KL8+VfLZyeFP5a1OFsBk2O+Jt/dlLS7d4Rj3WmenCtx+tP
E/Ui6DYbKqv3/J/+CQWO93PPs3QC06TrufNzcPrgrIkn+tpxOQaEyX+TUzXNWbmS
t15L/lDlIAKJRrvkg/33zohMsvL1NYxbGS+cDvpcvqjmsQ3Rq6WoMe1pmWQRhijS
PDZ9jRHqSIjrPpETyxEt++eEpRlJ/tsaZImXE7+uAuwqy6w8GNU=
=9AHO
-----END PGP SIGNATURE-----

--IitvAL6L1y6x2fRn--
