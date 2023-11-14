Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 363577EB5C3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 18:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233863AbjKNRox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 12:44:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233890AbjKNRot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 12:44:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7772712A
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 09:44:45 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4152C433C8;
        Tue, 14 Nov 2023 17:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699983885;
        bh=u7EIggPFC8P7kOyA1vN8RHkAmmNvnLPN4H9IF462naQ=;
        h=Date:From:To:Subject:From;
        b=YhVdK4JmOFe2kdv9/0852AwV+Y7y9+sJtRRPO/j0Da6Dg69wkq0Vrm6pEeMTn1way
         k10s+pppUwTFHBWW1ki2FfRudhC6z1nJU7u99Z5dQIIQEGY8+KVK5+aX0N+cGmiRCO
         LGMRez2aHP6h8Qs188tMvA/a5pMMrxG4qzDm4kF5mVKnsqieSkoQAWeq8IQN6vgzq7
         wwZel1NIpmX9qe5n1Dp56RxlTGnTpDmTaSOpMwnBcMQWIaW6iVIoWxjCcFPffXSspt
         LDaL4opIBhKapHOHFJa+bpJKWVIv0ltWssYUqTMnIMfwEK7vSpiZJmJssaA+L0fi39
         lHg2h7PSeTgVg==
Date:   Tue, 14 Nov 2023 10:44:43 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Prebuilt LLVM 17.0.5 uploaded
Message-ID: <20231114174443.GA2423170@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have built and uploaded LLVM 17.0.5 to
https://mirrors.edge.kernel.org/pub/tools/llvm/.

If there are any issues found, please let us know via email or
https://github.com/ClangBuiltLinux/linux/issues/new, so that we have an
opportunity to get them fixed in main and backported before the 17.x
series is no longer supported. 17.0.6 will likely be the final 17.x
release, barring serious bugs being discovered:

https://discourse.llvm.org/t/llvm-17-0-5-released/74906

Cheers,
Nathan
