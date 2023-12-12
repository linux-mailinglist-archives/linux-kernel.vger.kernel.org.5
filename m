Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 493EE80F981
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 22:36:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377235AbjLLVg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 16:36:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235148AbjLLVgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 16:36:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644B3CE
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 13:36:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBDC7C433C8;
        Tue, 12 Dec 2023 21:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1702416990;
        bh=/mZFMmbWaIm5/HG4UoTy7RZb9sTq66KkdKm/68yp9Og=;
        h=Date:From:To:Subject:From;
        b=CjFGQhrCbPsNMvZF5qKzcDci+RusrCauNZcUWHaVs8F00AiDVoxg4HjtYjzwVU6zz
         UUI5F0unIw13sOPkQUd+N2D3E6ofS1pYpoL/oogcM5P3KI3k/p9G8bkqeXRXoSSKr+
         CaGnv+HS7noN4m4YGY1xJx4OsJy2hGYADLlPwX6c=
Date:   Tue, 12 Dec 2023 16:36:28 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     users@linux.kernel.org, linux-kernel@vger.kernel.org
Subject: PSA: final vger mailing list migration: Thu, Dec 14, 11AM PST (1900
 UTC)
Message-ID: <20231212-unselfish-real-myna-67e444@lemur>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rdsprqjph6ynk4ba"
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rdsprqjph6ynk4ba
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hello, all:

Over the past few months we've migrated all of the vger.kernel.org mailing
lists, with the exception of the Big One (linux-kernel, aka LKML). This list
alone is responsible for about 80% of all vger mailing list traffic, so we
left it for the last.

This Thursday, December 14, at 11AM Pacific (19:00 UTC), we will switch the MX
record for vger to point to the new location (subspace.kernel.org), which will
complete the mailing list migration from the legacy vger server to the new
infrastructure.

# What to expect on the migration day

This is a non-disruptive process and there should be no interruption in
message delivery. However, there will be a period of about an hour when the
archives on lore.kernel.org/linux-kernel will not be updated due to the
backend archive being moved to the new location. Any messages received during
this period will be added to the archive after the move is completed.

# Saying goodbye to majordomo

The most notable change will be the switch away from majordomo to mlmmj's
native subscription mechanism, described here:

https://subspace.kernel.org/subscribing.html

Any messages sent to majordomo@vger.kernel.org after the migration on Thursday
will generate an automatic bounce explaining what the new process is for
subscribing and unsubscribing.

# What is subspace running?

If you are curious what software is running on subspace, please see this page:

https://subspace.kernel.org/software.html

# Questions, comments?

If you have any questions or concerns, please reply to this message.

-K

--rdsprqjph6ynk4ba
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQR2vl2yUnHhSB5njDW2xBzjVmSZbAUCZXjSXAAKCRC2xBzjVmSZ
bNyGAP4jwwPUr98yI9ZLc38FdkpIdYmEhk9oSsGqVCXlGJDZtAD8DI1QGF1JUrBf
FgyJ8LKD67Y9+k+X8DPHmuOlezcCQg4=
=k9ie
-----END PGP SIGNATURE-----

--rdsprqjph6ynk4ba--
