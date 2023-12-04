Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6039803860
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 16:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234230AbjLDPKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 10:10:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234203AbjLDPKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 10:10:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C2F7100
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 07:10:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9ED31C433C9;
        Mon,  4 Dec 2023 15:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701702623;
        bh=yLuE5GhnEWx5vEyz19OFSwOiD3wwpOWWPeMlHaVekZ8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ZZ6zStnoKrzr/9zxY4plsPjoBj6GwejiDm9654JafTvuius4cirVOkTAqioHdGUHe
         xfDGtzK/ARjtVOi7E5bhnAzMkFqAltskxxta2VwbRfPTc65mvuD7iJ/rrrm8wNnVi8
         4vlaH57Qq+mlHGyLTD8uBklvvVqh9Y8Igz6eFQjQUp3WERtKqVlqcgNp2VoD2+eT51
         dhuCBKpjFf2Zlfa/RI9mT5hbqiCFjD380gWpmuO1rlS1SPxMJuEWsFGLbObPjOo1fC
         IirbX1CCFpoBxXwkdUctnmjeNZT+oa7opleiWk6MqL/xshxxHP3Er4z/ZuY6TyIbXL
         I0QSA03yfJZ2Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 80E5EDD4EF1;
        Mon,  4 Dec 2023 15:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH][NEXT] selftests/bpf: Fix spelling mistake "get_signaure_size"
 -> "get_signature_size"
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170170262352.16559.12056527906684806638.git-patchwork-notify@kernel.org>
Date:   Mon, 04 Dec 2023 15:10:23 +0000
References: <20231204093940.2611954-1-colin.i.king@gmail.com>
In-Reply-To: <20231204093940.2611954-1-colin.i.king@gmail.com>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     andrii@kernel.org, mykolal@fb.com, ast@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, shuah@kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Mon,  4 Dec 2023 09:39:40 +0000 you wrote:
> There is a spelling mistake in an ASSERT_GT message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/verify_pkcs7_sig.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [NEXT] selftests/bpf: Fix spelling mistake "get_signaure_size" -> "get_signature_size"
    https://git.kernel.org/bpf/bpf-next/c/153de60e8bfb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


