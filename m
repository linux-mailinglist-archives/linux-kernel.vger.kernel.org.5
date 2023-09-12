Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 544ED79D9EB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 22:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232747AbjILULT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 16:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbjILULO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 16:11:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D30FFE4B;
        Tue, 12 Sep 2023 13:11:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F064FC433C8;
        Tue, 12 Sep 2023 20:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694549470;
        bh=zEtpSUcyobk+lbPFKZijlz8Od7DLQbjQyAKeH7BGqcA=;
        h=From:To:Cc:Subject:Date:From;
        b=Sz/YndxbP/+PswTEiyOMUM81J2IQjCBzNqfvjKYOSjSSXUrEw2C88N2ieX4cIV+uS
         6UyT5x3lLHPgfrulCKGDDDsq2A2koNE6+6wjHuxeKhfYqbD8j6agmPNOrYDCtTDAMg
         4oRF8vilzAQOwWq01LlZL5aaAMVWL8fLX4OtpGllS7EV+GP+OU9oDX2d5r97pLnbR2
         wVb+3iUmIX+5G3k8paCt2bb9Zd/HNS+JTVXAQCvd9rA1cHKFg6ve2BTJrWZx5ZM7b5
         A2SVI1Xa3eASevzyj0kBmVVI7Rx/RQIAhOE6HcZ05BNVoMt44zTd5F0qJW/dPshF+v
         9emtYOf3Yaiwg==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        David Howells <dhowells@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "Justin M . Forbes" <jforbes@fedoraproject.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org
Subject: [GIT PULL] tpmdd changes for v6.6-rc2
Date:   Tue, 12 Sep 2023 23:11:01 +0300
Message-Id: <20230912201102.1012306-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Merge tag 'for-6.6-rc1-tag' of git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux (2023-09-12 11:28:00 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-v6.6-rc2

for you to fetch changes up to ea72883a3bf11fb09dd1ad4f8328cc040263881a:

  tpm: Fix typo in tpmrm class definition (2023-09-12 23:07:37 +0300)

----------------------------------------------------------------
Hi,

This pull request contains a critical fix for my previous pull request.

BR, Jarkko

----------------------------------------------------------------
Justin M. Forbes (1):
      tpm: Fix typo in tpmrm class definition

 drivers/char/tpm/tpm-chip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
