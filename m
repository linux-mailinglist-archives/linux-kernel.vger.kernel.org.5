Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9987D9E9F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 19:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345987AbjJ0REj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 13:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235163AbjJ0REY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 13:04:24 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED3891BDA
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 10:02:05 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 678E840E01A3;
        Fri, 27 Oct 2023 17:02:02 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id g0nH9nqICLaQ; Fri, 27 Oct 2023 17:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1698426120; bh=VNcaD+xaD/Uk3iWKHp15XINecKx7gQw9fD75w7hCSpM=;
        h=Date:From:To:Cc:Subject:From;
        b=Wx9nBDdfeWXS0kRwqhz6bU3UZlcc7p++HGp4OpM41HCHJxS/4q9wRsgQ5LwZUw8XJ
         sx57ziARKv/OiMBwCBRDVAjtylvwkNlSjGDjsMq9eVBbNHh60NZIR51YuRMEpS75k7
         95OPIiNRcOpnxrhygmPic/XwJtXimd1RbN9eycRrkL2hc8406G7lyr1ESRGw1rxyCG
         hZUxZOUdZYcQOYbS4hP4MjqZKY34jaIGkqcrY98tTAUHJ1t5qwDTYrQh5cFuABTElg
         Yu6kORGDM426caDuDKlD9+pPvdWSVWdK42CTrN1vt488NzgHj9a0FggnJImF0q7ECE
         f36exhJPM0AIMEuV5rti6MKoEbhIGYxt7F6aIzThx8BkppVF/j6C1TLO1t+1kVjhQL
         QJ8xlPj607dlGTjt9obP3uok0/LvDzxeDlOBpjjfoJaeJ3RNiM7dco2griSW8vaRtB
         qeccuF0P02Vln7m5P3/YqCf0W7ccP3DUAgbDcPJcSIOX/sPyuRK7gdD9SVg+08QPdM
         Jxy7oC9uhQEFcSldxAeh2o0/k3NltucWAk4+ULZ+17LL78FoXHhZ1FwM+SaYgaFQj7
         +eQLKlvM3ABRspKmJb30+Hl6uT22Q82yXTtZA5QNRwTiAQ908grYJUAxHLWJ92/1MF
         8+1yZ7/PpWZxwSlI4tRYrLM0=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 35BE940E01A4;
        Fri, 27 Oct 2023 17:01:57 +0000 (UTC)
Date:   Fri, 27 Oct 2023 19:01:51 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/cpu for v6.7
Message-ID: <20231027170151.GOZTvs/wR/47ib4+qe@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull some x86/cpu updates for 6.7.

Thx.

---

The following changes since commit ce9ecca0238b140b88f43859b211c9fdfd8e5b70:

  Linux 6.6-rc2 (2023-09-17 14:40:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cpu_for_6.7_rc1

for you to fetch changes up to b5034c63858d8cb44587bb1ce5a0790a1b4e4a05:

  x86/cpu/amd: Remove redundant 'break' statement (2023-09-29 11:24:09 +0200)

----------------------------------------------------------------
- Make sure the "svm" feature flag is cleared from /proc/cpuinfo when
  virtualization support is disabled in the BIOS on AMD and Hygon
  platforms

- A minor cleanup

----------------------------------------------------------------
Baolin Liu (1):
      x86/cpu/amd: Remove redundant 'break' statement

Paolo Bonzini (1):
      x86/cpu: Clear SVM feature if disabled by BIOS

 arch/x86/include/asm/msr-index.h |  6 +++++-
 arch/x86/include/asm/svm.h       |  6 ------
 arch/x86/kernel/cpu/amd.c        | 11 ++++++++++-
 arch/x86/kernel/cpu/hygon.c      | 10 ++++++++++
 arch/x86/kvm/svm/svm.c           |  8 --------
 5 files changed, 25 insertions(+), 16 deletions(-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
