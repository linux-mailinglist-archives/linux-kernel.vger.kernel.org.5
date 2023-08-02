Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F15A376D93E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 23:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbjHBVKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 17:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231833AbjHBVK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 17:10:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC09D273E
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 14:10:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B58C61B29
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 21:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A35E8C433CA;
        Wed,  2 Aug 2023 21:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691010621;
        bh=BdosRve/1vfQeMLTfUBO5k42yoYp/cyiP43a62UOc6U=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=oqumx8W9D+/hwn6ORB/oyhkDY+eEmmWfjtjnUOFva6X0C17qbyxEJy777dS6Fm8zA
         ykk7FWf8KXUoXwWFQeIOvQ9QwPpPj8wt5gTC6+zB8KOQSn55j7SwluR6zsSLMY/h8t
         hjPBsKynmu6iTAGVx5oriJ5zATy9fI07eKwAH09xduV5rchomigR6+7Iwv7AeXAEru
         DxU19I7qVYVy+hX5nq3bAYqmPCpO0tiyYtHtKlMRXhUi3Xi7dzHaz0wE/grqEneCEh
         2AZSjMTpxtpLhnmk0pWadz5VJq64hSTmUXkXYNHC2ZK5GBRiS1IdgOHGdxZChG1Btd
         1pdaq/LBQ/Pbw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8C8C4C6445B;
        Wed,  2 Aug 2023 21:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] libbpf: fix typos in Makefile
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169101062157.23031.3643802072740316226.git-patchwork-notify@kernel.org>
Date:   Wed, 02 Aug 2023 21:10:21 +0000
References: <20230722065236.17010-1-rdunlap@infradead.org>
In-Reply-To: <20230722065236.17010-1-rdunlap@infradead.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, bpf@vger.kernel.org, liuxin350@huawei.com
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

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 21 Jul 2023 23:52:36 -0700 you wrote:
> Capitalize ABI (acronym) and fix spelling of "destination".
> 
> Fixes: 706819495921 ("libbpf: Improve usability of libbpf Makefile")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: bpf@vger.kernel.org
> Cc: Xin Liu <liuxin350@huawei.com>
> 
> [...]

Here is the summary with links:
  - [bpf] libbpf: fix typos in Makefile
    https://git.kernel.org/bpf/bpf-next/c/94e38c956b97

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


