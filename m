Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1418773025
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 22:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbjHGUKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 16:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbjHGUKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 16:10:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993B0E79;
        Mon,  7 Aug 2023 13:10:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F9BB621DA;
        Mon,  7 Aug 2023 20:10:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8CA6BC433C7;
        Mon,  7 Aug 2023 20:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691439017;
        bh=oDviU0GY1oLKuY5XIx0foAmc1kNuZwvxIuHvyIn11z0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=r6uQYcuSBan+gzdOvwt09TUvNckA87Cf9+/o4dsilvSgNSOJXT5AQE6QI0kKhJ+nu
         gwkM4sm5EvJ5moXs2Rv0PwrbMqd3kJnoyDOEQJB3JfoV2thhcueAhlY3WfGwArXYc8
         HIa81EwN08ovLVVMUDUhr8xFEZwTfJi4sqnNZtqjN+61dSFTCfC9iHvjxNwNkqduTf
         HJCcWY/54aOgi/ZpJaeg+iQ+nSiooDkeq9kh5IQVMRDgsHv65BRZJIc04HsTn0x1Co
         7qsY18zkB9EXOvhj7lrFhM0OrZgAfHsqeuZD0iGybLnpwDCGC35tC+JToHdg16ggGz
         LDm0ZWLkUwyxg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 77B22E505D4;
        Mon,  7 Aug 2023 20:10:17 +0000 (UTC)
Subject: Re: [GIT PULL] tpmdd changes for v6.5-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230807191037.103938-1-jarkko@kernel.org>
References: <20230807191037.103938-1-jarkko@kernel.org>
X-PR-Tracked-List-Id: <linux-integrity.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230807191037.103938-1-jarkko@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-v6.5-rc6
X-PR-Tracked-Commit-Id: e117e7adc637e364b599dc766f1d740698e7e027
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8043e2225aa2ef7c7a04aac129a7ded3b1771aba
Message-Id: <169143901747.15707.18186377689766814168.pr-tracker-bot@kernel.org>
Date:   Mon, 07 Aug 2023 20:10:17 +0000
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon,  7 Aug 2023 19:10:36 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-v6.5-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8043e2225aa2ef7c7a04aac129a7ded3b1771aba

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
