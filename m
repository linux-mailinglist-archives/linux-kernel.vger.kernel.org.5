Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E288A75826F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 18:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbjGRQuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 12:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbjGRQuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 12:50:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D072019A;
        Tue, 18 Jul 2023 09:50:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6267561626;
        Tue, 18 Jul 2023 16:50:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B3F73C433C7;
        Tue, 18 Jul 2023 16:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689699009;
        bh=gxE+KOgxABDXVFj+Dky4wtJ8UU6gGn71QxvsgZQTZRQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=cuXu0UwNDUrlZou6zs+r30UIay7c4pmYD0oX/bhNxPeZCXfq24+OTUIa8RpU7CNYZ
         bILTnY0cBuNfL5rC5rNzcM5DmVNCAi/ycWk5Oaca5DZ5mpKuZKl2MJ1UAZ7yAtf0Rw
         bk2aQaClG7w1YrVMkjbOhWCz4rqAxJ7HDNbjExVSkBCnNwM0UVkt27IRPTYpvsdqcD
         iMEHuAleisp/CIXjMKs+hX9MM5eeUrTLV+ALS9ctLldOy804YMUkBFdnxhlLnB2b+w
         f0uyHJKBb67z3VMNxQEruGBLanilPfnNDJnB1LppPa3S863kNSeWbk2JDgh488Wpq0
         hcrM/phlBNoEA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 938A8C64458;
        Tue, 18 Jul 2023 16:50:09 +0000 (UTC)
Subject: Re: [GIT PULL] tpmdd changes for v6.5-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230718164348.35519-1-jarkko@kernel.org>
References: <20230718164348.35519-1-jarkko@kernel.org>
X-PR-Tracked-List-Id: <linux-integrity.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230718164348.35519-1-jarkko@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-v6.5-rc3
X-PR-Tracked-Commit-Id: 481c2d14627de8ecbb54dd125466e4b4a5069b47
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f2f393c385af0635eddb58df8bcd645cb6a18f5d
Message-Id: <168969900954.22916.14714113029520178655.pr-tracker-bot@kernel.org>
Date:   Tue, 18 Jul 2023 16:50:09 +0000
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        David Howells <dhowells@redhat.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org, Lino Sanfilippo <l.sanfilippo@kunbus.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 18 Jul 2023 19:43:48 +0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-v6.5-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f2f393c385af0635eddb58df8bcd645cb6a18f5d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
