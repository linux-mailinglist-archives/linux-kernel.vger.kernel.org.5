Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 070F37D3CBE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 18:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233024AbjJWQin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 12:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232220AbjJWQil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 12:38:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E6FA1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 09:38:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7ABEC433CB;
        Mon, 23 Oct 2023 16:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698079119;
        bh=It2Eq6456oIB3m4HFRo0jRa19bilUVa2a5KypipIxeM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EdQaMRyntLSGxldGG+JLEtEVXWKr/fwCPY111hx+aAe7OoXA/53XlzPmcQBs0VIXb
         XzVrGgDZooB2U3W6zFr7aPM7dSguAvO6+aqhTGUiApFlRARiqx/sX1dM7rHHw2+VWL
         Gs2DZ0lZmZIQERrqrOo/03HII1e5GG87XxDnkQwTk+B7JgWQ2aUS2DbdyHacgqWcR9
         SgO0uPvjdAYfIOJFLD9y694G0xo7eSYHGOxezoHd7+QU5wrUZKkvgLKJCG/xbjIOpg
         Jl8jaSoEGCePgYlRiAQbjZcRg8UIV7UXtxXEkDOgkzYKpp4Iqyw8V9YxrJ47srIdSV
         oq5P3D8f/7ncA==
Date:   Mon, 23 Oct 2023 09:38:37 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Networking <netdev@vger.kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net v2 1/2] MAINTAINERS: Move M Chetan Kumar to CREDITS
Message-ID: <20231023093837.49c7cb35@kernel.org>
In-Reply-To: <20231023032905.22515-3-bagasdotme@gmail.com>
References: <20231023032905.22515-2-bagasdotme@gmail.com>
        <20231023032905.22515-3-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Oct 2023 10:29:04 +0700 Bagas Sanjaya wrote:
>  M Chetan Kumar <m.chetan.kumar@linux.intel.com> (commit_signer:15/23=65%,authored:14/23=61%)

14 patches authored and 15 signed off?
Let me be more clear this time - nak, please drop this patch.
-- 
pw-bot: cr
