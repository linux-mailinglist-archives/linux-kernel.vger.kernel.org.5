Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88CE87CCAEF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 20:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233170AbjJQSoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 14:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjJQSoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 14:44:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5210190
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 11:44:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDA24C433C8;
        Tue, 17 Oct 2023 18:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697568257;
        bh=HHWmZex85cU8yXPYiJDJZTnRVlsuP4p/QwDdyX/F9hA=;
        h=Date:From:To:Subject:From;
        b=jm9B7Xc8CDGRUzkaEt6w0STR/qaTwK6wPyk4fvatOulGsl4OtJ36PcdD4X28IHmD4
         pCWNzcDkTNEKbP4BB/TPED05FhI4/DFiQ+CVm5gg9WwjCST8Aw8HCbERya7Lb7pJPG
         E2oJR5RxWCe6/6d+ZxGsyAPg8oOOpmu+lLBeypYrKL9O0wOg/mGwbXMJjCChdszwZ5
         vvCxQxKH/EApI/9tBs9sTKwjmw6aDXxvVuaSaNheqb1AhG1BrlomMjlk6ozerIVKt2
         10cfAPFFCJpBdYb1mJ/4UD2+xoEwy9NgNctIwZov2oYPi1HWwfmB7xfgG5/RdoQbw4
         X3q/lQqe9yHxg==
Date:   Tue, 17 Oct 2023 11:44:15 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Prebuilt LLVM 17.0.3 uploaded
Message-ID: <20231017184415.GA1667503@dev-arch.thelio-3990X>
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

I have built and uploaded LLVM 17.0.3 to
https://mirrors.edge.kernel.org/pub/tools/llvm/.

If there are any issues found, please let us know via
email or https://github.com/ClangBuiltLinux/linux/issues/new, so that we
have an opportunity to get them fixed in main and backported before the
17.x series is no longer supported.

Cheers,
Nathan
