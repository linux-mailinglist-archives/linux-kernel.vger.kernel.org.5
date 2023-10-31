Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E806A7DC699
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 07:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236433AbjJaGbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 02:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236240AbjJaGb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 02:31:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DAA2C0;
        Mon, 30 Oct 2023 23:31:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1EC54C433C8;
        Tue, 31 Oct 2023 06:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698733884;
        bh=OwuTtx0ItHxe3rWs/AoMoxVp7i1xEfACsLHLApddvJk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=QlSJ4HKmB62jTMfMLg5jnQcpInkVrQ/ab0Mspmexn+2DGWlG3fgFa2hfohePF60qe
         4bRlSEzFqibC6daVk9ZO/g3bGHfJHzGcegnYYKP7Yl+ms0fT5lrJNX5aig4gQeA6DH
         biyLRBSw8hOKwNKApzTblA9pMAYMyN2Q8bW397e672LICgUjSrye0Tx1UBhnC3wWGN
         7FPMqHHbWbfzBgn7JTlb3N30DkFpd5WCZ/Aml27A3Cv2SlJbPhmPMVRlD4OjpashN0
         bgSYLhgtWAvok1HgpHkyQXNAbKvc5lPAl0F1ayioF+hzh8ftJqKlC4wDdfArsqtqBC
         85B6LCqFIYDvA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 09DA1EAB08A;
        Tue, 31 Oct 2023 06:31:24 +0000 (UTC)
Subject: Re: [GIT PULL] tpmdd changes for v6.7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231024002514.433180-1-jarkko@kernel.org>
References: <20231024002514.433180-1-jarkko@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231024002514.433180-1-jarkko@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-v6.7
X-PR-Tracked-Commit-Id: 03acb9ccec3f8cbcc0ed93c188b7a119ef30ef64
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b9ff774548cd91b45003b3b0d41f15cd52b25509
Message-Id: <169873388403.12768.7313939775437378549.pr-tracker-bot@kernel.org>
Date:   Tue, 31 Oct 2023 06:31:24 +0000
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        David Howells <dhowells@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 24 Oct 2023 03:25:14 +0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-v6.7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b9ff774548cd91b45003b3b0d41f15cd52b25509

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
