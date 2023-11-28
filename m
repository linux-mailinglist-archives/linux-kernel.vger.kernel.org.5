Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C28A07FC46C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 20:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbjK1TtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 14:49:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjK1TtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 14:49:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF021988
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 11:49:12 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA540C433C9;
        Tue, 28 Nov 2023 19:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701200952;
        bh=0qWlYEm567iXs2eilOwywh8HaHw/1Ci10DOobagq90w=;
        h=Date:From:To:Subject:From;
        b=uVRZfQyNaIY1fO+CxL69EMBilKbmSRNS4PeKDEu/nfose8V4S6AXiNSMapCSNNnzk
         BPc1dq5kaFAcN/dSRkN3W1QkXhMJ+uUPJkaeoDBstvAHnbDi1S4cYUjkxcuhSYD8wW
         q/3E9wCYqLoloKlW3YdRjamsIBJgsqTcRg3GKLJ53qpU6h0rWfKBq4Z2pNqwJKCKth
         CHaFi0t+kMYBkzbm4LRad7Kz1FNpFzjnsXbhRW62La4PWxc/HJ8G+Mi5UF+KaQDZ5Q
         TKon4Fo/JeobuWmY8tWT9Qnhy/yy4reA1WNy31CEwDKYSGImyz5nTTA1xe7/NLAbnu
         f0Mf9rt+EXl1A==
Date:   Tue, 28 Nov 2023 12:49:10 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Prebuilt LLVM 17.0.6 uploaded
Message-ID: <20231128194910.GA3062541@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have built and uploaded LLVM 17.0.6 to
https://mirrors.edge.kernel.org/pub/tools/llvm/.

If there are any issues found, please let us know via email or
https://github.com/ClangBuiltLinux/linux/issues/new. 17.0.6 will be the
final 17.x release before 18.0.0 in a couple of months, unless there is
some critical issue uncovered between now and then.

Cheers,
Nathan
