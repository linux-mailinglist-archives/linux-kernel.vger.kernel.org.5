Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 990527A70F9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 05:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232458AbjITDXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 23:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjITDXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 23:23:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0A99F
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 20:23:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 609AEC433C7;
        Wed, 20 Sep 2023 03:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695180179;
        bh=CZNGlwk8El4NyNLGtKLKanjOxlEfzUXc4QahjCELL4w=;
        h=Date:From:To:Subject:From;
        b=pdAw+pM7dGeShqsn9EodB4tRccrdTLlVla4VxYvMBxs/BNnNtsG8kTAea8mef5EA/
         jE/KSbz+D0f8eZosEaQn8KP/7i1+dsfNgbbDgsVA8yHdjjrZw14yLk3MIic2FnOsTu
         mNZO7omTlaLkNrgJUTBuP6vAS+7H4+yFuyIlv7gRNLPGzCpU0Xx8saqpJgxC5eB5N+
         y8mLavqxwD+K3reUtWH616TVG8Rb1WEpIYBp4Bmx/D/ilcfzd3M6pDANSMvmwEp22p
         jNu/T68NLoXVhFKDCvqO1Z5oGDmmCgkZUncohgJCLOF8spuG+BQvh55V25e6QSqPaU
         htCbSYCXdeqxA==
Date:   Tue, 19 Sep 2023 20:22:57 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Prebuilt LLVM 17.0.1 uploaded
Message-ID: <20230920032257.GA472311@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have built and uploaded LLVM 17.0.1 to
https://mirrors.edge.kernel.org/pub/tools/llvm/. This is the first
stable release of the 17.x series, as 17.0.0 final was withdrawn due to
some issue.

If there are any issues found, please let us know via
email or https://github.com/ClangBuiltLinux/linux/issues/new, so that we
have an opportunity to get them fixed in main and backported before the
17.x series is no longer supported.

Cheers,
Nathan
