Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8B8B7DB356
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 07:31:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbjJ3Gby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 02:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbjJ3Gbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 02:31:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B43DD67
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 23:31:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05D4DC433C8;
        Mon, 30 Oct 2023 06:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698647470;
        bh=mG4hdp7IHrT4ZQqHYQv1gv+qd3IAd5Xgre7bwsKrd94=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QfTZWcsu5wYJwtIeyyX5O80pKbZUbPVYnWPEfyf4/vd8d+5iIy2GUFPCqCp0gBlFr
         zxObu68aQB+DmUo5gbMunrsTKcozUaMnxXxAtWb+CBBf6gO6T5m5T6tVa7FVT7dZWb
         xH+rWuZ4vsVUebl0kv2At89MlDcSAIhKB+ADQDVDQ4rwHcsRtYTkyAOf7VeWBSxQwR
         vaqrlBG/z7nd3KdMJvtzI14qPuzOeoDd3mdDH+muDIoM8iSQA+UgP/2P0/TVfPLHid
         8+bUV8d2imtbhxasZCq5TbS/0puEFJKYHxZd2uqSovu5cXqji/h66MC5L0QJAFIrnD
         RFJgGXHxMnwgw==
Date:   Sun, 29 Oct 2023 23:31:08 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Shinas Rasheed <srasheed@marvell.com>
Cc:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <hgani@marvell.com>, <vimleshk@marvell.com>, <egallen@redhat.com>,
        <mschmidt@redhat.com>, <pabeni@redhat.com>, <horms@kernel.org>,
        <davem@davemloft.net>, <wizhao@redhat.com>, <konguyen@redhat.com>
Subject: Re: [PATCH net-next v3 0/4] Cleanup and optimizations to transmit
 code
Message-ID: <20231029233108.0bac2231@kernel.org>
In-Reply-To: <20231027121639.2382565-1-srasheed@marvell.com>
References: <20231027121639.2382565-1-srasheed@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Oct 2023 05:16:35 -0700 Shinas Rasheed wrote:
> Pad small packets to ETH_ZLEN before transmit, cleanup dma sync calls,
> add xmit_more functionality and then further remove atomic
> variable usage in the prior.

## Form letter - net-next-closed

The merge window for v6.7 has begun and we have already posted our pull
request. Therefore net-next is closed for new drivers, features, code
refactoring and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens after Nov 12th.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer

