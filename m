Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C633676F17A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 20:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbjHCSKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 14:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbjHCSKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 14:10:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7262EAC
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 11:10:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE2F561E67
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 18:10:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 45752C433CD;
        Thu,  3 Aug 2023 18:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691086228;
        bh=Edj37ZXAi47TlAn4TH5nabu1ETrkr+hlACL2kN9s3dk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=H4K+1oxO/Hz1ej7ljDwUGNJ756hzrryx4QOD10HKeGBOsBbpoWBDITD8nkNxg5Jgk
         sj8p75bpH1JOTXKjFaJNvqQShC+QVcz8SbobrIHePG9BXZTBjb2pOe7RP5BjofdZZb
         T+w2UlXErt7jyUOzIvRzg/bHxr1+vNFIDki3PwnhJWjoIkfjYhXUKUIxCtKLZKQmrQ
         TTJFRB0pxY9BFSMOCeEuo5QfM/vz6UbAHg4CTUDMyKqSwWFFaRgaWQnjk7ue8w21sQ
         6sf4+mF0sDDDuR4ZQ9a3mIJXTXJeURC5hBApaiHqU1zRZFdg7aoPzlX+FWDdSt7xls
         861zlAffnuXRQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1E7BEC595C3;
        Thu,  3 Aug 2023 18:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] test/vsock: remove vsock_perf executable on `make clean`
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169108622810.23543.9767560286083111967.git-patchwork-notify@kernel.org>
Date:   Thu, 03 Aug 2023 18:10:28 +0000
References: <20230803085454.30897-1-sgarzare@redhat.com>
In-Reply-To: <20230803085454.30897-1-sgarzare@redhat.com>
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     netdev@vger.kernel.org, AVKrasnov@sberdevices.ru,
        pabeni@redhat.com, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  3 Aug 2023 10:54:54 +0200 you wrote:
> We forgot to add vsock_perf to the rm command in the `clean`
> target, so now we have a left over after `make clean` in
> tools/testing/vsock.
> 
> Fixes: 8abbffd27ced ("test/vsock: vsock_perf utility")
> Cc: AVKrasnov@sberdevices.ru
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> 
> [...]

Here is the summary with links:
  - [net] test/vsock: remove vsock_perf executable on `make clean`
    https://git.kernel.org/netdev/net/c/3c50c8b24039

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


